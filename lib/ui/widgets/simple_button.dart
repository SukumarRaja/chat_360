import 'package:flutter/material.dart';

import '../themes/app_colors.dart';

class CommonSimpleButton extends StatefulWidget {
  final Color? buttonColor;
  final Color? buttonTextColor;
  final Color? shadowColor;
  final String? buttonText;
  final double? width;
  final double? height;
  final double? spacing;
  final double? borderRadius;
  final Function? onPressed;

  const CommonSimpleButton(
      {super.key,
        this.buttonText,
        this.buttonColor,
        this.height,
        this.spacing,
        this.borderRadius,
        this.width,
        this.buttonTextColor,
        this.onPressed,
        this.shadowColor});

  @override
  _CommonSimpleButtonState createState() => _CommonSimpleButtonState();
}

class _CommonSimpleButtonState extends State<CommonSimpleButton> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(this.context).size.width;
    return GestureDetector(
        onTap: widget.onPressed as void Function()?,
        child: Container(
          alignment: Alignment.center,
          width: widget.width ?? w - 40,
          height: widget.height ?? 50,
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
          decoration: BoxDecoration(
              color: widget.buttonColor ?? Colors.primaries as Color?,
              //gradient: LinearGradient(colors: [bgColor, whiteColor]),
              boxShadow: [
                BoxShadow(
                    color: widget.shadowColor ?? Colors.transparent,
                    blurRadius: 10,
                    spreadRadius: 2)
              ],
              border: Border.all(
                color: widget.buttonColor ?? AppColors.chattingGreen,
              ),
              borderRadius:
              BorderRadius.all(Radius.circular(widget.borderRadius ?? 5))),
          child: Text(
            // widget.buttonText ?? getTranslated(this.context, 'submit'),
            widget.buttonText ?? "submit",
            textAlign: TextAlign.center,
            style: TextStyle(
              letterSpacing: widget.spacing ?? 2,
              fontSize: 15,
              color: widget.buttonTextColor ?? Colors.white,
            ),
          ),
        ));
  }
}