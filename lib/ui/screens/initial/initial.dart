import 'package:chat360/ui/screens/login/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/app_config.dart';
import '../../../config/database_keys.dart';
import '../../../data/model/broadcast/broadcast.dart';
import '../../../data/model/group/group.dart';
import '../../../provider/available_contact.dart';
import '../../../provider/broad_cast_chat.dart';
import '../../../provider/call_history.dart';
import '../../../provider/chat_provider.dart';
import '../../../provider/current_chat.dart';
import '../../../provider/download_info_provider.dart';
import '../../../provider/group_chat.dart';
import '../../../provider/observer.dart';
import '../../../provider/seen.dart';
import '../../../provider/status.dart';
import '../../../provider/timer.dart';
import '../../../provider/user.dart';
import '../../../services/broadcast/broadcast.dart';
import '../../../services/firestore_group/group.dart';
import '../../themes/app_colors.dart';
import '../home/home.dart';
import '../splash/splash.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  Locale? myLocale;

  setLocale(Locale locale) {
    setState(() {
      myLocale = locale;
    });
  }

  final Future<FirebaseApp> initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    print("firebase initialization ${initialization.runtimeType}");
    final FirebaseGroupServices groupServices = FirebaseGroupServices();
    final FirebaseBroadcastServices broadcastServices =
    FirebaseBroadcastServices();
    if (myLocale != null) {
      print("locale result $myLocale");
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      );
    } else {
      return FutureBuilder(
        future: initialization,
        builder: (context, snapShot) {
          print("snapshot error ${snapShot.hasError}");
          if (snapShot.hasError) {
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: SplashScreen(),
            );
          }
          if (snapShot.connectionState == ConnectionState.done) {
            print("snapshot data is ${snapShot.connectionState}");

            return FutureBuilder(
              builder: (context, AsyncSnapshot<SharedPreferences> snapshot) {
                print("data state ${snapShot.hasData}");

                if (snapShot.hasData) {
                  print("true");
                  return MultiProvider(
                    providers: [
                      ChangeNotifierProvider(
                          create: (_) => BroadCastChatProvider()),
                      ChangeNotifierProvider(create: (_) => StatusProvider()),
                      ChangeNotifierProvider(create: (_) => TimerProvider()),
                      ChangeNotifierProvider(
                          create: (_) => GroupChatProvider()),
                      ChangeNotifierProvider(create: (_) => ChatProvider()),
                      ChangeNotifierProvider(create: (_) => UserProvider()),
                      ChangeNotifierProvider(create: (_) => ObserverProvider()),
                      ChangeNotifierProvider(
                          create: (_) => CurrentChatProvider()),
                      ChangeNotifierProvider(
                          create: (_) => CallHistoryProvider()),
                      ChangeNotifierProvider(
                          create: (_) => DownloadInfoProvider()),
                      ChangeNotifierProvider(
                          create: (_) => AvailableContactsProvider()),
                      Provider(create: (_) => const SeenProvider())
                    ],
                    child: StreamProvider<List<BroadcastModel>>(
                      initialData: [],
                      create: (BuildContext context) =>
                          broadcastServices.getBroadCastList(
                              snapshot.data!.getString(DatabaseKeys.phone) ??
                                  ""),
                      child: StreamProvider<List<GroupModel>>(
                        initialData: [],
                        create: (BuildContext context) =>
                            groupServices.getGroupList(
                                snapshot.data!.getString(DatabaseKeys.phone) ??
                                    ""),
                        child: MaterialApp(
                          builder: (BuildContext? context, Widget? widget) {
                            ErrorWidget.builder =
                                (FlutterErrorDetails errorDetails) {
                              // return CustomError(errorDetails: errorDetails);
                                  return Container();
                            };

                            return widget!;
                          },
                          theme: ThemeData(
                              fontFamily: AppConfig.fontFamily,
                              primaryColor: AppColors.chattingGreen,
                              primaryColorLight: AppColors.chattingGreen,
                              indicatorColor: AppColors.lightGreen),
                          title: AppConfig.appName,
                          debugShowCheckedModeBanner: false,

                          home: HomePage(
                            prefs: snapshot.data!,
                            currentUserNo:
                            snapshot.data!.getString(DatabaseKeys.phone),
                            isSecuritySetupDone: snapshot.data!.getString(
                                DatabaseKeys.isSecuritySetupDone) ==
                                null
                                ? false
                                : ((snapshot.data!
                                .getString(DatabaseKeys.phone) ==
                                null)
                                ? false
                                : (snapshot.data!.getString(DatabaseKeys
                                .isSecuritySetupDone) ==
                                snapshot.data!
                                    .getString(DatabaseKeys.phone))
                                ? true
                                : false),
                          ),
                          locale: myLocale,
                          // supportedLocales: supportedLocale,
                          localizationsDelegates: [
                            // DemoLocalization.delegate,
                            // GlobalMaterialLocalizations.delegate,
                            // GlobalWidgetsLocalizations.delegate,
                            // GlobalCupertinoLocalizations.delegate,
                          ],
                          localeResolutionCallback: (locale, supportedLocales) {
                            for (var supportedLocale in supportedLocales) {
                              if (supportedLocale.languageCode ==
                                  locale!.languageCode &&
                                  supportedLocale.countryCode ==
                                      locale.countryCode) {
                                return supportedLocale;
                              }
                            }
                            return supportedLocales.first;
                          },
                          //--- All localizations settings ended here----
                        ),
                      ),
                    ),
                  );
                }
                return MultiProvider(
                  providers: [
                    ChangeNotifierProvider(create: (_) => UserProvider())
                  ],
                  child: MaterialApp(
                    theme: ThemeData(
                        fontFamily: AppConfig.fontFamily,
                        primaryColor: AppColors.chattingGreen,
                        primaryColorLight: AppColors.chattingGreen,
                        indicatorColor: AppColors.lightGreen),
                    debugShowCheckedModeBanner: false,
                    home: const SplashScreen(),
                  ),
                );
              },
            );
          }
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
          );
        },
      );
    }
  }
}
