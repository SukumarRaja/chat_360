import 'dart:async';
import 'dart:io';

import 'package:chat360/ui/themes/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../config/app_config.dart';
import '../../../config/database_keys.dart';
import '../../../config/database_path.dart';
import '../../../provider/available_contact.dart';
import '../../../provider/current_chat.dart';
import '../../../provider/status.dart';
import '../../../services/notification/background_msg_handler.dart';
import '../../../translations/language.dart';
import '../../../utility/enum.dart';
import '../../../utility/settings.dart';
import '../../widgets/common_text.dart';
import '../call/call_history.dart';
import '../chat/recent.dart';
import '../chat/search.dart';
import '../error/error.dart';
import '../pick_up/pick_up.dart';
import '../status/status.dart';

class HomePage extends StatefulWidget {
  const HomePage(
      {Key? key,
      this.currentUserNo,
      required this.isSecuritySetupDone,
      required this.prefs})
      : super(key: key);

  final String? currentUserNo;
  final bool isSecuritySetupDone;
  final SharedPreferences prefs;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with
        WidgetsBindingObserver,
        AutomaticKeepAliveClientMixin,
        TickerProviderStateMixin {

  DateTime? currentBackPressTime = DateTime.now();
  TabController? controllerIfCallAllowed;
  TabController? controllerIfCallNotAllowed;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (now.difference(currentBackPressTime!) > const Duration(seconds: 3)) {
      currentBackPressTime = now;
      FiberSettings.toast(message: 'Double Tap To Go Back');
      return Future.value(false);
    } else {
      // if (!isAuthenticating) setLastSeen();
      return Future.value(true);
    }
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setIsActive();
    } else {
      // setLastSeen();
    }
  }
  void setIsActive() async {
    if (widget.currentUserNo != null && widget.currentUserNo != null) {
      await FirebaseFirestore.instance
          .collection(DatabasePath.fireStoreCollectionUsers)
          .doc(widget.currentUserNo)
          .update(
        {
          DatabaseKeys.lastSeen: true,
          DatabaseKeys.lastTimeOnline: DateTime.now().millisecondsSinceEpoch
        },
      );
    }
  }

  void setLastSeen() async {
    if (widget.currentUserNo != null && widget.currentUserNo != null) {
      await FirebaseFirestore.instance
          .collection(DatabasePath.fireStoreCollectionUsers)
          .doc(widget.currentUserNo)
          .update(
        {DatabaseKeys.lastSeen: DateTime.now().millisecondsSinceEpoch},
      );
    }
  }

  final TextEditingController filter = TextEditingController();
  bool isAuthenticating = false;

  StreamSubscription? spokenSubscription;
  List<StreamSubscription> unreadSubscriptions =
  List.from(<StreamSubscription>[]);
  late StreamSubscription intentDataStreamSubscription;
  List<SharedMediaFile>? sharedFiles = [];
  String? sharedText;




  List<StreamController> controllers = List.from(<StreamController>[]);
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  String? deviceId;
  var mapDeviceInfo = {};
  String? maintenanceMessage;
  bool isNotAllowEmulator = false;
  bool? isBlockNewLogins = false;
  bool? biometricEnabled = false;
  bool? isApprovalNeededByAdminForNewUser = false;
  String? accountApprovalMessage = "Account Approved";
  String? accountStatus;
  String? accountActionMessage;
  String? userPhotoUrl;
  String? userFullName;
  String? s;
  String? a;
  @override
  void initState() {
    listenToSharingIntent();
    // listenToNotification();
    // getSignedInUserOrRedirect();
    // setDeviceInfo();
    // registerNotification();

    controllerIfCallAllowed = TabController(length: 4, vsync: this);
    controllerIfCallAllowed!.index = 1;
    controllerIfCallNotAllowed = TabController(length: 3, vsync: this);
    controllerIfCallNotAllowed!.index = 1;

    FiberSettings.internetLookUp();
    WidgetsBinding.instance.addObserver(this);

    LocalAuthentication().canCheckBiometrics.then((res) {
      if (res) biometricEnabled = true;
    });
    // getModel();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controllerIfCallAllowed!.addListener(() {
        if (controllerIfCallAllowed!.index == 2) {
          final statusProvider =
          Provider.of<StatusProvider>(context, listen: false);
          final contactsProvider =
          Provider.of<AvailableContactsProvider>(context, listen: false);
          statusProvider.searchContactStatus(widget.currentUserNo!,
              contactsProvider.joinedUserPhoneStringAsInServer);
        }
      });
      controllerIfCallNotAllowed!.addListener(() {
        if (controllerIfCallNotAllowed!.index == 2) {
          final statusProvider =
          Provider.of<StatusProvider>(context, listen: false);
          final contactsProvider =
          Provider.of<AvailableContactsProvider>(context, listen: false);
          statusProvider.searchContactStatus(widget.currentUserNo!,
              contactsProvider.joinedUserPhoneStringAsInServer);
        }
      });
    });
    super.initState();
  }
  listenToSharingIntent() {
    // For sharing images coming from outside the app while the app is in the memory
    intentDataStreamSubscription = ReceiveSharingIntent.getMediaStream().listen(
            (List<SharedMediaFile> value) {
          setState(() {
            sharedFiles = value;
          });
        }, onError: (err) {
      print("getIntentDataStream error: $err");
    });

    // For sharing images coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialMedia().then((List<SharedMediaFile> value) {
      setState(() {
        sharedFiles = value;
      });
    });

    // For sharing or opening urls/text coming from outside the app while the app is in the memory
    intentDataStreamSubscription =
        ReceiveSharingIntent.getTextStream().listen((String value) {
          setState(() {
            sharedText = value;
          });
        }, onError: (err) {
          print("getLinkStream error: $err");
        });

    // For sharing or opening urls/text coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialText().then((String? value) {
      setState(() {
        sharedText = value;
      });
    });
  }
  void listenToNotification() async {
    //FOR ANDROID  background notification is handled here whereas for iOS it is handled at the very top of main.dart ------
    if (Platform.isAndroid) {
      FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandlerAndroid);
    }
    //ANDROID & iOS  OnMessage callback
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      // ignore: unnecessary_null_comparison
      flutterLocalNotificationsPlugin.cancelAll();

      if (message.data['title'] != 'Call Ended' &&
          message.data['title'] != 'Missed Call' &&
          message.data['title'] != 'You have new message(s)' &&
          message.data['title'] != 'Incoming Video Call...' &&
          message.data['title'] != 'Incoming Audio Call...' &&
          message.data['title'] != 'Incoming Call ended' &&
          message.data['title'] != 'New message in Group') {
        FiberSettings.toast(
            // getTranslated(this.context, 'newnotifications')
          message: "New Notifications"


        );
      } else {
        // if (message.data['title'] == 'New message in Group') {
        //   var currentpeer =
        //       Provider.of<CurrentChatPeer>(this.context, listen: false);
        //   if (currentpeer.groupChatId != message.data['groupid']) {
        //     flutterLocalNotificationsPlugin..cancelAll();

        //     showOverlayNotification((context) {
        //       return Card(
        //         margin: const EdgeInsets.symmetric(horizontal: 4),
        //         child: SafeArea(
        //           child: ListTile(
        //             title: Text(
        //               message.data['titleMultilang'],
        //               maxLines: 1,
        //               overflow: TextOverflow.ellipsis,
        //             ),
        //             subtitle: Text(
        //               message.data['bodyMultilang'],
        //               maxLines: 2,
        //               overflow: TextOverflow.ellipsis,
        //             ),
        //             trailing: IconButton(
        //                 icon: Icon(Icons.close),
        //                 onPressed: () {
        //                   OverlaySupportEntry.of(context)!.dismiss();
        //                 }),
        //           ),
        //         ),
        //       );
        //     }, duration: Duration(milliseconds: 2000));
        //   }
        // } else

        if (message.data['title'] == 'Call Ended') {
          flutterLocalNotificationsPlugin.cancelAll();
        } else {
          if (message.data['title'] == 'Incoming Audio Call...' ||
              message.data['title'] == 'Incoming Video Call...') {
            final data = message.data;
            final title = data['title'];
            final body = data['body'];
            final titleMultilang = data['titleMultilang'];
            final bodyMultilang = data['bodyMultilang'];
            await showNotificationWithDefaultSound(
                title, body, titleMultilang, bodyMultilang);
          } else if (message.data['title'] == 'You have new message(s)') {
            var currentpeer =
            Provider.of<CurrentChatProvider>(this.context, listen: false);
            if (currentpeer.peerId != message.data['peerid']) {
              // FlutterRingtonePlayer.playNotification();
              showOverlayNotification((context) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  child: SafeArea(
                    child: ListTile(
                      title: Text(
                        message.data['titleMultilang'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        message.data['bodyMultilang'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            OverlaySupportEntry.of(context)!.dismiss();
                          }),
                    ),
                  ),
                );
              }, duration: const Duration(milliseconds: 2000));
            }
          } else {
            showOverlayNotification((context) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                child: SafeArea(
                  child: ListTile(
                    leading: Image.network(
                      message.data['image'],
                      width: 50,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      message.data['titleMultilang'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      message.data['bodyMultilang'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          OverlaySupportEntry.of(context)!.dismiss();
                        }),
                  ),
                ),
              );
            }, duration: const Duration(milliseconds: 2000));
          }
        }
      }
    });
    //ANDROID & iOS  onMessageOpenedApp callback
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      flutterLocalNotificationsPlugin.cancelAll();
      Map<String, dynamic> notificationData = message.data;
      AndroidNotification? android = message.notification?.android;
      if (android != null) {
        if (notificationData['title'] == 'Call Ended') {
          flutterLocalNotificationsPlugin.cancelAll();
        } else if (notificationData['title'] != 'Call Ended' &&
            notificationData['title'] != 'You have new message(s)' &&
            notificationData['title'] != 'Missed Call' &&
            notificationData['title'] != 'Incoming Video Call...' &&
            notificationData['title'] != 'Incoming Audio Call...' &&
            notificationData['title'] != 'Incoming Call ended' &&
            notificationData['title'] != 'New message in Group') {
          flutterLocalNotificationsPlugin.cancelAll();

          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => const AllNotifications()));
        } else {
          flutterLocalNotificationsPlugin.cancelAll();
        }
      }
    });
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        flutterLocalNotificationsPlugin.cancelAll();
        Map<String, dynamic>? notificationData = message.data;
        if (notificationData['title'] != 'Call Ended' &&
            notificationData['title'] != 'You have new message(s)' &&
            notificationData['title'] != 'Missed Call' &&
            notificationData['title'] != 'Incoming Video Call...' &&
            notificationData['title'] != 'Incoming Audio Call...' &&
            notificationData['title'] != 'Incoming Call ended' &&
            notificationData['title'] != 'New message in Group') {
          flutterLocalNotificationsPlugin.cancelAll();

          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => const AllNotifications()));
        }
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    bool isNotAllowEmulator = false;
    bool observer = false;

    return isNotAllowEmulator == true
        ? const CommonErrorScreen(
            title: "Emulator Not Allowed",
            subTitle: "Please try any real device & Try again")
        // : accountStatus != null
        //     ? const CommonErrorScreen(
        //         title: "Backend Title",
        //         subTitle: "Backend Message",
        //       )
        //     : LimitConstants.connectWithAdminApp == true &&
        //             maintenanceMessage != null
        //         ? const CommonErrorScreen(
        //             title: "App under Maintenance", subTitle: "Backend Message")
        //         : LimitConstants.connectWithAdminApp == true &&
        //                 isFetching == true
        //             ? SplashScreen()
        : PickUpLayout(
            scaffold: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                    elevation:
                        AppConfig.designType == ThemeType.messenger ? 0.4 : 1,
                    backgroundColor: AppConfig.designType == ThemeType.whatsapp
                        ? AppColors.deepGreen
                        : AppColors.chattingWhite,
                    title: CommonText(
                      text: AppConfig.appName,
                      fontColor: AppConfig.designType == ThemeType.whatsapp
                          ? AppColors.chattingWhite
                          : AppColors.chattingBlack,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                    titleSpacing: 5,
                    actions: [
                      if (Language.languageList().length < 2)
                        const SizedBox()
                      else
                        Container(
                          alignment: Alignment.centerRight,
                          margin: const EdgeInsets.only(top: 4),
                          width: 120,
                          child: DropdownButton<Language>(
                            // iconSize: 40,

                            isExpanded: true,
                            underline: const SizedBox(),
                            icon: SizedBox(
                              width: 60,
                              height: 30,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.language_outlined,
                                    color: AppConfig.designType ==
                                            ThemeType.whatsapp
                                        ? AppColors.chattingWhite
                                        : AppColors.chattingBlack
                                            .withOpacity(0.7),
                                    size: 22,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: AppConfig.designType ==
                                            ThemeType.whatsapp
                                        ? AppColors.lightGreen
                                        : AppColors.lightGreen,
                                    size: 27,
                                  )
                                ],
                              ),
                            ),
                            onChanged: (Language? language) {
                              // changeLanguage(language!);
                            },
                            items: Language.languageList()
                                .map<DropdownMenuItem<Language>>(
                                  (e) => DropdownMenuItem<Language>(
                                    value: e,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          ' ${e.languageNameInEnglish}  ${e.flag} ',
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      PopupMenuButton(
                          padding: const EdgeInsets.all(0),
                          icon: Padding(
                            padding: const EdgeInsets.only(right: 1),
                            child: Icon(
                              Icons.more_vert_outlined,
                              color: AppConfig.designType == ThemeType.whatsapp
                                  ? AppColors.chattingWhite
                                  : AppColors.chattingBlack,
                            ),
                          ),
                          color: AppColors.chattingWhite,
                          onSelected: (dynamic val) async {
                            switch (val) {
                              case 'rate':
                                break;
                              case 'tutorials':
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const SimpleDialog(
                                        contentPadding: EdgeInsets.all(20),
                                        children: [
                                          ListTile(
                                            title: CommonText(
                                              text: "Swipe View",
                                              // getTranslated(context, 'swipeview'),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          ListTile(
                                              title: CommonText(
                                            text: "Swipe Hide",
                                            // getTranslated(context, 'swipehide'),
                                          )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          ListTile(
                                              title: CommonText(
                                            text: "Set Alias",
                                            // getTranslated(context, 'lp_setalias'),
                                          ))
                                        ],
                                      );
                                    });
                                break;
                              case 'privacy':
                                break;
                              case 'tnc':
                                break;
                              case 'share':
                                break;
                              case 'notifications':
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             const AllNotifications()));

                                break;
                              case 'feedback':
                                break;
                              case 'logout':
                                break;
                              case 'settings':
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => SettingsOption(
                                //               onTapLogout: () async {
                                //                 await logout(context);
                                //               },
                                //               onTapEditProfile: () {
                                //                 if (widget.prefs.getString(
                                //                             DatabaseKeys
                                //                                 .isPinSetupDone) !=
                                //                         currentUserNo ||
                                //                     widget.prefs.getString(
                                //                             DatabaseKeys
                                //                                 .isPinSetupDone) ==
                                //                         null) {
                                //                   unawaited(Navigator.push(
                                //                       this.context,
                                //                       MaterialPageRoute(
                                //                           builder: (context) =>
                                //                               Security(
                                //                                 currentUserNo,
                                //                                 prefs:
                                //                                     widget.prefs,
                                //                                 setPasscode: true,
                                //                                 onSuccess:
                                //                                     (newContext) async {
                                //                                   Navigator.pushReplacement(
                                //                                       context,
                                //                                       MaterialPageRoute(
                                //                                           builder: (context) => ProfileSetting(
                                //                                                 prefs: widget.prefs,
                                //                                                 biometricEnabled: biometricEnabled,
                                //                                                 type: FiberChatSettings.getAuthenticationType(biometricEnabled, cachedModel),
                                //                                               )));
                                //                                 },
                                //                                 title: getTranslated(
                                //                                     this.context,
                                //                                     'authh'),
                                //                               ))));
                                //                 } else {
                                //                   ChatController.authenticate(
                                //                       cachedModel!,
                                //                       getTranslated(
                                //                           context, 'auth_needed'),
                                //                       state:
                                //                           Navigator.of(context),
                                //                       shouldPop: false,
                                //                       type: FiberChatSettings
                                //                           .getAuthenticationType(
                                //                               biometricEnabled,
                                //                               cachedModel),
                                //                       prefs: widget.prefs,
                                //                       onSuccess: () {
                                //                     Navigator.pushReplacement(
                                //                         context,
                                //                         MaterialPageRoute(
                                //                             builder: (context) =>
                                //                                 ProfileSetting(
                                //                                   prefs: widget
                                //                                       .prefs,
                                //                                   biometricEnabled:
                                //                                       biometricEnabled,
                                //                                   type: FiberChatSettings
                                //                                       .getAuthenticationType(
                                //                                           biometricEnabled,
                                //                                           cachedModel),
                                //                                 )));
                                //                   });
                                //                 }
                                //               },
                                //               currentUserNo: currentUserNo!,
                                //               biometricEnabled: biometricEnabled,
                                //               type: FiberChatSettings
                                //                   .getAuthenticationType(
                                //                       biometricEnabled,
                                //                       cachedModel),
                                //             )));

                                break;
                              case 'group':
                                // if (observer.isAllowCreatingGroups == false) {
                                //   FiberChatSettings.showRationaleToast(
                                //       getTranslated(this.context, 'disabled'));
                                // } else {
                                //   final AvailableContactsProvider
                                //       dbcontactsProvider =
                                //       Provider.of<AvailableContactsProvider>(
                                //           context,
                                //           listen: false);
                                //   dbcontactsProvider.fetchContacts(
                                //       context,
                                //       cachedModel,
                                //       widget.currentUserNo!,
                                //       widget.prefs);
                                //   Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //           builder: (context) =>
                                //               AddContactsToGroup(
                                //                 currentUserNo:
                                //                     widget.currentUserNo,
                                //                 model: cachedModel,
                                //                 biometricEnabled: false,
                                //                 prefs: widget.prefs,
                                //                 isAddingWhileCreatingGroup: true,
                                //               )));
                                // }
                                break;

                              case 'broadcast':
                                // if (observer.isAllowCreatingBroadcasts == false) {
                                //   FiberChatSettings.showRationaleToast(
                                //       getTranslated(this.context, 'disabled'));
                                // } else {
                                //   final AvailableContactsProvider
                                //       dbcontactsProvider =
                                //       Provider.of<AvailableContactsProvider>(
                                //           context,
                                //           listen: false);
                                //   dbcontactsProvider.fetchContacts(
                                //       context,
                                //       cachedModel,
                                //       widget.currentUserNo!,
                                //       widget.prefs);
                                //   await Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //           builder: (context) =>
                                //               AddContactsToBroadcast(
                                //                 currentUserNo:
                                //                     widget.currentUserNo,
                                //                 model: cachedModel,
                                //                 biometricEnabled: false,
                                //                 prefs: widget.prefs,
                                //                 isAddingWhileCreatingBroadcast:
                                //                     true,
                                //               )));
                                // }
                                break;
                            }
                          },
                          itemBuilder: (context) => <PopupMenuItem<String>>[
                                const PopupMenuItem(
                                    value: 'group',
                                    child: CommonText(
                                      text: "New Group",
                                      // getTranslated(context, 'newgroup'),
                                    )),
                                const PopupMenuItem(
                                    value: 'broadcast',
                                    child: CommonText(
                                      text: "New BroadCast",
                                      // getTranslated(context, 'newbroadcast'),
                                    )),
                                const PopupMenuItem(
                                  value: 'tutorials',
                                  child: CommonText(
                                    text: "Tutorials",
                                    // getTranslated(context, 'tutorials'),
                                  ),
                                ),
                                const PopupMenuItem(
                                    value: 'settings',
                                    child: CommonText(
                                      text: "Settings Option",
                                      // getTranslated(context, 'settingsoption'),
                                    )),
                              ]),
                    ],
                    bottom: TabBar(
                      isScrollable: false,
                      // widget.prefs.getString(languageCode) == 'pt' ||
                      //         widget.prefs.getString(languageCode) == 'nl' ||
                      //         widget.prefs.getString(languageCode) == 'vi' ||
                      //         widget.prefs.getString(languageCode) == 'tr' ||
                      //         widget.prefs.getString(languageCode) == 'id' ||
                      //         widget.prefs.getString(languageCode) == 'fr' ||
                      //         widget.prefs.getString(languageCode) == 'es'
                      //     ? true
                      //     : false,
                      labelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      unselectedLabelStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      labelColor: AppConfig.designType == ThemeType.whatsapp
                          ? AppColors.chattingWhite
                          : AppColors.chattingBlack,
                      unselectedLabelColor:
                          AppConfig.designType == ThemeType.whatsapp
                              ? AppColors.chattingWhite.withOpacity(0.6)
                              : AppColors.chattingBlack.withOpacity(0.6),
                      indicatorWeight: 3,
                      indicatorColor: AppConfig.designType == ThemeType.whatsapp
                          ? AppColors.chattingWhite
                          : AppColors.chattingGreen,
                      controller: observer == false
                          ? controllerIfCallAllowed
                          : controllerIfCallNotAllowed,
                      tabs: observer == false
                          ? [
                              const Tab(
                                icon: Icon(
                                  Icons.search,
                                  size: 22,
                                ),
                              ),
                              const Tab(
                                child: CommonText(
                                  text: "Chats",
                                  // getTranslated(context, 'chats'),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const Tab(
                                child: CommonText(
                                  text: "Status",

                                  // getTranslated(context, 'status'),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const Tab(
                                child: CommonText(
                                  text: "Calls",

                                  // getTranslated(context, 'calls'),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ]
                          : [
                              const Icon(
                                Icons.search,
                                size: 22,
                              ),
                              const Tab(
                                child: CommonText(
                                  text: "Chats",

                                  // getTranslated(context, 'chats'),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const Tab(
                                child: CommonText(
                                  text: "Status",

                                  // getTranslated(context, 'status'),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                    )),
                body: TabBarView(
                  controller: observer == false
                      ? controllerIfCallAllowed
                      : controllerIfCallNotAllowed,
                  children: observer == false
                      ? [
                          const SearchContacts(),
                          const RecentChats(),
                          const Status(),
                          const CallHistory()
                          // SearchChats(
                          //     prefs: widget.prefs,
                          //     currentUserNo: widget.currentUserNo,
                          //     isSecuritySetupDone: widget.isSecuritySetupDone),
                          // RecentChats(
                          //     prefs: widget.prefs,
                          //     currentUserNo: widget.currentUserNo,
                          //     isSecuritySetupDone: widget.isSecuritySetupDone),
                          // Status(
                          //     currentUserFullName: userFullName,
                          //     currentUserPhotoUrl: userPhotoUrl,
                          //     phoneNumberVariants: this.phoneNumberVariants,
                          //     currentUserNo: currentUserNo,
                          //     model: cachedModel,
                          //     biometricEnabled: biometricEnabled,
                          //     prefs: widget.prefs),
                          // CallHistory(
                          //   userPhone: widget.currentUserNo,
                          //   prefs: widget.prefs,
                          // ),
                        ]
                      : [
                          // SearchChats(
                          //     prefs: widget.prefs,
                          //     currentUserNo: widget.currentUserNo,
                          //     isSecuritySetupDone:
                          //     widget.isSecuritySetupDone),
                          // RecentChats(
                          //     prefs: widget.prefs,
                          //     currentUserNo: widget.currentUserNo,
                          //     isSecuritySetupDone:
                          //     widget.isSecuritySetupDone),
                          // Status(
                          //     currentUserFullName: userFullName,
                          //     currentUserPhotoUrl: userPhotoUrl,
                          //     phoneNumberVariants:
                          //     this.phoneNumberVariants,
                          //     currentUserNo: currentUserNo,
                          //     model: cachedModel,
                          //     biometricEnabled: biometricEnabled,
                          //     prefs: widget.prefs),
                        ],
                )),
          );
  }

  @override
  bool get wantKeepAlive => true;
}
