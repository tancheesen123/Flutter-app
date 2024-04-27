import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../widgets/app_bar/appbar_leading_image.dart';
import '../../../widgets/app_bar/appbar_title.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../widgets/custom_drop_down.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_text_form_field.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController dateOfBirthController = TextEditingController();

  List<String> dropdownItemList = ["Item One", "Item Two", "Item Three"];

  TextEditingController identitynumbervController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 33.v),
            child: Column(
              children: [
                SizedBox(
                  height: 82.v,
                  width: 80.h,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgRectangle382,
                        height: 80.adaptSize,
                        width: 80.adaptSize,
                        radius: BorderRadius.circular(
                          40.h,
                        ),
                        alignment: Alignment.center,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          height: 19.adaptSize,
                          width: 19.adaptSize,
                          margin: EdgeInsets.only(right: 6.h),
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.h,
                            vertical: 6.v,
                          ),
                          decoration: AppDecoration.outlineGray5001.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder9,
                          ),
                          child: CustomImageView(
                            imagePath: ImageConstant.imgFill244,
                            height: 5.v,
                            width: 6.h,
                            alignment: Alignment.centerLeft,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10.v),
                Text(
                  "Adam Shafi",
                  style: theme.textTheme.headlineLarge,
                ),
                Text(
                  "Edit Profile",
                  style: theme.textTheme.bodyMedium,
                ),
                SizedBox(height: 34.v),
                _buildNameColumn(context),
                SizedBox(height: 24.v),
                _buildEmailColumn(context),
                SizedBox(height: 24.v),
                _buildDateOfBirthColumn(context),
                SizedBox(height: 25.v),
                _buildGenderColumn(context),
                SizedBox(height: 5.v),
                _buildStackCloseOne(context),
                SizedBox(height: 29.v),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 25.h),
                    child: Text(
                      "Identity Number",
                      style: theme.textTheme.bodyLarge,
                    ),
                  ),
                ),
                SizedBox(height: 9.v),
                Padding(
                  padding: EdgeInsets.only(
                    left: 25.h,
                    right: 15.h,
                  ),
                  child: CustomTextFormField(
                    controller: identitynumbervController,
                    hintText: "960908-01-5789",
                    textInputAction: TextInputAction.done,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 21.h,
                      vertical: 19.v,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 85.v,
      leadingWidth: 30.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(
          left: 20.h,
          top: 45.v,
          bottom: 19.v,
        ),
        onTap: () {
          onTapArrowleftone(context);
        },
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "Profile",
        margin: EdgeInsets.only(
          top: 39.v,
          bottom: 15.v,
        ),
      ),
      styleType: Style.bgFill,
    );
  }

  /// Section Widget
  Widget _buildNameColumn(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10.h),
            child: Text(
              "Name",
              style: theme.textTheme.bodyLarge,
            ),
          ),
          SizedBox(height: 5.v),
          Padding(
            padding: EdgeInsets.only(left: 10.h),
            child: CustomTextFormField(
              controller: nameController,
              hintText: "Adam Shafi",
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildEmailColumn(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10.h),
            child: Text(
              "Email",
              style: theme.textTheme.bodyLarge,
            ),
          ),
          SizedBox(height: 6.v),
          Padding(
            padding: EdgeInsets.only(left: 10.h),
            child: CustomTextFormField(
              controller: emailController,
              hintText: "hellobesnik@gmail.com",
              textInputType: TextInputType.emailAddress,
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildDateOfBirthColumn(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10.h),
            child: Text(
              "Date of Birth",
              style: theme.textTheme.bodyLarge,
            ),
          ),
          SizedBox(height: 5.v),
          Padding(
            padding: EdgeInsets.only(left: 10.h),
            child: CustomTextFormField(
              controller: dateOfBirthController,
              hintText: "8 Sep 1996",
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildGenderColumn(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10.h),
            child: Text(
              "Gender",
              style: theme.textTheme.bodyLarge,
            ),
          ),
          SizedBox(height: 4.v),
          Padding(
            padding: EdgeInsets.only(left: 10.h),
            child: CustomDropDown(
              icon: Container(
                margin: EdgeInsets.symmetric(horizontal: 17.h),
                child: CustomImageView(
                  imagePath: ImageConstant.imgArrowdown,
                  height: 7.v,
                  width: 13.h,
                ),
              ),
              hintText: "Male",
              items: dropdownItemList,
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildStackCloseOne(BuildContext context) {
    return SizedBox(
      height: 101.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(
                left: 25.h,
                top: 49.v,
                right: 15.h,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 11.h,
                vertical: 12.v,
              ),
              decoration: AppDecoration.outlineGray300.copyWith(
                borderRadius: BorderRadiusStyle.roundedBorder9,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgClose,
                    height: 25.adaptSize,
                    width: 25.adaptSize,
                    margin: EdgeInsets.only(top: 1.v),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 6.h,
                      top: 6.v,
                      bottom: 6.v,
                    ),
                    child: Text(
                      "Malaysian",
                      style: theme.textTheme.titleSmall,
                    ),
                  ),
                  Spacer(),
                  CustomImageView(
                    imagePath: ImageConstant.imgArrowdown,
                    height: 7.v,
                    width: 13.h,
                    margin: EdgeInsets.only(
                      top: 9.v,
                      right: 5.h,
                      bottom: 10.v,
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: 25.h,
                top: 24.v,
              ),
              child: Text(
                "Nationality",
                style: theme.textTheme.bodyLarge,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 48.v,
              width: double.maxFinite,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0, 0),
                  end: Alignment(0, 1),
                  colors: [theme.colorScheme.onPrimary, appTheme.gray40011],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 4.v),
              padding: EdgeInsets.symmetric(
                horizontal: 20.h,
                vertical: 12.v,
              ),
              decoration: AppDecoration.outlineErrorContainer.copyWith(
                borderRadius: BorderRadiusStyle.customBorderTL30,
              ),
              child: CustomElevatedButton(
                height: 48.v,
                text: "Save Now",
                buttonTextStyle: CustomTextStyles.titleSmallWhiteA700SemiBold,
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Navigates back to the previous screen.
  onTapArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }
}
