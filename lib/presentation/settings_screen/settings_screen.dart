import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/custom_switch.dart';
import '../myjob_applications_page/myjob_applications_page.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key})
      : super(
          key: key,
        );

  bool isSelectedSwitch = false;

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

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
              _buildAccountColumnIconamoon(context),
              SizedBox(height: 27.v),
              _buildAccountColumnGgdarkmod(context),
              SizedBox(height: 31.v),
              _buildLogout(context),
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
        bottomNavigationBar: _buildBottomBar(context),
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
  Widget _buildAccountColumnIconamoon(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 9.h),
            child: Text(
              "Account",
              style: theme.textTheme.titleMedium,
            ),
          ),
          SizedBox(height: 8.v),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 22.h,
              vertical: 16.v,
            ),
            decoration: AppDecoration.outlineGray.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder12,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 1.h),
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
                          style: CustomTextStyles.titleMediumGray900,
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
                SizedBox(height: 20.v),
                Padding(
                  padding: EdgeInsets.only(left: 1.h),
                  child: _buildJobExperience(
                    context,
                    bagImage: ImageConstant.imgMingcuteBankLine,
                    updateText: "Update Bank Details",
                  ),
                ),
                SizedBox(height: 19.v),
                Padding(
                  padding: EdgeInsets.only(left: 1.h),
                  child: _buildJobExperience(
                    context,
                    bagImage: ImageConstant.imgUilBag,
                    updateText: "Update Job Experience",
                  ),
                ),
                SizedBox(height: 17.v),
                Padding(
                  padding: EdgeInsets.only(left: 1.h),
                  child: _buildJobExperience(
                    context,
                    bagImage: ImageConstant.imgMingcuteNotificationLine,
                    updateText: "Notifications",
                  ),
                ),
                SizedBox(height: 21.v),
                Padding(
                  padding: EdgeInsets.only(left: 1.h),
                  child: _buildJobExperience(
                    context,
                    bagImage: ImageConstant.imgFluentPhone12Regular,
                    updateText: "Change Phone Number",
                  ),
                ),
                SizedBox(height: 19.v),
                Padding(
                  padding: EdgeInsets.only(left: 1.h),
                  child: _buildJobExperience(
                    context,
                    bagImage: ImageConstant.imgMdiPasswordOutline,
                    updateText: "Change Password",
                  ),
                ),
                SizedBox(height: 18.v),
                _buildJobExperience(
                  context,
                  bagImage: ImageConstant.imgUilMoneyWithdrawal,
                  updateText: "Withdraw Earnings",
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildAccountColumnGgdarkmod(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 9.h),
            child: Text(
              "Personalization",
              style: theme.textTheme.titleMedium,
            ),
          ),
          SizedBox(height: 9.v),
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
                        style: CustomTextStyles.titleMediumGray900,
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
                        style: CustomTextStyles.titleMediumGray900,
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
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildLogout(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.h),
      padding: EdgeInsets.symmetric(
        horizontal: 23.h,
        vertical: 18.v,
      ),
      decoration: AppDecoration.outlineGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder12,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgMaterialSymbolsLogout,
            height: 20.adaptSize,
            width: 20.adaptSize,
            margin: EdgeInsets.only(bottom: 4.v),
          ),
          Padding(
            padding: EdgeInsets.only(left: 12.h),
            child: Text(
              "Logout",
              style: CustomTextStyles.titleMediumGray900,
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(
      onChanged: (BottomBarEnum type) {
        Navigator.pushNamed(
            navigatorKey.currentContext!, getCurrentRoute(type));
      },
    );
  }

  /// Common widget
  Widget _buildJobExperience(
    BuildContext context, {
    required String bagImage,
    required String updateText,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomImageView(
          imagePath: bagImage,
          height: 20.adaptSize,
          width: 20.adaptSize,
          margin: EdgeInsets.only(bottom: 2.v),
        ),
        Padding(
          padding: EdgeInsets.only(left: 12.h),
          child: Text(
            updateText,
            style: CustomTextStyles.titleMediumGray900.copyWith(
              color: appTheme.gray900,
            ),
          ),
        ),
        Spacer(),
        CustomImageView(
          imagePath: ImageConstant.imgArrowRight,
          height: 20.v,
          width: 25.h,
          margin: EdgeInsets.only(bottom: 2.v),
        )
      ],
    );
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.myjobApplicationsPage;
      case BottomBarEnum.Messages:
        return "/";
      case BottomBarEnum.Myjobs:
        return "/";
      case BottomBarEnum.Notifications:
        return "/";
      case BottomBarEnum.Settings:
        return "/";
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.myjobApplicationsPage:
        return MyjobApplicationsPage();
      default:
        return DefaultWidget();
    }
  }
}
