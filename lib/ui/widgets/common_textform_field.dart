import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../themes/app_colors.dart';

class CommonTextFormField extends StatefulWidget {
  final Color? boxBackgroundColor;
  final Color? boxBorderColor;
  final double? boxCornerRadius;
  final double? fontSize;
  final double? boxWidth;
  final double? boxBorderWidth;
  final double? boxHeight;
  final EdgeInsets? forcedMargin;
  final double? letterSpacing;
  final double? leftRightMargin;
  final TextEditingController? controller;
  final Function(String val)? validator;
  final Function(String? val)? onSaved;
  final Function(String val)? onChanged;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final String? title;
  final String? subtitle;
  final String? hintText;
  final String? placeholder;
  final int? maxLines;
  final int? minLines;
  final int? maxCharacters;
  final bool? isBoldInput;
  final bool? obscureText;
  final bool? autoValidate;
  final bool? disabled;
  final bool? showIconBoundary;
  final Widget? suffixIconButton;
  final List<TextInputFormatter>? inputFormatter;
  final Widget? prefixIconButton;

  const CommonTextFormField(
      {super.key,
        this.controller,
        this.boxBorderColor,
        this.boxHeight,
        this.fontSize,
        this.leftRightMargin,
        this.letterSpacing,
        this.forcedMargin,
        this.boxWidth,
        this.boxCornerRadius,
        this.boxBackgroundColor,
        this.hintText,
        this.boxBorderWidth,
        this.onSaved,
        this.textCapitalization,
        this.onChanged,
        this.placeholder,
        this.showIconBoundary,
        this.subtitle,
        this.disabled,
        this.keyboardType,
        this.inputFormatter,
        this.validator,
        this.title,
        this.maxLines,
        this.autoValidate,
        this.prefixIconButton,
        this.maxCharacters,
        this.isBoldInput,
        this.obscureText,
        this.suffixIconButton,
        this.minLines});

  @override
  _CommonTextFormFieldState createState() => _CommonTextFormFieldState();
}

class _CommonTextFormFieldState extends State<CommonTextFormField> {
  bool isObscureText = false;

  @override
  void initState() {
    super.initState();
    setState(
          () {
        isObscureText = widget.obscureText ?? false;
      },
    );
  }

  changObscure() {
    setState(() {
      isObscureText = !isObscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(this.context).size.width;
    return Align(
      child: Container(
        margin: EdgeInsets.fromLTRB(
            widget.leftRightMargin ?? 8, 5, widget.leftRightMargin ?? 8, 5),
        width: widget.boxWidth ?? w,
        child: SizedBox(
          height: widget.boxHeight ?? 50,
          // decoration: BoxDecoration(
          //     color: widget.boxBackgroundColor ?? Colors.white,
          //     border: Border.all(
          //         color:
          //             widget.boxBorderColor ?? Colors.grey.withOpacity(0.2),
          //         style: BorderStyle.solid,
          //         width: 1.8),
          //     borderRadius: BorderRadius.all(
          //         Radius.circular(widget.boxCornerRadius ?? 5))),
          child: TextFormField(
            minLines: widget.minLines,
            maxLines: widget.maxLines ?? 1,
            controller: widget.controller,
            obscureText: isObscureText,
            onSaved: widget.onSaved ?? (val) {},
            readOnly: widget.disabled ?? false,
            onChanged: widget.onChanged ?? (val) {},
            maxLength: widget.maxCharacters,
            validator: widget.validator as String? Function(String?)?,
            keyboardType: widget.keyboardType,
            autovalidateMode: widget.autoValidate == true
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            inputFormatters: widget.inputFormatter ?? [],
            textCapitalization:
            widget.textCapitalization ?? TextCapitalization.sentences,
            style: TextStyle(
              letterSpacing: widget.letterSpacing,
              fontSize: widget.fontSize ?? 15,
              fontWeight: widget.isBoldInput == true
                  ? FontWeight.w600
                  : FontWeight.w400,
              // fontFamily:
              //     widget.isBoldInput == true ? 'NotoBold' : 'NotoRegular',
              color: Colors.black,
            ),
            decoration: InputDecoration(
              prefixIcon: widget.prefixIconButton != null
                  ? Container(
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                          width: widget.boxBorderWidth ?? 1.5,
                          color: widget.showIconBoundary == true ||
                              widget.showIconBoundary == null
                              ? Colors.grey.withOpacity(0.3)
                              : Colors.transparent),
                    ),
                    // color: Colors.white,
                  ),
                  margin: const EdgeInsets.only(
                      left: 2, right: 5, top: 2, bottom: 2),
                  // height: 45,
                  alignment: Alignment.center,
                  width: 50,
                  child: widget.prefixIconButton)
                  : null,
              suffixIcon: widget.suffixIconButton != null ||
                  widget.obscureText == true
                  ? Container(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                        width: widget.boxBorderWidth ?? 1.5,
                        color: widget.showIconBoundary == true ||
                            widget.showIconBoundary == null
                            ? Colors.grey.withOpacity(0.3)
                            : Colors.transparent),
                  ),
                  // color: Colors.white,
                ),
                margin: const EdgeInsets.only(
                    left: 2, right: 5, top: 2, bottom: 2),
                // height: 45,
                alignment: Alignment.center,
                width: 50,
                child: widget.suffixIconButton ??
                    (widget.obscureText == true
                        ? IconButton(
                      icon: Icon(
                          isObscureText == true
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.blueGrey),
                      onPressed: () {
                        changObscure();
                      },
                    )
                        : null),
              )
                  : null,
              filled: true,
              fillColor: widget.boxBackgroundColor ?? Colors.white,
              enabledBorder: OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderRadius:
                BorderRadius.circular(widget.boxCornerRadius ?? 1),
                borderSide: BorderSide(
                    color: widget.boxBorderColor ??
                        Colors.grey.withOpacity(0.2),
                    width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                // width: 0.0 produces a thin "hairline" border
                borderRadius:
                BorderRadius.circular(widget.boxCornerRadius ?? 1),
                borderSide: const BorderSide(
                    color: AppColors.chattingGreen, width: 1.5),
              ),
              border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(widget.boxCornerRadius ?? 1),
                  borderSide: const BorderSide(color: Colors.grey)),
              contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              // labelText: 'Password',
              hintText: widget.hintText ?? '',
              // fillColor: widget.boxBackgroundColor ?? Colors.white,

              hintStyle: TextStyle(
                  letterSpacing: widget.letterSpacing ?? 1.5,
                  color: AppColors.grey,
                  fontSize: 15.5,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
    );
  }
}