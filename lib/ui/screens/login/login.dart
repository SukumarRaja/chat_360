import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../config/app_config.dart';
import '../../../provider/observer.dart';
import '../../../translations/language.dart';
import '../../../utility/enum.dart';
import '../../themes/app_colors.dart';
import '../../widgets/common_text.dart';
import '../../widgets/common_textform_field.dart';
import '../../widgets/simple_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool language = false;
  bool check = false;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(this.context).size.width;
    var h = MediaQuery.of(this.context).size.height;
    return Scaffold(
      backgroundColor: AppConfig.designType == ThemeType.whatsapp
          ? AppColors.deepGreen
          : AppColors.chattingWhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                customClipPath(w, h),
                buildCurrentWidget(w)
              ],
          
            )
          ],
        ),
      ),
    );
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
                  // Language.languageList().length < 2

                  language == true
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
    // if (currentStatus == LoginStatus.sendSmsCode.index) {
    //   return loginWidgetsendSmsCode(w);
    // }
    //
    //   else if (currentStatus == LoginStatus.sendingSmsCode.index) {
    //     return loginWidgetsendingSmsCode();
    //   } else if (currentStatus == LoginStatus.sentSMSCode.index) {
    //     return loginWidgetsentSMScode();
    //   } else if (currentStatus == LoginStatus.verifyingSmsCode.index) {
    //     return loginWidgetVerifyingSMScode();
    //   } else if (currentStatus == LoginStatus.sendingSmsCode.index) {
    //     return loginWidgetsendingSmsCode();
    //   } else {
    //     return loginWidgetsendSmsCode(w);
    //   }
    // }

    if(language == true){
      return nameWidget(w);
    }else if(language == true){
        return sendSmsCode();
    }else if(check == false){
      return otpWidget();
    }else if(check == true){
      verifyingCode();
    }else if(language == true){
      return sendSmsCode();
    }else{
      return nameWidget(w);
    }
  }


  nameWidget(double w) {
    return Column(
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
              MediaQuery.of(context).size.height / 2.50, 16, 0),
          child: Column(
            children: [
              const SizedBox(
                height: 13,
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                // height: 63,
                height: 83,
                width: w / 1.24,
                child: CommonTextFormField(
                  inputFormatter: [
                    LengthLimitingTextInputFormatter(25),
                  ],
                  // controller: _name,
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
              // Container(
              //   margin: const EdgeInsets.only(top: 0),
              //   // padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              //   // height: 63,
              //   height: 63,
              //   width: w / 1.24,
              //   child: Form(
              //     // key: _enterNumberFormKey,
              //     child: CountryCodeTextFormField(
              //       buttonHintTextColor: AppColors.grey,
              //       borderColor: AppColors.grey.withOpacity(0.2),
              //       controller: _phoneNo,
              //       initialCountryCode:
              //       LimitConstants.defaultCountryCodeIso,
              //       onSaved: (phone) {
              //         setState(() {
              //           phoneCode = phone!.countryCode;
              //         });
              //       },
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(17),
              //   child: Text(
              //     getTranslated(this.context, 'sendsmscode'),
              //     // 'Send a SMS Code to verify your number',
              //     textAlign: TextAlign.center,
              //     // style: TextStyle(color: Mycolors.black),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(17, 22, 17, 5),
              //   child: CommonSimpleButton(
              //     spacing: 0.3,
              //     height: 57,
              //     buttonColor:
              //     AppConfig.designType == ThemeType.whatsapp
              //         ? AppColors.lightGreen
              //         : AppColors.lightGreen,
              //     buttonText: getTranslated(this.context, 'sendverf'),
              //     onPressed: widget.isblocknewlogins == true
              //         ? () {
              //       FiberChatSettings.toast(
              //         getTranslated(
              //             this.context, 'logindisabled'),
              //       );
              //     }
              //         : () {
              //       final timerProvider =
              //       Provider.of<TimerProvider>(context,
              //           listen: false);
              //
              //       setState(() {});
              //       RegExp e164 = RegExp(r'^\+[1-9]\d{1,14}$');
              //       if (_name.text.trim().isNotEmpty) {
              //         String _phone =
              //         _phoneNo.text.toString().trim();
              //         if (_phone.isNotEmpty &&
              //             e164.hasMatch(phoneCode! + _phone)) {
              //           if (_phone.startsWith('0') &&
              //               phoneCode == '+81') {
              //             timerProvider.resetTimer();
              //             setState(() {
              //               _phone = _phone.substring(1);
              //               _phoneNo.text = _phone;
              //               currentStatus =
              //                   LoginStatus.sendingSmsCode.index;
              //               isCodeSent = false;
              //             });
              //
              //             verifyPhoneNumber();
              //           } else {
              //             timerProvider.resetTimer();
              //             setState(() {
              //               currentStatus =
              //                   LoginStatus.sendingSmsCode.index;
              //               isCodeSent = false;
              //             });
              //             verifyPhoneNumber();
              //           }
              //         } else {
              //           FiberChatSettings.toast(
              //             getTranslated(
              //                 this.context, 'entervalidmob'),
              //           );
              //         }
              //       } else {
              //         FiberChatSettings.toast(
              //             getTranslated(this.context, 'nameem'));
              //       }
              //     },
              //   ),
              // ),

              //
              const SizedBox(
                height: 18,
              ),
            ],
          ),
        ),
        // Container(
        //   padding: const EdgeInsets.all(20),
        //   width: w * 0.95,
        //   child: RichText(
        //     textAlign: TextAlign.center,
        //     text: TextSpan(
        //       children: <TextSpan>[
        //         TextSpan(
        //             text: '${getTranslated(this.context, 'agree')} \n',
        //             style: TextStyle(
        //                 color: AppConfig.designType ==
        //                     ThemeType.whatsapp
        //                     ? AppColors.chattingWhite.withOpacity(0.8)
        //                     : AppColors.chattingBlack.withOpacity(0.8),
        //                 fontWeight: FontWeight.w400,
        //                 fontSize: 14.0,
        //                 height: 1.7)),
        //         TextSpan(
        //             text: getTranslated(this.context, 'tnc'),
        //             style: const TextStyle(
        //                 height: 1.7,
        //                 color: AppColors.lightGreen,
        //                 fontWeight: FontWeight.w700,
        //                 fontSize: 14.8),
        //             recognizer: TapGestureRecognizer()
        //               ..onTap = () {
        //                 if (LimitConstants.connectWithAdminApp ==
        //                     false) {
        //                   launch(AppConfig.termsAndConditionsUrl);
        //                 } else {
        //                   final observer =
        //                   Provider.of<ObserverProvider>(
        //                       this.context,
        //                       listen: false);
        //                   if (observer.tncType == 'url') {
        //                     if (observer.tnc == null) {
        //                       launch(AppConfig.termsAndConditionsUrl);
        //                     } else {
        //                       launch(observer.tnc!);
        //                     }
        //                   } else if (observer.tncType == 'file') {
        //                     Navigator.push(
        //                         this.context,
        //                         MaterialPageRoute(
        //                           builder: (context) =>
        //                               PDFViewerCachedFromUrl(
        //                                 title: getTranslated(
        //                                     this.context, 'tnc'),
        //                                 url: observer.tnc,
        //                                 isregistered: false,
        //                               ),
        //                         ));
        //                   }
        //                 }
        //               }),
        //         TextSpan(
        //             text: '  ○  ',
        //             style: TextStyle(
        //                 height: 1.7,
        //                 color: AppConfig.designType ==
        //                     ThemeType.whatsapp
        //                     ? AppColors.chattingWhite.withOpacity(0.79)
        //                     : AppColors.chattingBlack.withOpacity(0.79),
        //                 fontWeight: FontWeight.w500,
        //                 fontSize: 11.8)),
        //         TextSpan(
        //             text: getTranslated(this.context, 'pp'),
        //             style: const TextStyle(
        //                 height: 1.7,
        //                 color: AppColors.lightGreen,
        //                 fontWeight: FontWeight.w700,
        //                 fontSize: 14.8),
        //             recognizer: TapGestureRecognizer()
        //               ..onTap = () {
        //                 if (LimitConstants.connectWithAdminApp ==
        //                     false) {
        //                   launch(AppConfig.privacyPolicyUrl);
        //                 } else {
        //                   if (observer.privacyPolicyType == 'url') {
        //                     if (observer.privacyPolicy == null) {
        //                       launch(AppConfig.privacyPolicyUrl);
        //                     } else {
        //                       launch(observer.privacyPolicy!);
        //                     }
        //                   } else if (observer.privacyPolicyType ==
        //                       'file') {
        //                     Navigator.push(
        //                         this.context,
        //                         MaterialPageRoute(
        //                           builder: (context) =>
        //                               PDFViewerCachedFromUrl(
        //                                 title: getTranslated(
        //                                     this.context, 'pp'),
        //                                 url: observer.privacyPolicy,
        //                                 isregistered: false,
        //                               ),
        //                         ));
        //                   }
        //                 }
        //               }),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
    //   Consumer<ObserverProvider>(
    //     builder: (context, observer, _) =>
    //         Column(
    //           children: [
    //             Container(
    //               decoration: BoxDecoration(
    //                 boxShadow: [
    //                   BoxShadow(
    //                     blurRadius: 3.0,
    //                     color: AppConfig.designType == ThemeType.whatsapp
    //                         ? AppColors.deepGreen.withOpacity(0.3)
    //                         : AppColors.chattingBlack.withOpacity(0.1),
    //                     spreadRadius: 1.0,
    //                   ),
    //                 ],
    //                 borderRadius: BorderRadius.circular(20),
    //                 color: Colors.white,
    //               ),
    //               margin: EdgeInsets.fromLTRB(15,
    //                   MediaQuery.of(this.context).size.height / 2.50, 16, 0),
    //               child: Column(
    //                 children: <Widget>[
    //                   const SizedBox(
    //                     height: 13,
    //                   ),
    //                   Container(
    //                     margin: const EdgeInsets.only(top: 10),
    //                     padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
    //                     // height: 63,
    //                     height: 83,
    //                     width: w / 1.24,
    //                     child: CommonTextFormField(
    //                       inputFormatter: [
    //                         LengthLimitingTextInputFormatter(25),
    //                       ],
    //                       // controller: _name,
    //                       leftRightMargin: 0,
    //                       showIconBoundary: false,
    //                       boxCornerRadius: 5.5,
    //                       boxHeight: 50,
    //                       // hintText: getTranslated(this.context, 'name_hint'),
    //                       hintText: "Name",
    //                       prefixIconButton: Icon(
    //                         Icons.person,
    //                         color: Colors.grey.withOpacity(0.5),
    //                       ),
    //                     ),
    //                   ),
    //                   // Container(
    //                   //   margin: const EdgeInsets.only(top: 0),
    //                   //   // padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
    //                   //   // height: 63,
    //                   //   height: 63,
    //                   //   width: w / 1.24,
    //                   //   child: Form(
    //                   //     // key: _enterNumberFormKey,
    //                   //     child: CountryCodeTextFormField(
    //                   //       buttonHintTextColor: AppColors.grey,
    //                   //       borderColor: AppColors.grey.withOpacity(0.2),
    //                   //       controller: _phoneNo,
    //                   //       initialCountryCode:
    //                   //       LimitConstants.defaultCountryCodeIso,
    //                   //       onSaved: (phone) {
    //                   //         setState(() {
    //                   //           phoneCode = phone!.countryCode;
    //                   //         });
    //                   //       },
    //                   //     ),
    //                   //   ),
    //                   // ),
    //                   // Padding(
    //                   //   padding: const EdgeInsets.all(17),
    //                   //   child: Text(
    //                   //     getTranslated(this.context, 'sendsmscode'),
    //                   //     // 'Send a SMS Code to verify your number',
    //                   //     textAlign: TextAlign.center,
    //                   //     // style: TextStyle(color: Mycolors.black),
    //                   //   ),
    //                   // ),
    //                   // Padding(
    //                   //   padding: const EdgeInsets.fromLTRB(17, 22, 17, 5),
    //                   //   child: CommonSimpleButton(
    //                   //     spacing: 0.3,
    //                   //     height: 57,
    //                   //     buttonColor:
    //                   //     AppConfig.designType == ThemeType.whatsapp
    //                   //         ? AppColors.lightGreen
    //                   //         : AppColors.lightGreen,
    //                   //     buttonText: getTranslated(this.context, 'sendverf'),
    //                   //     onPressed: widget.isblocknewlogins == true
    //                   //         ? () {
    //                   //       FiberChatSettings.toast(
    //                   //         getTranslated(
    //                   //             this.context, 'logindisabled'),
    //                   //       );
    //                   //     }
    //                   //         : () {
    //                   //       final timerProvider =
    //                   //       Provider.of<TimerProvider>(context,
    //                   //           listen: false);
    //                   //
    //                   //       setState(() {});
    //                   //       RegExp e164 = RegExp(r'^\+[1-9]\d{1,14}$');
    //                   //       if (_name.text.trim().isNotEmpty) {
    //                   //         String _phone =
    //                   //         _phoneNo.text.toString().trim();
    //                   //         if (_phone.isNotEmpty &&
    //                   //             e164.hasMatch(phoneCode! + _phone)) {
    //                   //           if (_phone.startsWith('0') &&
    //                   //               phoneCode == '+81') {
    //                   //             timerProvider.resetTimer();
    //                   //             setState(() {
    //                   //               _phone = _phone.substring(1);
    //                   //               _phoneNo.text = _phone;
    //                   //               currentStatus =
    //                   //                   LoginStatus.sendingSmsCode.index;
    //                   //               isCodeSent = false;
    //                   //             });
    //                   //
    //                   //             verifyPhoneNumber();
    //                   //           } else {
    //                   //             timerProvider.resetTimer();
    //                   //             setState(() {
    //                   //               currentStatus =
    //                   //                   LoginStatus.sendingSmsCode.index;
    //                   //               isCodeSent = false;
    //                   //             });
    //                   //             verifyPhoneNumber();
    //                   //           }
    //                   //         } else {
    //                   //           FiberChatSettings.toast(
    //                   //             getTranslated(
    //                   //                 this.context, 'entervalidmob'),
    //                   //           );
    //                   //         }
    //                   //       } else {
    //                   //         FiberChatSettings.toast(
    //                   //             getTranslated(this.context, 'nameem'));
    //                   //       }
    //                   //     },
    //                   //   ),
    //                   // ),
    //
    //                   //
    //                   const SizedBox(
    //                     height: 18,
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             // Container(
    //             //   padding: const EdgeInsets.all(20),
    //             //   width: w * 0.95,
    //             //   child: RichText(
    //             //     textAlign: TextAlign.center,
    //             //     text: TextSpan(
    //             //       children: <TextSpan>[
    //             //         TextSpan(
    //             //             text: '${getTranslated(this.context, 'agree')} \n',
    //             //             style: TextStyle(
    //             //                 color: AppConfig.designType ==
    //             //                     ThemeType.whatsapp
    //             //                     ? AppColors.chattingWhite.withOpacity(0.8)
    //             //                     : AppColors.chattingBlack.withOpacity(0.8),
    //             //                 fontWeight: FontWeight.w400,
    //             //                 fontSize: 14.0,
    //             //                 height: 1.7)),
    //             //         TextSpan(
    //             //             text: getTranslated(this.context, 'tnc'),
    //             //             style: const TextStyle(
    //             //                 height: 1.7,
    //             //                 color: AppColors.lightGreen,
    //             //                 fontWeight: FontWeight.w700,
    //             //                 fontSize: 14.8),
    //             //             recognizer: TapGestureRecognizer()
    //             //               ..onTap = () {
    //             //                 if (LimitConstants.connectWithAdminApp ==
    //             //                     false) {
    //             //                   launch(AppConfig.termsAndConditionsUrl);
    //             //                 } else {
    //             //                   final observer =
    //             //                   Provider.of<ObserverProvider>(
    //             //                       this.context,
    //             //                       listen: false);
    //             //                   if (observer.tncType == 'url') {
    //             //                     if (observer.tnc == null) {
    //             //                       launch(AppConfig.termsAndConditionsUrl);
    //             //                     } else {
    //             //                       launch(observer.tnc!);
    //             //                     }
    //             //                   } else if (observer.tncType == 'file') {
    //             //                     Navigator.push(
    //             //                         this.context,
    //             //                         MaterialPageRoute(
    //             //                           builder: (context) =>
    //             //                               PDFViewerCachedFromUrl(
    //             //                                 title: getTranslated(
    //             //                                     this.context, 'tnc'),
    //             //                                 url: observer.tnc,
    //             //                                 isregistered: false,
    //             //                               ),
    //             //                         ));
    //             //                   }
    //             //                 }
    //             //               }),
    //             //         TextSpan(
    //             //             text: '  ○  ',
    //             //             style: TextStyle(
    //             //                 height: 1.7,
    //             //                 color: AppConfig.designType ==
    //             //                     ThemeType.whatsapp
    //             //                     ? AppColors.chattingWhite.withOpacity(0.79)
    //             //                     : AppColors.chattingBlack.withOpacity(0.79),
    //             //                 fontWeight: FontWeight.w500,
    //             //                 fontSize: 11.8)),
    //             //         TextSpan(
    //             //             text: getTranslated(this.context, 'pp'),
    //             //             style: const TextStyle(
    //             //                 height: 1.7,
    //             //                 color: AppColors.lightGreen,
    //             //                 fontWeight: FontWeight.w700,
    //             //                 fontSize: 14.8),
    //             //             recognizer: TapGestureRecognizer()
    //             //               ..onTap = () {
    //             //                 if (LimitConstants.connectWithAdminApp ==
    //             //                     false) {
    //             //                   launch(AppConfig.privacyPolicyUrl);
    //             //                 } else {
    //             //                   if (observer.privacyPolicyType == 'url') {
    //             //                     if (observer.privacyPolicy == null) {
    //             //                       launch(AppConfig.privacyPolicyUrl);
    //             //                     } else {
    //             //                       launch(observer.privacyPolicy!);
    //             //                     }
    //             //                   } else if (observer.privacyPolicyType ==
    //             //                       'file') {
    //             //                     Navigator.push(
    //             //                         this.context,
    //             //                         MaterialPageRoute(
    //             //                           builder: (context) =>
    //             //                               PDFViewerCachedFromUrl(
    //             //                                 title: getTranslated(
    //             //                                     this.context, 'pp'),
    //             //                                 url: observer.privacyPolicy,
    //             //                                 isregistered: false,
    //             //                               ),
    //             //                         ));
    //             //                   }
    //             //                 }
    //             //               }),
    //             //       ],
    //             //     ),
    //             //   ),
    //             // ),
    //           ],
    //         )
    // );
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
        children: <Widget>[
          const SizedBox(
            height: 13,
          ),
          Padding(
            padding: const EdgeInsets.all(17),
            child: CommonText(
              text: "Sending Code to +91 9585884353",
              // '${getTranslated(context, 'sending_code')} $phoneCode-${_phoneNo.text}',
              textAlign: TextAlign.center,
              height: 1.5
            ),
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
                // currentCode: _code,
                currentCode: "",
                onCodeSubmitted: (code) {
                  setState(() {
                    // _code = code;
                    var codes = code;
                  });
                  if (code.length == 6) {
                    setState(() {
                      // currentStatus = LoginStatus.verifyingSmsCode.index;
                    });
                    // handleSignIn();
                  } else {
                    // FiberChatSettings.toast(
                    //     getTranslated(context, 'correctotp'));
                  }
                },
                onCodeChanged: (code) {
                  if (code!.length == 6) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    setState(() {
                      // _code = code;
                      var codes = code;
                    });
                  }
                },
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(17),
            child: CommonText(
              text: "Enter Verification Code",
              // '${getTranslated(context, 'enter_verfcode')} $phoneCode-${_phoneNo.text}',
              textAlign: TextAlign.center,
              height: 1.5

              // style: TextStyle(color: Mycolors.black),
            ),
          ),
          // isShowCompletedLoading == true
          loading == true
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
                // if (_code.length == 6) {
                //   setState(() {
                //     isVerifyingCode = true;
                //   });
                //   handleSignIn();
                // } else {
                //   FiberChatSettings.toast(
                //       getTranslated(context, 'correctotp'));
                // }
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // isShowCompletedLoading == true
          //     ? const SizedBox(
          //   height: 36,
          // )
          //     : Consumer<TimerProvider>(
          //   builder: (context, timeProvider, _) => timeProvider.wait ==
          //       true &&
          //       isCodeSent == true
          //       ? Padding(
          //     padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
          //     child: RichText(
          //         text: TextSpan(
          //           children: [
          //             TextSpan(
          //               text: getTranslated(this.context, 'resendcode'),
          //               style: const TextStyle(
          //                   fontSize: 14, color: AppColors.grey),
          //             ),
          //             TextSpan(
          //               text: " 00:${timeProvider.start} ",
          //               style: const TextStyle(
          //                   fontSize: 15,
          //                   color: AppColors.lightGreen,
          //                   fontWeight: FontWeight.w700),
          //             ),
          //             TextSpan(
          //               text: getTranslated(this.context, 'seconds'),
          //               style: const TextStyle(
          //                   fontSize: 14, color: AppColors.grey),
          //             ),
          //           ],
          //         )),
          //   )
          //       : timeProvider.isActionBarShow == false
          //       ? const SizedBox(
          //     height: 35,
          //   )
          //       : Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       InkWell(
          //           onTap: () {
          //             final timerProvider =
          //             Provider.of<TimerProvider>(context,
          //                 listen: false);
          //             timerProvider.resetTimer();
          //             unawaited(Navigator.pushReplacement(
          //                 this.context,
          //                 MaterialPageRoute(
          //                     builder: (newContext) => HomePage(
          //                       currentUserNo: null,
          //                       isSecuritySetupDone: false,
          //                       prefs: widget.prefs,
          //                     ))));
          //           },
          //           child: Container(
          //             margin: const EdgeInsets.fromLTRB(
          //                 23, 12, 10, 10),
          //             child: Row(
          //               mainAxisAlignment:
          //               MainAxisAlignment.center,
          //               mainAxisSize: MainAxisSize.min,
          //               children: [
          //                 const Icon(
          //                   Icons.arrow_back_ios,
          //                   color: AppColors.grey,
          //                   size: 16,
          //                 ),
          //                 Text(
          //                   getTranslated(this.context, 'back'),
          //                   style: const TextStyle(
          //                       fontWeight: FontWeight.w500,
          //                       color: AppColors.grey,
          //                       fontSize: 13),
          //                 ),
          //               ],
          //             ),
          //           )),
          //       attempt > 1
          //           ? const SizedBox(
          //         height: 0,
          //       )
          //           : InkWell(
          //           onTap: () {
          //             setState(() {
          //               attempt++;
          //
          //               timeProvider.resetTimer();
          //               isCodeSent = false;
          //               currentStatus = LoginStatus
          //                   .sendingSmsCode.index;
          //             });
          //             verifyPhoneNumber();
          //           },
          //           child: Container(
          //             margin: const EdgeInsets.fromLTRB(
          //                 10, 4, 23, 4),
          //             child: Row(
          //               mainAxisAlignment:
          //               MainAxisAlignment.center,
          //               mainAxisSize: MainAxisSize.min,
          //               children: [
          //                 const Icon(
          //                     Icons.restart_alt_outlined,
          //                     color: AppColors.lightGreen),
          //                 Text(
          //                   ' ${getTranslated(this.context, 'resend')}',
          //                   style: const TextStyle(
          //                       fontSize: 13,
          //                       color: AppColors.lightGreen,
          //                       fontWeight:
          //                       FontWeight.bold),
          //                 ),
          //               ],
          //             ),
          //           ))
          //     ],
          //   ),
          // ),

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
        children: <Widget>[
          const SizedBox(
            height: 13,
          ),

          // Container(
          //   margin: EdgeInsets.all(25),
          //   child: Padding(
          //     padding: const EdgeInsets.all(1.0),
          //     child: PinFieldAutoFill(
          //       codeLength: 6,
          //       decoration: UnderlineDecoration(
          //         bgColorBuilder:
          //             FixedColorBuilder(AppColors.grey.withOpacity(0.1)),
          //         textStyle: TextStyle(
          //             fontSize: 22,
          //             color: AppColors.chattingBlack,
          //             fontWeight: FontWeight.bold),
          //         colorBuilder:
          //             FixedColorBuilder(AppColors.grey.withOpacity(0.1)),
          //       ),
          //       currentCode: _code,
          //       onCodeSubmitted: (code) {
          //         setState(() {
          //           _code = code;
          //         });
          //         if (code.length == 6) {
          //           setState(() {
          //             isSendingOTP = true;
          //           });
          //           handleSignIn();
          //         } else {
          //           FiberChatSettings.toast(getTranslated(this.context, 'correctotp'));
          //         }
          //       },
          //       onCodeChanged: (code) {
          //         if (code!.length == 6) {
          //           FocusScope.of(this.context).requestFocus(FocusNode());
          //           setState(() {
          //             _code = code;
          //           });
          //         }
          //       },
          //     ),
          //   ),
          // ),

          // Padding(
          //   padding: EdgeInsets.all(17),
          //   child: Text(
          //     isverficationsent == false
          //         ? getTranslated(this.context, 'sending_code') +
          //             ' $phoneCode-${_phoneNo.text}'
          //         : getTranslated(this.context, 'enter_verfcode') +
          //             ' $phoneCode-${_phoneNo.text}',
          //     textAlign: TextAlign.center,
          //     style: TextStyle(height: 1.5),

          //     // style: TextStyle(color: Mycolors.black),
          //   ),
          // ),
          // isSendingOTP == true
          //     ?
          const Center(
            child: CircularProgressIndicator(
                valueColor:
                AlwaysStoppedAnimation<Color>(AppColors.lightGreen)),
          ),
          // : Padding(
          //     padding: EdgeInsets.fromLTRB(17, 22, 17, 5),
          //     child: CommonSimpleButton(
          //       height: 57,
          //       buttonColor: AppConfig.designType == ThemeType.whatsapp
          //           ? AppColors.lightGreen
          //           : AppColors.lightGreen,
          //       buttonText: getTranslated(this.context, 'verify_otp'),
          //       onPressed: () {
          //         if (_code.length == 6) {
          //           setState(() {
          //             isVerifyingCode = true;
          //           });
          //           handleSignIn();
          //         } else
          //           FiberChatSettings.toast(
          //               getTranslated(this.context, 'correctotp'));
          //       },
          //     ),
          //   ),
          // isSendingOTP == true
          //     ? SizedBox(
          //         height: 20,
          //       )
          //     :

          InkWell(
            onTap: () {
              setState(() {
                // isLoading = false;
                // currentStatus = LoginStatus.sendSmsCode.index;
                // _phoneNo.clear();
                // _code = '';
              });
            },
            child: Padding(
                padding: const EdgeInsets.fromLTRB(13, 22, 13, 8),
                child: Center(
                  child: CommonText(
                    text:"Back",
                    // getTranslated(context, 'Back'),

                        fontWeight: FontWeight.w600, fontSize: 15
                  ),
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
