import 'package:flutter/material.dart';
import '../../../../core/app_export.dart';
import '../../../../theme/custom_button_style.dart';
import '../../../../widgets/custom_elevated_button.dart'; // ignore: must_be_immutable

class ListchageemyItemWidget extends StatelessWidget {
  const ListchageemyItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.h,
        vertical: 16.v,
      ),
      decoration: AppDecoration.outlineErrorContainer.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 3.v),
          Padding(
            padding: EdgeInsets.only(left: 5.h),
            child: Text(
              "Chagee MY",
              style: theme.textTheme.bodySmall,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 5.h),
            child: Text(
              "Warehouse Crew",
              style: theme.textTheme.titleMedium,
            ),
          ),
          SizedBox(height: 1.v),
          Padding(
            padding: EdgeInsets.only(left: 5.h),
            child: Text(
              "Bukit Raja, Klang",
              style: theme.textTheme.bodySmall,
            ),
          ),
          SizedBox(height: 15.v),
          _buildCompletedButton(context)
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildCompletedButton(BuildContext context) {
    return CustomElevatedButton(
      height: 32.v,
      text: "Completed",
      margin: EdgeInsets.only(left: 4.h),
      buttonStyle: CustomButtonStyles.fillGreen,
      buttonTextStyle: CustomTextStyles.titleMediumGreenA700,
    );
  }
}
