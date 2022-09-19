import 'package:chat_360/ui/themes/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../config/app_config.dart';
import '../../../translations/language.dart';
import '../../../utility/enum.dart';
import '../../widgets/common_text.dart';
import '../call/call_history.dart';
import '../chat/recent.dart';
import '../chat/search.dart';
import '../error/error.dart';
import '../pick_up/pick_up.dart';
import '../status/status.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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
      // FiberChatSettings.toast('Double Tap To Go Back');
      return Future.value(false);
    } else {
      // if (!isAuthenticating) setLastSeen();
      return Future.value(true);
    }
  }

  @override
  void initState() {
    // listenToSharingIntent();
    // listenToNotification();
    // getSignedInUserOrRedirect();
    // setDeviceInfo();
    // registerNotification();

    controllerIfCallAllowed = TabController(length: 4, vsync: this);
    controllerIfCallAllowed!.index = 1;
    controllerIfCallNotAllowed = TabController(length: 3, vsync: this);
    controllerIfCallNotAllowed!.index = 1;

    // FiberChatSettings.internetLookUp();
    WidgetsBinding.instance.addObserver(this);

    // LocalAuthentication().canCheckBiometrics.then((res) {
    //   if (res) biometricEnabled = true;
    // });
    // getModel();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controllerIfCallAllowed!.addListener(() {
        if (controllerIfCallAllowed!.index == 2) {
          // final statusProvider =
          // Provider.of<StatusProvider>(context, listen: false);
          // final contactsProvider =
          // Provider.of<AvailableContactsProvider>(context, listen: false);
          // statusProvider.searchContactStatus(widget.currentUserNo!,
          //     contactsProvider.joinedUserPhoneStringAsInServer);
        }
      });
      controllerIfCallNotAllowed!.addListener(() {
        if (controllerIfCallNotAllowed!.index == 2) {
          // final statusProvider =
          // Provider.of<StatusProvider>(context, listen: false);
          // final contactsProvider =
          // Provider.of<AvailableContactsProvider>(context, listen: false);
          // statusProvider.searchContactStatus(widget.currentUserNo!,
          //     contactsProvider.joinedUserPhoneStringAsInServer);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isNotAllowEmulator = false;
    bool isFetching = false;
    bool observer = false;
    String accountStatus = "data";
    String maintenanceMessage = "data";
    int length = 2;

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
