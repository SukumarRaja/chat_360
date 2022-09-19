import 'package:flutter/material.dart';
import '../../../config/limit_constants.dart';
import '../../themes/app_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LimitConstants.isSplashOnlySolidColor == true
        ? const Scaffold(
            backgroundColor: AppColors.splashColor,
            body: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.lightGreen),
              ),
            ))
        : Scaffold(
            backgroundColor: AppColors.splashColor,
            body: Center(
              child: Image.asset(
                'assets/images/splash.jpeg',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          );
  }
}
