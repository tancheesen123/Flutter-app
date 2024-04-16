import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_outlined_button.dart';
import 'widgets/category_item_widget.dart';

class SelectJobPreferenceScreen extends StatelessWidget {
  const SelectJobPreferenceScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              _buildStackView(context),
              SizedBox(height: 14.v),
              Container(
                width: 302.h,
                margin: EdgeInsets.only(
                  left: 40.h,
                  right: 32.h,
                ),
                child: Text(
                  "Select the job categories that you are looking for",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.bodyLarge18.copyWith(
                    height: 1.33,
                  ),
                ),
              ),
              SizedBox(height: 19.v),
              _buildCategory(context)
            ],
          ),
        ),
        bottomNavigationBar: _buildRowSkip(context),
      ),
    );
  }

  /// Section Widget
  Widget _buildStackView(BuildContext context) {
    return SizedBox(
      height: 91.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 85.v,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: appTheme.gray50,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              "Job Preference",
              style: theme.textTheme.headlineMedium,
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildCategory(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 28.h,
        right: 20.h,
      ),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 123.v,
          crossAxisCount: 2,
          mainAxisSpacing: 16.h,
          crossAxisSpacing: 16.h,
        ),
        physics: NeverScrollableScrollPhysics(),
        itemCount: 8,
        itemBuilder: (context, index) {
          return CategoryItemWidget();
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildRowSkip(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 21.h,
        right: 21.h,
        bottom: 23.v,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomOutlinedButton(
            height: 44.v,
            width: 161.h,
            text: "Skip",
            buttonTextStyle: theme.textTheme.titleSmall!,
          ),
          CustomElevatedButton(
            height: 44.v,
            width: 161.h,
            text: "Continue",
            margin: EdgeInsets.only(left: 11.h),
            buttonStyle: CustomButtonStyles.fillGrayC,
            buttonTextStyle: CustomTextStyles.titleSmallGray50,
          )
        ],
      ),
    );
  }
}
