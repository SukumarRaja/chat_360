import 'package:flutter/material.dart';

class CommonText extends StatelessWidget {
  const CommonText(
      {Key? key,
      required this.text,
      this.fontColor,
      this.fontSize,
      this.fontWeight,
      this.textAlign,
      this.height})
      : super(key: key);
  final String text;
  final Color? fontColor;
  final double? fontSize;
  final double? height;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
          color: fontColor,
          fontFamily: "",
          fontSize: fontSize,
          fontWeight: fontWeight,
          height: height),
    );
  }
}
