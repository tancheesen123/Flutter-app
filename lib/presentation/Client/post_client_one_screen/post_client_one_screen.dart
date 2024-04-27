import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../theme/custom_button_style.dart';
import '../../../widgets/app_bar/appbar_leading_image.dart';
import '../../../widgets/app_bar/appbar_title.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_text_form_field.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class PostClientOneScreen extends StatelessWidget {
  PostClientOneScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController jobtitleoneController = TextEditingController();

  TextEditingController locationController = TextEditingController();

  TextEditingController rmCounterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: SizedBox(
          height: 729.v,
          width: double.maxFinite,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              _buildRowCancel(context),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 37.h,
                    top: 32.v,
                    right: 37.h,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildColumnTitle(context),
                      SizedBox(height: 23.v),
                      _buildColumnLocation(context),
                      SizedBox(height: 39.v),
                      _buildColumnYourBudget(context),
                      SizedBox(height: 30.v),
                      _buildColumnView(context)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 30.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(
          left: 20.h,
          top: 18.v,
          bottom: 16.v,
        ),
        onTap: () {
          onTapArrowleftone(context);
        },
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "New Job Post",
      ),
    );
  }

  /// Section Widget
  Widget _buildRowCancel(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 374.h,
        margin: EdgeInsets.only(
          left: 1.h,
          top: 637.v,
        ),
        padding: EdgeInsets.symmetric(vertical: 11.v),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              ImageConstant.imgGroup71,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomElevatedButton(
              width: 150.h,
              text: "Cancel",
              margin: EdgeInsets.only(top: 32.v),
              buttonStyle: CustomButtonStyles.fillGray,
              buttonTextStyle: CustomTextStyles.bodyMediumGray70001,
              onPressed: () {
                onTapCancel(context);
              },
            ),
            CustomElevatedButton(
              width: 156.h,
              text: "Preview",
              margin: EdgeInsets.only(top: 32.v),
              buttonStyle: CustomButtonStyles.fillSecondaryContainer,
              buttonTextStyle: CustomTextStyles.bodyMediumOnErrorContainer,
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildColumnTitle(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.h),
          child: _buildRowyourbudgetpe(
            context,
            budgetPerHour: "Title",
          ),
        ),
        SizedBox(height: 5.v),
        CustomTextFormField(
          controller: jobtitleoneController,
          hintText: "Tea Barista",
          hintStyle: CustomTextStyles.bodyLargeLight,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 13.h,
            vertical: 10.v,
          ),
        )
      ],
    );
  }

  /// Section Widget
  Widget _buildColumnLocation(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 7.h),
          child: Text(
            "Location",
            style: theme.textTheme.bodyLarge,
          ),
        ),
        SizedBox(height: 5.v),
        CustomTextFormField(
          controller: locationController,
          hintText: "Intermark Mall, KL",
        )
      ],
    );
  }

  /// Section Widget
  Widget _buildColumnYourBudget(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.h),
          child: _buildRowyourbudgetpe(
            context,
            budgetPerHour: "Your budget per hour",
          ),
        ),
        SizedBox(height: 2.v),
        CustomTextFormField(
          controller: rmCounterController,
          hintText: "RM 15.00",
          textInputAction: TextInputAction.done,
        )
      ],
    );
  }

  /// Section Widget
  Widget _buildColumnView(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.h),
          child: _buildRowyourbudgetpe(
            context,
            budgetPerHour: "Description",
          ),
        ),
        SizedBox(height: 6.v),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 19.h,
            vertical: 16.v,
          ),
          decoration: AppDecoration.fillOnErrorContainer.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder15,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 5.adaptSize,
                    width: 5.adaptSize,
                    margin: EdgeInsets.only(
                      top: 6.v,
                      bottom: 7.v,
                    ),
                    decoration: BoxDecoration(
                      color: appTheme.gray900,
                      borderRadius: BorderRadius.circular(
                        2.h,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.h),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Call time for this job is ",
                            style: theme.textTheme.bodyMedium,
                          ),
                          TextSpan(
                            text: "9.30 am sharp.",
                            style: CustomTextStyles.labelLargeSemiBold,
                          )
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                  )
                ],
              ),
              SizedBox(height: 12.v),
              Padding(
                padding: EdgeInsets.only(right: 40.h),
                child: Row(
                  children: [
                    Container(
                      height: 5.adaptSize,
                      width: 5.adaptSize,
                      margin: EdgeInsets.only(
                        top: 7.v,
                        bottom: 6.v,
                      ),
                      decoration: BoxDecoration(
                        color: appTheme.gray900,
                        borderRadius: BorderRadius.circular(
                          2.h,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.h),
                      child: Text(
                        "On-site briefing will be provided",
                        style: theme.textTheme.bodyMedium,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 11.v),
              Padding(
                padding: EdgeInsets.only(right: 17.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 5.adaptSize,
                      width: 5.adaptSize,
                      margin: EdgeInsets.only(
                        top: 8.v,
                        bottom: 130.v,
                      ),
                      decoration: BoxDecoration(
                        color: appTheme.gray900,
                        borderRadius: BorderRadius.circular(
                          2.h,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: 229.h,
                        margin: EdgeInsets.only(left: 10.h),
                        child: Text(
                          "Job Scope:\nPrepare beverages following the recipes given\nTake order\nClean up the bar area\nAssist in any ad-hoc task",
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            height: 1.85,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 28.v),
              Row(
                children: [
                  Container(
                    height: 5.adaptSize,
                    width: 5.adaptSize,
                    margin: EdgeInsets.only(
                      top: 7.v,
                      bottom: 6.v,
                    ),
                    decoration: BoxDecoration(
                      color: appTheme.gray900,
                      borderRadius: BorderRadius.circular(
                        2.h,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.h),
                    child: Text(
                      "Plain black attire only",
                      style: theme.textTheme.bodyMedium,
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  /// Common widget
  Widget _buildRowyourbudgetpe(
    BuildContext context, {
    required String budgetPerHour,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          budgetPerHour,
          style: theme.textTheme.bodyLarge!.copyWith(
            color: appTheme.black900,
          ),
        ),
        CustomImageView(
          imagePath: ImageConstant.imgIcons8Information,
          height: 13.adaptSize,
          width: 13.adaptSize,
          margin: EdgeInsets.only(
            top: 3.v,
            bottom: 7.v,
          ),
        )
      ],
    );
  }

  /// Navigates back to the previous screen.
  onTapArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }

  /// Navigates to the postClientScreen when the action is triggered.
  onTapCancel(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.postClientScreen);
  }
}
