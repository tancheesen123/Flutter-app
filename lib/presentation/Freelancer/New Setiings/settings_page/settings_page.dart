import 'package:flutter/material.dart';
import '../../../../core/app_export.dart';
import '../../../../widgets/app_bar/appbar_title.dart';
import '../../../../widgets/app_bar/custom_app_bar.dart';
import '../../../../widgets/custom_switch.dart'; // ignore_for_file: must_be_immutable
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key})
      : super(
          key: key,
        );

  bool isSelectedSwitch = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(height: 20.v),
              _buildAccount(context),
              SizedBox(height: 40.v),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 29.h),
                  child: Text(
                    "Personalization",
                    style: CustomTextStyles.titleMediumPrimaryContainer,
                  ),
                ),
              ),
              SizedBox(height: 9.v),
              _buildPersonalization(context),
              SizedBox(height: 45.v),
              _buildLogout(context),
              Spacer(),
              Container(
                height: 48.v,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0, 0),
                    end: Alignment(0, 1),
                    colors: [theme.colorScheme.onPrimary, appTheme.gray40011],
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
      centerTitle: true,
      title: AppbarTitle(
        text: "Settings",
      ),
    );
  }

  /// Section Widget
  Widget _buildAccount(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 9.h),
            child: Text(
              "Account",
              style: CustomTextStyles.titleMediumPrimaryContainer,
            ),
          ),
          SizedBox(height: 11.v),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 22.h,
              vertical: 17.v,
            ),
            decoration: AppDecoration.outlineGray.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder12,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgIconamoonProfile,
                        height: 20.adaptSize,
                        width: 20.adaptSize,
                        margin: EdgeInsets.only(top: 2.v),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 12.h),
                        child: Text(
                          "Edit Profile",
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                      Spacer(),
                      CustomImageView(
                        imagePath: ImageConstant.imgArrowRight,
                        height: 20.v,
                        width: 25.h,
                        margin: EdgeInsets.only(top: 2.v),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 24.v),
                Padding(
                  padding: EdgeInsets.only(left: 1.h),
                  child: _buildPassword(
                    context,
                    passwordImage: ImageConstant.imgUilBag,
                    changePasswordText: "Update Job Experience",
                  ),
                ),
                SizedBox(height: 23.v),
                Padding(
                  padding: EdgeInsets.only(right: 1.h),
                  child: _buildPassword(
                    context,
                    passwordImage: ImageConstant.imgMdiPasswordOutline,
                    changePasswordText: "Change Password",
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildPersonalization(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.h),
      padding: EdgeInsets.symmetric(
        horizontal: 22.h,
        vertical: 17.v,
      ),
      decoration: AppDecoration.outlineGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgGgDarkMode,
                height: 20.adaptSize,
                width: 20.adaptSize,
                margin: EdgeInsets.only(bottom: 2.v),
              ),
              Padding(
                padding: EdgeInsets.only(left: 12.h),
                child: Text(
                  "Dark Mode",
                  style: theme.textTheme.titleMedium,
                ),
              ),
              Spacer(),
              CustomSwitch(
                margin: EdgeInsets.symmetric(vertical: 2.v),
                value: isSelectedSwitch,
                onChange: (value) {
                  isSelectedSwitch = value;
                },
              )
            ],
          ),
          SizedBox(height: 20.v),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgMaterialSymbolsLanguage,
                height: 20.adaptSize,
                width: 20.adaptSize,
                margin: EdgeInsets.only(bottom: 4.v),
              ),
              Padding(
                padding: EdgeInsets.only(left: 12.h),
                child: Text(
                  "Language",
                  style: theme.textTheme.titleMedium,
                ),
              ),
              Spacer(),
              Text(
                "English",
                style: CustomTextStyles.bodyLargeOnError,
              ),
              CustomImageView(
                imagePath: ImageConstant.imgArrowRight,
                height: 20.v,
                width: 25.h,
                margin: EdgeInsets.only(
                  left: 5.h,
                  bottom: 4.v,
                ),
              )
            ],
          ),
          SizedBox(height: 4.v)
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildLogout(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 25.h,
          vertical: 18.v,
        ),
        decoration: AppDecoration.outlineGray.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder12,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgArrowLeftPrimary,
              height: 15.adaptSize,
              width: 15.adaptSize,
              margin: EdgeInsets.only(
                top: 3.v,
                bottom: 7.v,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 14.h,
                top: 1.v,
              ),
              child: Text(
                "Logout",
                style: theme.textTheme.titleMedium,
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Common widget
  Widget _buildPassword(
    BuildContext context, {
    required String passwordImage,
    required String changePasswordText,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomImageView(
          imagePath: passwordImage,
          height: 20.adaptSize,
          width: 20.adaptSize,
          margin: EdgeInsets.only(bottom: 3.v),
        ),
        Padding(
          padding: EdgeInsets.only(left: 12.h),
          child: Text(
            changePasswordText,
            style: theme.textTheme.titleMedium!.copyWith(
              color: appTheme.gray900,
            ),
          ),
        ),
        Spacer(),
        CustomImageView(
          imagePath: ImageConstant.imgArrowRight,
          height: 20.v,
          width: 25.h,
          margin: EdgeInsets.only(bottom: 3.v),
        )
      ],
    );
  }
}
