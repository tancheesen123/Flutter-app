import 'package:flutter/material.dart';
import '../core/app_export.dart';

extension on TextStyle {
  TextStyle get poppins {
    return copyWith(
      fontFamily: 'Poppins',
    );
  }

  TextStyle get sofiaPro {
    return copyWith(
      fontFamily: 'Sofia Pro',
    );
  }
}

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.
class CustomTextStyles {
  // Body text style
  static get bodyLarge18 => theme.textTheme.bodyLarge!.copyWith(
        fontSize: 18.fSize,
      );
  static get bodyMediumWhiteA700 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.whiteA700,
      );
  static get bodyLargeLight => theme.textTheme.bodyLarge!.copyWith(
        fontWeight: FontWeight.w300,
      );
  static get bodyLargeOnError => theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.onError,
        fontWeight: FontWeight.w300,
      );
  static get bodyLargePrimaryContainer => theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.primaryContainer,
      );
  static get bodyLargeOnErrorContainer => theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.onErrorContainer,
      );
  static get bodyLargeSofiaPro => theme.textTheme.bodyLarge!.sofiaPro;
  static get bodySmallGray500 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray500,
      );
  static get bodySmallOnPrimaryContainer => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
        fontSize: 11.fSize,
      );
  static get bodySmallPrimary => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 11.fSize,
      );
  static get bodySmallSofiaProGray500 =>
      theme.textTheme.bodySmall!.sofiaPro.copyWith(
        color: appTheme.gray500,
      );
  static get titleMediumGray900 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray900,
        fontWeight: FontWeight.w500,
      );
  static get bodySmallSecondaryContainer => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.secondaryContainer,
        fontSize: 11.fSize,
      );
  static get bodyLargeGray700 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.gray700,
      );
  static get bodyMediumGray600 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray600,
        fontSize: 14.fSize,
        fontWeight: FontWeight.w300,
      );
  static get bodySmallGray700 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray700.withOpacity(0.8),
      );
  static get bodyMediumGray70001 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray70001,
      );
  static get bodyMediumGray50001_1 => theme.textTheme.bodyMedium!.copyWith(
    color: appTheme.gray50001,
  );
  static get bodyMediumOnErrorContainer => theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.onErrorContainer,
      );
  static get bodyMediumOnPrimary_1 => theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.onPrimary,
      );
  static get bodyMediumGray50001 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray50001,
      );
  static get bodyMediumGray90002 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray90002,
      );
  static get bodyMediumPrimary => theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.primary,
      );
// Headline text style
  static get headlineLargeSemiBold => theme.textTheme.headlineLarge!.copyWith(
        fontWeight: FontWeight.w600,
      );
// Label text style
  static get labelLarge12 => theme.textTheme.labelLarge!.copyWith(
        fontSize: 12.fSize,
      );
  static get labelLargeGreenA700 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.greenA700,
      );
  static get labelLargeGray900 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.gray900,
        fontSize: 12.fSize,
        fontWeight: FontWeight.w600,
      );
  static get labelLargeSofiaProGray500 =>
      theme.textTheme.labelLarge!.sofiaPro.copyWith(
        color: appTheme.gray500,
        fontSize: 12.fSize,
      );
  static get labelLargeSemiBold => theme.textTheme.labelLarge!.copyWith(
        fontSize: 13.fSize,
        fontWeight: FontWeight.w600,
      );
  static get labelLargeGray700 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.gray700,
        fontSize: 13.fSize,
      );
  static get labelLargeOnPrimary => theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.onPrimary,
        fontSize: 13.fSize,
      );
  static get labelLargeBlack900 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.black900,
        fontSize: 13.fSize,
      );
  static get labelLargeGray50001 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.gray50001,
        fontSize: 13.fSize,
      );
// Title text style
  static get titleLargeOnPrimary => theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.onPrimary,
        fontSize: 22.fSize,
        fontWeight: FontWeight.w700,
      );
  static get titleLargeOnPrimaryBold => theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.onPrimary,
        fontSize: 22.fSize,
        fontWeight: FontWeight.w700,
      );
  static get titleMediumGray50 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray50,
      );
  static get titleMediumGray700 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray700,
      );
  static get titleMediumOnErrorContainer =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onErrorContainer,
      );
  static get titleMediumPrimaryContainer =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primaryContainer,
        fontSize: 18.fSize,
        fontWeight: FontWeight.w700,
      );
  static get titleMediumPrimaryContainerSemiBold =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primaryContainer,
        fontWeight: FontWeight.w600,
      );
  static get titleMediumPrimaryContainer_1 =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primaryContainer,
      );
  static get titleMediumSofiaProPrimaryContainer =>
      theme.textTheme.titleMedium!.sofiaPro.copyWith(
        color: theme.colorScheme.primaryContainer,
        fontWeight: FontWeight.w600,
      );
  static get titleSmallBluegray900 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueGray900,
      );
  static get titleSmallGray50 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.gray50,
      );
  static get titleSmallGray50001 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.gray50001,
      );
  static get titleSmallGray90002 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.gray90002,
      );
  static get titleSmallWhiteA700SemiBold =>
      theme.textTheme.titleSmall!.copyWith(
        color: appTheme.whiteA700,
        fontSize: 15.fSize,
        fontWeight: FontWeight.w600,
      );
  static get titleMediumBluegray900 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.blueGray900,
        fontWeight: FontWeight.w500,
      );
  static get titleMediumOrangeA200 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.orangeA200,
        fontWeight: FontWeight.w500,
      );
  static get titleMediumGreenA700 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.greenA700,
        fontWeight: FontWeight.w500,
      );
  static get titleLargeSemiBold => theme.textTheme.titleLarge!.copyWith(
        fontWeight: FontWeight.w600,
      );
  static get titleMediumWhiteA700 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.whiteA700,
      );
  static get titleSmallOnPrimary => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.onPrimary,
      );
  static get titleSmallBlack900 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.black900,
      );
}
