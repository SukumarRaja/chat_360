import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utility/e2ee.dart' as e2ee;
import '../../../config/app_config.dart';
import '../../../config/database_keys.dart';
import '../../../config/database_path.dart';
import '../../../config/limit_constants.dart';
import '../../../provider/observer.dart';
import '../../../provider/timer.dart';
import '../../../translations/language.dart';
import '../../../utility/enum.dart';
import '../../../utility/phone_number_variants.dart';
import '../../../utility/settings.dart';
import '../../themes/app_colors.dart';
import '../../widgets/common_text.dart';
import '../../widgets/common_textform_field.dart';
import '../../widgets/country_code_form_field.dart';
import '../../widgets/simple_button.dart';
import '../home/home.dart';
import '../initial/initial.dart';

class LoginPage extends StatefulWidget {
  const LoginPage(
      {Key? key,
      this.isBlockNewLogins,
      this.isaccountapprovalbyadminneeded,
      this.accountApprovalMessage,
      this.prefs,
      this.isSecuritySetupDone})
      : super(key: key);
  final bool? isBlockNewLogins;
  final bool? isaccountapprovalbyadminneeded;
  final bool? isSecuritySetupDone;
  final String? accountApprovalMessage;
  final SharedPreferences? prefs;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  int currentStatus = 0;
  final TextEditingController phoneNo = TextEditingController();
  final TextEditingController name = TextEditingController();
  String? phoneCode = LimitConstants.defaultCountryCodeNumber;
  bool isCodeSent = false;
  bool isShowCompletedLoading = false;
  int attempt = 1;
  String code = "";
  String? verificationId;
  var mapDeviceInfo = {};
  String? deviceId;
  User? currentUser;
  int currentPinAttempts = 0;
  bool isVerifyingCode = false;



  final storage = const FlutterSecureStorage();

  Future<void> verifyPhoneNumber() async {
    debugPrint("verify phone init");
    final timerProvider = Provider.of<TimerProvider>(context, listen: false);
    verificationCompleted(AuthCredential phoneAuthCredential) {
      isShowCompletedLoading = true;
      setState(() {});
      debugPrint("credential init");

      handleSignIn(authCredential: phoneAuthCredential);
    }

    verificationFailed(FirebaseAuthException authException) {
      setState(() {
        currentStatus = LoginStatus.failure.index;
        phoneNo.clear();
        code = '';
        isCodeSent = false;

        timerProvider.resetTimer();

        isShowCompletedLoading = false;
        isVerifyingCode = false;
        currentPinAttempts = 0;
      });

      debugPrint(
          'Authentication failed -ERROR: ${authException.message}. Try again later.');

      FiberSettings.toast(
          message: 'Authentication failed - ${authException.message}');
    }

    codeSent(String verificationId, [int? forceResendingToken]) async {
      timerProvider.startTimer();
      setState(() {
        currentStatus = LoginStatus.sentSMSCode.index;
        isVerifyingCode = false;
        isCodeSent = true;
      });

      this.verificationId = verificationId;
    }

    codeAutoRetrievalTimeout(String verificationId) {
      this.verificationId = verificationId;
      setState(() {
        currentStatus = LoginStatus.failure.index;
        phoneNo.clear();
        code = '';
        name.text = '';
        isCodeSent = false;

        timerProvider.resetTimer();

        isShowCompletedLoading = false;
        isVerifyingCode = false;
        currentPinAttempts = 0;
      });

      FiberSettings.toast(
          message: 'Authentication failed Timeout. please try again.');
    }

    print('Verify phone triggered');
    try {
      await firebaseAuth.verifyPhoneNumber(
          phoneNumber: (phoneCode! + phoneNo.text).trim(),
          timeout: const Duration(seconds: LimitConstants.timeOutSeconds),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      FiberSettings.toast(message: 'NEW CATCH $e');
    }
  }

  Future<void> handleSignIn({AuthCredential? authCredential}) async {
    print("singing credential init");
    setState(() {
      isShowCompletedLoading = true;
    });
    var phone = (phoneCode! + phoneNo.text).trim();

    try {
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId!, smsCode: code);
      print("entered code is $code");

      UserCredential firebaseUser =
          await firebaseAuth.signInWithCredential(credential);
      print("credential details is ${credential.providerId}");

      // ignore: unnecessary_null_comparison
      if (firebaseUser != null) {
        print("firebase user not null checked");
        // Check is already sign up
        final QuerySnapshot result = await FirebaseFirestore.instance
            .collection(DatabasePath.fireStoreCollectionUsers)
            .where(DatabaseKeys.id, isEqualTo: firebaseUser.user!.uid)
            .get();
        final List documents = result.docs;
        print("firestore result is ${result.docs[0].id}");
        print("firestore result is ${result}");
        print("firestore result is ${result.docs[0].id}");
        final pair = await const e2ee.X25519().generateKeyPair();

        if (documents.isEmpty) {
          print("documents empty check");
          await storage.write(
              key: DatabaseKeys.privateKey, value: pair.secretKey.toBase64());
          // Update data to server if new user
          await FirebaseFirestore.instance
              .collection(DatabasePath.fireStoreCollectionUsers)
              .doc(phone)
              .set({
            DatabaseKeys.publicKey: pair.publicKey.toBase64(),
            DatabaseKeys.privateKey: pair.secretKey.toBase64(),
            DatabaseKeys.countryCode: phoneCode,
            DatabaseKeys.nickName: name.text.trim(),
            DatabaseKeys.photoUrl: firebaseUser.user!.photoURL ?? '',
            DatabaseKeys.id: firebaseUser.user!.uid,
            DatabaseKeys.phone: phoneNo,
            DatabaseKeys.phoneRaw: phoneNo.text,
            DatabaseKeys.authenticationType: AuthenticationType.passcode.index,
            DatabaseKeys.aboutMe: "",
            //---Additional fields added for Admin app compatible----
            DatabaseKeys.accountStatus:
                widget.isaccountapprovalbyadminneeded == true
                    ? DatabaseKeys.statusPending
                    : DatabaseKeys.statusAllowed,
            DatabaseKeys.actionMessage: widget.accountApprovalMessage,
            DatabaseKeys.lastLogin: DateTime.now().millisecondsSinceEpoch,
            DatabaseKeys.joinedOn: DateTime.now().millisecondsSinceEpoch,
            DatabaseKeys.searchKey:
                name.text.trim().substring(0, 1).toUpperCase(),
            DatabaseKeys.videoCallMade: 0,
            DatabaseKeys.videoCallReceived: 0,
            DatabaseKeys.audioCallMade: 0,
            DatabaseKeys.groupsCreated: 0,
            DatabaseKeys.blockedUsersList: [],
            DatabaseKeys.audioCallReceived: 0,
            DatabaseKeys.messageSent: 0,
            DatabaseKeys.deviceDetails: mapDeviceInfo,
            DatabaseKeys.currentDeviceId: deviceId,
            DatabaseKeys.phoneNumberVariants: phoneNumberVariantsList(
                countryCode: phoneCode, phoneNumber: phoneNo.text)
          }, SetOptions(merge: true));
          currentUser = firebaseUser.user;

          await FirebaseFirestore.instance
              .collection(DatabasePath.fireStoreCollectionDatabase)
              .doc(DatabasePath.usersCount)
              .set(
                  widget.isaccountapprovalbyadminneeded == false
                      ? {
                          DatabaseKeys.totalApprovedUsers:
                              FieldValue.increment(1),
                        }
                      : {
                          DatabaseKeys.totalPendingUsers:
                              FieldValue.increment(1),
                        },
                  SetOptions(merge: true));

          await FirebaseFirestore.instance
              .collection(DatabasePath.countryWiseData)
              .doc(phoneCode)
              .set({
            DatabaseKeys.totalUsers: FieldValue.increment(1),
          }, SetOptions(merge: true));

          await FirebaseFirestore.instance
              .collection(DatabasePath.fireStoreCollectionNotification)
              .doc(DatabasePath.adminNotification)
              .update({
            DatabaseKeys.notificationAction: 'PUSH',
            DatabaseKeys.notificationDescription: widget
                        .isaccountapprovalbyadminneeded ==
                    true
                ? '${name.text.trim()} has Joined ${AppConfig.appName}. APPROVE the user account. You can view the user profile from All Users List.'
                : '${name.text.trim()} has Joined ${AppConfig.appName}. You can view the user profile from All Users List.',
            DatabaseKeys.notificationTitle: 'New User Joined',
            DatabaseKeys.notificationImageUrl: null,
            DatabaseKeys.notificationLastUpdate: DateTime.now(),
            'list': FieldValue.arrayUnion([
              {
                DatabaseKeys.docId:
                    DateTime.now().millisecondsSinceEpoch.toString(),
                DatabaseKeys.notificationDescription: widget
                            .isaccountapprovalbyadminneeded ==
                        true
                    ? '${name.text.trim()} has Joined ${AppConfig.appName}. APPROVE the user account. You can view the user profile from All Users List.'
                    : '${name.text.trim()} has Joined ${AppConfig.appName}. You can view the user profile from All Users List.',
                DatabaseKeys.notificationTitle: 'New User Joined',
                DatabaseKeys.notificationImageUrl: null,
                DatabaseKeys.notificationLastUpdate: DateTime.now(),
                DatabaseKeys.notificationAuthor:
                    '${currentUser!.uid} userapp',
              }
            ])
          });

          // Write data to local
          await widget.prefs!.setString(DatabaseKeys.id, currentUser!.uid);
          await widget.prefs!
              .setString(DatabaseKeys.nickName, name.text.trim());
          await widget.prefs!
              .setString(DatabaseKeys.photoUrl, currentUser!.photoURL ?? '');
          await widget.prefs!.setString(DatabaseKeys.phone, phone);
          await widget.prefs!.setString(DatabaseKeys.countryCode, phoneCode!);
          String? fcmToken = await FirebaseMessaging.instance.getToken();

          await FirebaseFirestore.instance
              .collection(DatabasePath.fireStoreCollectionUsers)
              .doc(phone)
              .set({
            DatabaseKeys.notificationTokens: [fcmToken]
          }, SetOptions(merge: true));
          await (widget.prefs!.setBool(DatabaseKeys.isTokenGenerated, true));

          await (Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (newContext) => const HomePage(
                      // currentUserNo: phoneNo,
                      // isSecuritySetupDone: true,
                      // prefs: widget.prefs,
                      ))));
          await widget.prefs!
              .setString(DatabaseKeys.isSecuritySetupDone, phone);
          await subscribeToNotification(documents[0][DatabaseKeys.phone], true);
        }
        else {
          await storage.write(
              key: DatabaseKeys.privateKey,
              value: documents[0][DatabaseKeys.privateKey]);
          String? fcmToken = await FirebaseMessaging.instance.getToken();

          await FirebaseFirestore.instance
              .collection(DatabasePath.fireStoreCollectionUsers)
              .doc(phone)
              .update(
                !documents[0].data().containsKey(DatabaseKeys.deviceDetails)
                    ? {
                        DatabaseKeys.authenticationType:
                            AuthenticationType.passcode.index,
                        DatabaseKeys.accountStatus:
                            widget.isaccountapprovalbyadminneeded == true
                                ? DatabaseKeys.statusPending
                                : DatabaseKeys.statusAllowed,
                        DatabaseKeys.actionMessage:
                            widget.accountApprovalMessage,
                        DatabaseKeys.lastLogin:
                            DateTime.now().millisecondsSinceEpoch,
                        DatabaseKeys.joinedOn:
                            documents[0].data()![DatabaseKeys.lastSeen] != true
                                ? documents[0].data()![DatabaseKeys.lastSeen]
                                : DateTime.now().millisecondsSinceEpoch,
                        DatabaseKeys.nickName: name.text.trim(),
                        DatabaseKeys.searchKey:
                            name.text.trim().substring(0, 1).toUpperCase(),
                        DatabaseKeys.videoCallMade: 0,
                        DatabaseKeys.videoCallReceived: 0,
                        DatabaseKeys.audioCallMade: 0,
                        DatabaseKeys.audioCallReceived: 0,
                        DatabaseKeys.messageSent: 0,
                        DatabaseKeys.deviceDetails: mapDeviceInfo,
                        DatabaseKeys.currentDeviceId: deviceId,
                        DatabaseKeys.phoneNumberVariants:
                            phoneNumberVariantsList(
                                countryCode: documents[0]
                                    .data()![DatabaseKeys.countryCode],
                                phoneNumber: documents[0]
                                    .data()![DatabaseKeys.phoneRaw]),
                        DatabaseKeys.notificationTokens: [fcmToken],
                      }
                    : {
                        DatabaseKeys.searchKey:
                            name.text.trim().substring(0, 1).toUpperCase(),
                        DatabaseKeys.nickName: name.text.trim(),
                        DatabaseKeys.authenticationType:
                            AuthenticationType.passcode.index,
                        DatabaseKeys.lastLogin:
                            DateTime.now().millisecondsSinceEpoch,
                        DatabaseKeys.deviceDetails: mapDeviceInfo,
                        DatabaseKeys.currentDeviceId: deviceId,
                        DatabaseKeys.phoneNumberVariants:
                            phoneNumberVariantsList(
                                countryCode: documents[0]
                                    .data()![DatabaseKeys.countryCode],
                                phoneNumber: documents[0]
                                    .data()![DatabaseKeys.phoneRaw]),
                        DatabaseKeys.notificationTokens: [fcmToken],
                      },
              );
          // Write data to local
          await widget.prefs!
              .setString(DatabaseKeys.id, documents[0][DatabaseKeys.id]);
          await widget.prefs!
              .setString(DatabaseKeys.nickName, name.text.trim());
          await widget.prefs!.setString(
              DatabaseKeys.photoUrl, documents[0][DatabaseKeys.photoUrl] ?? '');
          await widget.prefs!.setString(
              DatabaseKeys.aboutMe, documents[0][DatabaseKeys.aboutMe] ?? '');
          await widget.prefs!
              .setString(DatabaseKeys.phone, documents[0][DatabaseKeys.phone]);

          if (widget.isSecuritySetupDone == false) {
            await (Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (newContext) => const HomePage(
                          // currentUserNo: phoneNo,
                          // isSecuritySetupDone: true,
                          // prefs: widget.prefs,
                        ))));
            await widget.prefs!
                .setString(DatabaseKeys.isSecuritySetupDone, phone);
            await subscribeToNotification(phone, false);
          } else {
            await (Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const InitialPage())));
            // FiberSettings.toast(getTranslated(context, 'welcomeback'));
            FiberSettings.toast(message: "Welcome back");
            await subscribeToNotification(
                documents[0][DatabaseKeys.phone], false);
          }
        }
      }
      else {
        // FiberChatSettings.toast(getTranslated(context, 'failedlogin'));
        FiberSettings.toast(message: "Failed to Log In");
      }
    }
    catch (e) {
      setState(() {
        if (currentPinAttempts >= 4) {
          currentStatus = LoginStatus.failure.index;
          // _phoneNo.clear();
          // _code = '';
          isCodeSent = false;
        }

        isShowCompletedLoading = false;
        isVerifyingCode = false;
        currentPinAttempts++;
      });
      if (e.toString().contains('invalid') ||
          e.toString().contains('code') ||
          e.toString().contains('verification')) {
        // FiberSettings.toast(getTranslated(context, 'makesureotp')
        FiberSettings.toast(
            message:
                "Make sure your Phone Number/OTP Code is correct and try again later");
      }
    }
  }

  subscribeToNotification(String currentUserNo, bool isFreshNewAccount) async {
    await FirebaseMessaging.instance
        .subscribeToTopic(currentUserNo.replaceFirst(RegExp(r'\+'), ''))
        .catchError((err) {
      print('ERROR SUBSCRIBING NOTIFICATION$err');
    });
    await FirebaseMessaging.instance
        .subscribeToTopic(DatabaseKeys.topicUsers)
        .catchError((err) {
      print('ERROR SUBSCRIBING NOTIFICATION$err');
    });
    await FirebaseMessaging.instance
        .subscribeToTopic(Platform.isAndroid
            ? DatabaseKeys.topicUsersAndroid
            : Platform.isIOS
                ? DatabaseKeys.topicUsersIos
                : DatabaseKeys.topicUsersWeb)
        .catchError((err) {
      print('ERROR SUBSCRIBING NOTIFICATION$err');
    });

    if (isFreshNewAccount == false) {
      await FirebaseFirestore.instance
          .collection(DatabasePath.fireStoreCollectionGroup)
          .where(DatabaseKeys.groupMemberList, arrayContains: currentUserNo)
          .get()
          .then((query) async {
        if (query.docs.isNotEmpty) {
          query.docs.forEach((doc) async {
            await FirebaseMessaging.instance
                .subscribeToTopic(
                    "GROUP${doc[DatabaseKeys.groupId].replaceAll(RegExp('-'), '').substring(1, doc[DatabaseKeys.groupId].replaceAll(RegExp('-'), '').toString().length)}")
                .catchError((err) {
              print('ERROR SUBSCRIBING NOTIFICATION$err');
            });
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(this.context).size.width;
    var h = MediaQuery.of(this.context).size.height;
    return FiberSettings.getNTPWrappedWidget(Scaffold(
      backgroundColor: AppConfig.designType == ThemeType.whatsapp
          ? AppColors.deepGreen
          : AppColors.chattingWhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [customClipPath(w, h), buildCurrentWidget(w)],
            )
          ],
        ),
      ),
    ));
  }

  customClipPath(double w, double h) {
    return ClipPath(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        height: 400,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: AppConfig.designType == ThemeType.whatsapp
                  ? [
                      AppColors.chattingGreen,
                      AppColors.deepGreen,
                    ]
                  : [
                      AppColors.chattingWhite,
                      AppColors.chattingWhite,
                    ]),
        ),
        child: Column(
          children: [
            SizedBox(
              height: Platform.isIOS ? 0 : 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Language.languageList().length < 2
                      ? const SizedBox(height: 40)
                      : Container(
                          alignment: Alignment.centerRight,
                          margin: const EdgeInsets.only(top: 4, right: 10),
                          width: 190,
                          padding: const EdgeInsets.all(8),
                          child: DropdownButton<Language>(
                            underline: const SizedBox(),
                            icon: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.language_outlined,
                                  color:
                                      AppConfig.designType == ThemeType.whatsapp
                                          ? AppColors.chattingWhite
                                          : AppColors.chattingBlack
                                              .withOpacity(0.8),
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                const SizedBox(
                                  width: 15,
                                  child: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: AppColors.lightGreen,
                                    size: 27,
                                  ),
                                )
                              ],
                            ),
                            onChanged: (Language? language) {
                              // _changeLanguage(language!);
                            },
                            items: Language.languageList()
                                .map<DropdownMenuItem<Language>>(
                                  (e) => DropdownMenuItem<Language>(
                                    value: e,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                            '${e.languageNameInEnglish}  ${e.flag} '),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                ],
              ),
            ),
            SizedBox(
              height: w > h ? 0 : 15,
            ),
            w < h
                ? Image.asset(
                    AppConfig.appLogo,
                    width: w / 1.3,
                  )
                : Image.asset(
                    AppConfig.appLogo,
                    height: h / 6,
                  ),
            const SizedBox(
              height: 0,
            ),
          ],
        ),
      ),
    );
  }

  buildCurrentWidget(double w) {
    if (currentStatus == LoginStatus.sendSmsCode.index) {
      return nameWidget(w);
    } else if (currentStatus == LoginStatus.sendingSmsCode.index) {
      return sendSmsCode();
    } else if (currentStatus == LoginStatus.sentSMSCode.index) {
      return otpWidget();
    } else if (currentStatus == LoginStatus.verifyingSmsCode.index) {
      return verifyingCode();
    } else if (currentStatus == LoginStatus.sendingSmsCode.index) {
      return sendSmsCode();
    } else {
      return nameWidget(w);
    }
  }

  nameWidget(double w) {
    return Consumer<ObserverProvider>(
        builder: (context, observer, _) => Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3.0,
                        color: AppConfig.designType == ThemeType.whatsapp
                            ? AppColors.deepGreen.withOpacity(0.3)
                            : AppColors.chattingBlack.withOpacity(0.1),
                        spreadRadius: 1.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.fromLTRB(15,
                      MediaQuery.of(this.context).size.height / 2.50, 16, 0),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 13,
                      ),
                      Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        // height: 63,
                        height: 83,
                        width: w / 1.24,
                        child: CommonTextFormField(
                          inputFormatter: [
                            LengthLimitingTextInputFormatter(25),
                          ],
                          controller: name,
                          leftRightMargin: 0,
                          showIconBoundary: false,
                          boxCornerRadius: 5.5,
                          boxHeight: 50,
                          // hintText: getTranslated(this.context, 'name_hint'),
                          hintText: "Name",
                          prefixIconButton: Icon(
                            Icons.person,
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(5),
                        // padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        // height: 63,
                        height: 63,
                        width: w / 1.24,
                        child: Form(
                          // key: _enterNumberFormKey,
                          child: CountryCodeTextFormField(
                            maxLength: 10,
                            buttonHintTextColor: AppColors.grey,
                            borderColor: AppColors.grey.withOpacity(0.2),
                            controller: phoneNo,
                            initialCountryCode:
                                LimitConstants.defaultCountryCodeIso,
                            onSaved: (phone) {
                              setState(() {
                                phoneCode = phone!.countryCode;
                              });
                            },
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(17),
                        child: CommonText(
                          text: "Send SmsCode",
                          // getTranslated(this.context, 'sendsmscode'),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(17, 22, 17, 5),
                        child: CommonSimpleButton(
                            spacing: 0.3,
                            height: 57,
                            buttonColor:
                                AppConfig.designType == ThemeType.whatsapp
                                    ? AppColors.lightGreen
                                    : AppColors.lightGreen,
                            // buttonText: getTranslated(this.context, 'sendverf'),
                            buttonText: "Send Verification Code",
                            onPressed: () {
                              if (widget.isBlockNewLogins == true) {
                                FiberSettings.toast(message: "Login Disabled"
                                    // getTranslated(
                                    //     this.context, 'logindisabled'),
                                    );
                              } else {
                                final timerProvider =
                                    Provider.of<TimerProvider>(context,
                                        listen: false);

                                setState(() {});
                                RegExp e164 = RegExp(r'^\+[1-9]\d{1,14}$');
                                if (name.text.trim().isNotEmpty) {
                                  String phone = phoneNo.text.toString().trim();
                                  if (phone.isNotEmpty &&
                                      e164.hasMatch(phoneCode! + phone)) {
                                    if (phone.startsWith('0') &&
                                        phoneCode == '+81') {
                                      timerProvider.resetTimer();
                                      setState(() {
                                        phone = phone.substring(1);
                                        phoneNo.text = phone;
                                        currentStatus =
                                            LoginStatus.sendingSmsCode.index;
                                        isCodeSent = false;
                                      });

                                      verifyPhoneNumber();
                                    } else {
                                      timerProvider.resetTimer();
                                      setState(() {
                                        currentStatus =
                                            LoginStatus.sendingSmsCode.index;
                                        isCodeSent = false;
                                      });
                                      verifyPhoneNumber();
                                    }
                                  } else {
                                    FiberSettings.toast(
                                        message: "Enter Valid Mobile Number"
                                        // getTranslated(
                                        //     this.context, 'entervalidmob'),
                                        );
                                  }
                                } else {
                                  FiberSettings.toast(
                                      message: "Name cannot be empty"
                                      // getTranslated(this.context, 'nameem');
                                      );
                                }
                              }
                            }),
                      ),

                      //
                      const SizedBox(
                        height: 18,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  width: w * 0.95,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                            // text: '${getTranslated(this.context, 'agree')} \n',
                            text: 'By continuing, you agree with the \n',
                            style: TextStyle(
                                color: AppConfig.designType ==
                                        ThemeType.whatsapp
                                    ? AppColors.chattingWhite.withOpacity(0.8)
                                    : AppColors.chattingBlack.withOpacity(0.8),
                                fontWeight: FontWeight.w400,
                                fontSize: 14.0,
                                height: 1.7)),
                        TextSpan(
                            // text: getTranslated(this.context, 'tnc'),
                            text: "Terms & Conditions",
                            style: const TextStyle(
                                height: 1.7,
                                color: AppColors.lightGreen,
                                fontWeight: FontWeight.w700,
                                fontSize: 14.8),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                if (LimitConstants.connectWithAdminApp ==
                                    false) {
                                  launch(AppConfig.termsAndConditionsUrl);
                                } else {
                                  final observer =
                                      Provider.of<ObserverProvider>(
                                          this.context,
                                          listen: false);
                                  if (observer.tncType == 'url') {
                                    if (observer.tnc == null) {
                                      launch(AppConfig.termsAndConditionsUrl);
                                    } else {
                                      launch(observer.tnc!);
                                    }
                                  } else if (observer.tncType == 'file') {
                                    // Navigator.push(
                                    //     this.context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           PDFViewerCachedFromUrl(
                                    //             title: getTranslated(
                                    //                 this.context, 'tnc'),
                                    //             url: observer.tnc,
                                    //             isregistered: false,
                                    //           ),
                                    //     ));
                                  }
                                }
                              }),
                        TextSpan(
                            text: '  ○  ',
                            style: TextStyle(
                                height: 1.7,
                                color: AppConfig.designType ==
                                        ThemeType.whatsapp
                                    ? AppColors.chattingWhite.withOpacity(0.79)
                                    : AppColors.chattingBlack.withOpacity(0.79),
                                fontWeight: FontWeight.w500,
                                fontSize: 11.8)),
                        TextSpan(
                            // text: getTranslated(this.context, 'pp'),
                            text: "Privacy Policy",
                            style: const TextStyle(
                                height: 1.7,
                                color: AppColors.lightGreen,
                                fontWeight: FontWeight.w700,
                                fontSize: 14.8),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                if (LimitConstants.connectWithAdminApp ==
                                    false) {
                                  launchUrl(
                                      Uri.parse(AppConfig.privacyPolicyUrl));
                                } else {
                                  if (observer.privacyPolicyType == 'url') {
                                    if (observer.privacyPolicy == null) {
                                      launchUrl(Uri.parse(
                                          AppConfig.privacyPolicyUrl));
                                    } else {
                                      launchUrl(
                                          Uri.parse(observer.privacyPolicy!));
                                    }
                                  } else if (observer.privacyPolicyType ==
                                      'file') {
                                    // Navigator.push(
                                    //     this.context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           PDFViewerCachedFromUrl(
                                    //             title: getTranslated(
                                    //                 this.context, 'pp'),
                                    //             url: observer.privacyPolicy,
                                    //             isregistered: false,
                                    //           ),
                                    //     ));
                                  }
                                }
                              }),
                      ],
                    ),
                  ),
                ),
              ],
            ));
  }

  sendSmsCode() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 3.0,
            color: AppConfig.designType == ThemeType.whatsapp
                ? AppColors.chattingGreen.withOpacity(0.3)
                : AppColors.chattingBlack.withOpacity(0.1),
            spreadRadius: 1.0,
          ),
        ],
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      margin: EdgeInsets.fromLTRB(
          15, MediaQuery.of(context).size.height / 2.50, 16, 0),
      child: Column(
        children:  [
          const SizedBox(
            height: 13,
          ),
          Padding(
            padding: const EdgeInsets.all(17),
            child: CommonText(
                text: "Sending Code to $phoneCode-${phoneNo.text}",
                // '${getTranslated(context, 'sending_code')} $phoneCode-${_phoneNo.text}',
                textAlign: TextAlign.center,
                height: 1.5),
          ),
          const SizedBox(
            height: 30,
          ),
          const Center(
            child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(AppColors.lightGreen)),
          ),
          const SizedBox(
            height: 48,
          ),
        ],
      ),
    );
  }

  otpWidget() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 3.0,
            color: AppConfig.designType == ThemeType.whatsapp
                ? AppColors.chattingGreen.withOpacity(0.3)
                : AppColors.chattingBlack.withOpacity(0.1),
            spreadRadius: 1.0,
          ),
        ],
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      margin: EdgeInsets.fromLTRB(
          15, MediaQuery.of(context).size.height / 2.50, 16, 0),
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 13,
          ),

          Container(
            margin: const EdgeInsets.all(25),
            // height: 70,
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: PinFieldAutoFill(
                codeLength: 6,
                decoration: UnderlineDecoration(
                  bgColorBuilder:
                      FixedColorBuilder(AppColors.grey.withOpacity(0.1)),
                  textStyle: const TextStyle(
                      fontSize: 22,
                      color: AppColors.chattingBlack,
                      fontWeight: FontWeight.bold),
                  colorBuilder:
                      FixedColorBuilder(AppColors.grey.withOpacity(0.1)),
                ),
                currentCode: code,
                onCodeSubmitted: (codes) {
                  setState(() {
                    code = codes;
                  });
                  if (codes.length == 6) {
                    setState(() {
                      currentStatus = LoginStatus.verifyingSmsCode.index;
                    });
                    debugPrint("init phone otp check");
                    handleSignIn();
                  } else {
                    FiberSettings.toast(message: "Enter Correct Code"
                        // getTranslated(context, 'correctotp')
                        );
                  }
                },
                onCodeChanged: (codes) {
                  print("enterd code is $codes");
                  if (codes!.length == 6) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    setState(() {
                      code = codes;
                    });
                  }
                },
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.all(17),
            child: CommonText(
                text: "Enter Verification Code",
                // '${getTranslated(context, 'enter_verfcode')} $phoneCode-${_phoneNo.text}',
                textAlign: TextAlign.center,
                height: 1.5

                // style: TextStyle(color: Mycolors.black),
                ),
          ),
          isShowCompletedLoading == true
              ? const Center(
                  child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColors.lightGreen)),
                )
              : Padding(
                  padding: const EdgeInsets.fromLTRB(17, 22, 17, 5),
                  child: CommonSimpleButton(
                    height: 57,
                    buttonColor: AppConfig.designType == ThemeType.whatsapp
                        ? AppColors.lightGreen
                        : AppColors.lightGreen,
                    // buttonText: getTranslated(context, 'verify_otp'),
                    buttonText: "Verify Otp",
                    onPressed: () {
                      if (code.length == 6) {
                        setState(() {
                          isVerifyingCode = true;
                        });
                        handleSignIn();
                      } else {
                        FiberSettings.toast(message: "Enter Correct Code");
                        // getTranslated(context, 'correctotp');
                      }
                    },
                  ),
                ),
          const SizedBox(
            height: 20,
          ),
          isShowCompletedLoading == true
              ? const SizedBox(
                  height: 36,
                )
              : Consumer<TimerProvider>(
                  builder: (context, timerProvider, _) => timerProvider.wait ==
                              true &&
                          isCodeSent == true
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                          child: RichText(
                              text:  TextSpan(
                            children: [
                              const TextSpan(
                                // text: getTranslated(this.context, 'resendcode'),
                                text: "Resend Code",
                                style: TextStyle(
                                    fontSize: 14, color: AppColors.grey),
                              ),
                              TextSpan(
                                text: " 00:${timerProvider.start} ",
                                // text: "00:",
                                style: const TextStyle(
                                    fontSize: 15,
                                    color: AppColors.lightGreen,
                                    fontWeight: FontWeight.w700),
                              ),
                              const TextSpan(
                                // text: getTranslated(this.context, 'seconds'),
                                text: "Seconds",
                                style: TextStyle(
                                    fontSize: 14, color: AppColors.grey),
                              ),
                            ],
                          )),
                        )
                      : timerProvider.isActionBarShow == false
                          ? const SizedBox(
                              height: 35,
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                    onTap: () {
                                      // final timerProvider =
                                      // Provider.of<TimerProvider>(context,
                                      //     listen: false);
                                      // timerProvider.resetTimer();
                                      // unawaited(Navigator.pushReplacement(
                                      //     this.context,
                                      //     MaterialPageRoute(
                                      //         builder: (newContext) => HomePage(
                                      //           currentUserNo: null,
                                      //           isSecuritySetupDone: false,
                                      //           prefs: widget.prefs,
                                      //         ))));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          23, 12, 10, 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: const [
                                          Icon(
                                            Icons.arrow_back_ios,
                                            color: AppColors.grey,
                                            size: 16,
                                          ),
                                          CommonText(
                                              text: "Back",
                                              // getTranslated(this.context, 'back'),
                                              fontWeight: FontWeight.w500,
                                              fontColor: AppColors.grey,
                                              fontSize: 13),
                                        ],
                                      ),
                                    )),
                                attempt > 1
                                    ? const SizedBox(
                                        height: 0,
                                      )
                                    : InkWell(
                                        onTap: () {
                                          setState(() {
                                            attempt++;

                                            timerProvider.resetTimer();
                                            isCodeSent = false;
                                            currentStatus = LoginStatus
                                                .sendingSmsCode.index;
                                          });
                                          verifyPhoneNumber();
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              10, 4, 23, 4),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: const [
                                              Icon(Icons.restart_alt_outlined,
                                                  color: AppColors.lightGreen),
                                              CommonText(
                                                  text: "Resend",
                                                  // ' ${getTranslated(this.context, 'resend')}',
                                                  fontSize: 13,
                                                  fontColor:
                                                      AppColors.lightGreen,
                                                  fontWeight: FontWeight.bold),
                                            ],
                                          ),
                                        ))
                              ],
                            ),
                ),
          const SizedBox(
            height: 27,
          ),
          //
        ],
      ),
    );
  }

  verifyingCode() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 3.0,
            color: AppConfig.designType == ThemeType.whatsapp
                ? AppColors.chattingGreen.withOpacity(0.3)
                : AppColors.chattingBlack.withOpacity(0.1),
            spreadRadius: 1.0,
          ),
        ],
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      margin: EdgeInsets.fromLTRB(
          15, MediaQuery.of(context).size.height / 2.50, 16, 0),
      child: Column(
        children: [
          const SizedBox(
            height: 13,
          ),
          const Center(
            child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(AppColors.lightGreen)),
          ),
          InkWell(
            onTap: () {
              setState(() {
                // isLoading = false;
                currentStatus = LoginStatus.sendSmsCode.index;
                // phoneNo.clear();
                // code = '';
              });
            },
            child: const Padding(
                padding: EdgeInsets.fromLTRB(13, 22, 13, 8),
                child: Center(
                  child: CommonText(
                      text: "Back",
                      // getTranslated(context, 'Back'),

                      fontWeight: FontWeight.w600,
                      fontSize: 15),
                )),
          ),
          //
          const SizedBox(
            height: 18,
          ),
        ],
      ),
    );
  }
}
