import 'package:chat360/ui/screens/splash/splash.dart';
import 'package:flutter/material.dart';

class PickUpLayout extends StatelessWidget {
  const PickUpLayout({Key? key, required this.scaffold}) : super(key: key);
  final Widget scaffold;

  // final CallMethods callMethods = CallMethods();

  @override
  Widget build(BuildContext context) {
    bool isUser = true;
    // final UserProvider userProvider = Provider.of<UserProvider>(context);
    //
    // // ignore: unnecessary_null_comparison
    // return (userProvider != null && userProvider.getUser != null)
    //     ? StreamBuilder<DocumentSnapshot>(
    //   stream: callMethods.callStream(phone: userProvider.getUser!.phone),
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData && snapshot.data!.data() != null) {
    //       Call call = Call.fromMap(
    //           snapshot.data!.data() as Map<dynamic, dynamic>);
    //
    //       if (!call.hasDialled!) {
    //         return PickupScreen(
    //           call: call,
    //           currentUserUid: userProvider.getUser!.phone,
    //         );
    //       }
    //     }
    //     return scaffold;
    //   },
    // )
    //     : Splashscreen();
    return isUser == true ? scaffold : SplashScreen();
  }
}
