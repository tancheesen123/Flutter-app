import 'package:flutter/material.dart';
import '../core/app_export.dart';

extension IconButtonStyleHelper on CustomIconButton {
  static BoxDecoration get fillBlue => BoxDecoration(
        color: appTheme.blue50,
        borderRadius: BorderRadius.circular(20.h),
      );
  static BoxDecoration get fillIndigo => BoxDecoration(
        color: appTheme.indigo500,
        borderRadius: BorderRadius.circular(20.h),
      );
  static BoxDecoration get fillPrimary => BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(15.h),
      );
  static BoxDecoration get fillGray => BoxDecoration(
        color: appTheme.gray300,
        borderRadius: BorderRadius.circular(15.h),
      );
  static BoxDecoration get fillSecondaryContainer => BoxDecoration(
        color: Color(0xFF007BFF),
        borderRadius: BorderRadius.circular(15.h),
      );
}

class CustomIconButton extends StatelessWidget {
  CustomIconButton(
      {Key? key,
      this.alignment,
      this.height,
      this.width,
      this.padding,
      this.decoration,
      this.child,
      this.onTap})
      : super(
          key: key,
        );

  final Alignment? alignment;

  final double? height;

  final double? width;

  final EdgeInsetsGeometry? padding;

  final BoxDecoration? decoration;

  final Widget? child;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center, child: iconButtonWidget)
        : iconButtonWidget;
  }

  Widget get iconButtonWidget => SizedBox(
        height: height ?? 0,
        width: width ?? 0,
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: Container(
            height: height ?? 0,
            width: width ?? 0,
            padding: padding ?? EdgeInsets.zero,
            decoration: decoration ??
                BoxDecoration(
                  color: theme.colorScheme.onErrorContainer,
                  borderRadius: BorderRadius.circular(14.h),
                ),
            child: child,
          ),
          onPressed: onTap,
        ),
      );
}
