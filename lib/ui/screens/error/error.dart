import 'package:flutter/material.dart';
import '../../themes/app_colors.dart';
import '../../widgets/common_text.dart';

class CommonErrorScreen extends StatelessWidget {
  const CommonErrorScreen(
      {Key? key, required this.title, required this.subTitle})
      : super(key: key);
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deepGreen,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline_outlined,
                size: 60,
                color: Colors.yellowAccent,
              ),
              const SizedBox(
                height: 30,
              ),
              CommonText(
                  text: title,
                  textAlign: TextAlign.center,
                  fontSize: 20,
                  fontColor: AppColors.chattingWhite,
                  fontWeight: FontWeight.w700),
              const SizedBox(
                height: 20,
              ),
              CommonText(
                  text: subTitle,
                  textAlign: TextAlign.center,
                  fontSize: 17,
                  fontColor: AppColors.chattingWhite.withOpacity(0.7),
                  fontWeight: FontWeight.w400)
            ],
          ),
        ),
      ),
    );
  }
}
