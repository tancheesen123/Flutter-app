import 'package:flutter/material.dart';
import '../core/app_export.dart';
import 'base_button.dart';

class CustomOutlinedButton extends BaseButton {
  CustomOutlinedButton(
      {Key? key,
      this.decoration,
      this.leftIcon,
      this.rightIcon,
      this.label,
      VoidCallback? onPressed,
      ButtonStyle? buttonStyle,
      TextStyle? buttonTextStyle,
      bool? isDisabled,
      Alignment? alignment,
      double? height,
      double? width,
      EdgeInsets? margin,
      required String text})
      : super(
          text: text,
          onPressed: onPressed,
          buttonStyle: buttonStyle,
          isDisabled: isDisabled,
          buttonTextStyle: buttonTextStyle,
          height: height,
          alignment: alignment,
          width: width,
          margin: margin,
        );

  final BoxDecoration? decoration;

  final Widget? leftIcon;

  final Widget? rightIcon;

  final Widget? label;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: buildOutlinedButtonWidget)
        : buildOutlinedButtonWidget;
  }

  Widget get buildOutlinedButtonWidget => Container(
        height: this.height ?? 54.v,
        width: this.width ?? double.maxFinite,
        margin: margin,
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(12.0), // Set the desired border radius
          border: Border.all(color: Color(0xFF007BFF)), // Add border
        ),
        child: Material(
          borderRadius:
              BorderRadius.circular(12.0), // Set the same border radius
          clipBehavior:
              Clip.antiAlias, // Clip content outside the border radius
          child: InkWell(
            onTap: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                leftIcon ?? const SizedBox.shrink(),
                Text(
                  text,
                  style: buttonTextStyle != null
                      ? buttonTextStyle!.copyWith(color: Color(0xFF007BFF))
                      : TextStyle(
                          color: Color(0xFF007BFF)), // Change text color
                ),
                rightIcon ?? const SizedBox.shrink()
              ],
            ),
          ),
        ),
      );
}
