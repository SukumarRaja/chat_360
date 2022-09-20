import 'package:flutter/material.dart';

class CommonText extends StatelessWidget {
  const CommonText(
      {Key? key,
      required this.text,
      this.fontColor,
      this.fontSize,
      this.fontWeight,
      this.textAlign,
      this.height,
      this.maxLines,
      this.overFlow})
      : super(key: key);
  final String text;
  final Color? fontColor;
  final double? fontSize;
  final double? height;
  final int? maxLines;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextOverflow? overFlow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overFlow,
      style: TextStyle(
          color: fontColor,
          fontFamily: "",
          fontSize: fontSize,
          fontWeight: fontWeight,
          height: height),
    );
  }
}
