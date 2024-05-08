import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../widgets/app_bar/appbar_title.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../widgets/custom_bottom_bar.dart';
import '../../../widgets/custom_switch.dart';
import '../myjob_applications_page/myjob_applications_page.dart';
import '../../log_in_screen/log_in_screen.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key? key})
      : super(
          key: key,
        );

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isSelectedSwitch = false;

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              children: [
                SizedBox(height: 20.v),
                _buildAccountColumnIconamoon(context),
                SizedBox(height: 27.v),
                _buildAccountColumnGgdarkmod(context),
                SizedBox(height: 31.v),
                _buildLogout(context),
                // Container(
                //   height: 48.v,
                //   width: double.maxFinite,
                //   decoration: BoxDecoration(
                //     gradient: LinearGradient(
                //       begin: Alignment(0, 0),
                //       end: Alignment(0, 1),
                //       colors: [theme.colorScheme.onPrimary, appTheme.gray40011],
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ),
        // bottomNavigationBar: _buildBottomBar(context),
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
    return GestureDetector(
      onTap: () async {
        try {
          await logout(context); // Call the logout function passing the context
        } catch (e) {
          // Handle any errors here
          print("Error during logout: $e");
        }
      },
      child: Container(
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
              margin: EdgeInsets.only(bottom: 6.v),
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
      ),
    );
  }

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

  FirebaseAuth auth = FirebaseAuth.instance;

  signOut() async {
    await auth.signOut();
  }

  Future<void> logout(BuildContext context) async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

    try {
      await _firebaseAuth.signOut();
      await deleteAllData();

      Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return LogInScreen();
          },
        ),
        (_) => false,
      );
    } catch (e) {
      // Handle any errors here
      print("Error signing out: $e");
    }
  }

  Future<void> deleteAllData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    print('All data deleted successfully');
  }
}
