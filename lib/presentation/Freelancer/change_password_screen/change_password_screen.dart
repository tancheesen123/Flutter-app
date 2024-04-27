import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../theme/custom_button_style.dart';
import '../../../widgets/app_bar/appbar_leading_image.dart';
import '../../../widgets/app_bar/appbar_title.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_text_form_field.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController newpasswordController = TextEditingController();

  TextEditingController newpassword1Controller = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Form(
            key: _formKey,
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(
                horizontal: 20.h,
                vertical: 42.v,
              ),
              child: Column(
                children: [
                  Container(
                    width: 283.h,
                    margin: EdgeInsets.only(
                      left: 26.h,
                      right: 24.h,
                    ),
                    child: Text(
                      "Enter your new password and confirm the new password to change password",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: CustomTextStyles.bodyMediumGray600.copyWith(
                        height: 1.50,
                      ),
                    ),
                  ),
                  SizedBox(height: 44.v),
                  CustomTextFormField(
                    controller: newpasswordController,
                    hintText: "New Password",
                    textInputType: TextInputType.visiblePassword,
                    prefix: Container(
                      margin: EdgeInsets.fromLTRB(20.h, 12.v, 15.h, 16.v),
                      child: CustomImageView(
                        imagePath: ImageConstant.imgLocation,
                        height: 26.v,
                        width: 20.h,
                      ),
                    ),
                    prefixConstraints: BoxConstraints(
                      maxHeight: 54.v,
                    ),
                    suffix: Container(
                      margin: EdgeInsets.fromLTRB(30.h, 20.v, 20.h, 20.v),
                      child: CustomImageView(
                        imagePath: ImageConstant.imgUnion,
                        height: 13.v,
                        width: 16.h,
                      ),
                    ),
                    suffixConstraints: BoxConstraints(
                      maxHeight: 54.v,
                    ),
                    obscureText: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 15.v),
                    borderDecoration:
                        TextFormFieldStyleHelper.fillOnErrorContainerTL12,
                  ),
                  SizedBox(height: 46.v),
                  CustomTextFormField(
                    controller: newpassword1Controller,
                    hintText: "Confirm New Password",
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.visiblePassword,
                    prefix: Container(
                      margin: EdgeInsets.fromLTRB(20.h, 12.v, 15.h, 16.v),
                      child: CustomImageView(
                        imagePath: ImageConstant.imgLocation,
                        height: 26.v,
                        width: 20.h,
                      ),
                    ),
                    prefixConstraints: BoxConstraints(
                      maxHeight: 54.v,
                    ),
                    suffix: Container(
                      margin: EdgeInsets.fromLTRB(30.h, 20.v, 20.h, 20.v),
                      child: CustomImageView(
                        imagePath: ImageConstant.imgUnion,
                        height: 13.v,
                        width: 16.h,
                      ),
                    ),
                    suffixConstraints: BoxConstraints(
                      maxHeight: 54.v,
                    ),
                    obscureText: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 15.v),
                    borderDecoration:
                        TextFormFieldStyleHelper.fillOnErrorContainerTL12,
                  ),
                  SizedBox(height: 20.v),
                  SizedBox(
                    width: 330.h,
                    child: Text(
                      "* Minimum of 8 alphanumeric characters. At least \none uppercase letter, one lower letter, and one number",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyles.bodySmallGray700.copyWith(
                        height: 1.20,
                      ),
                    ),
                  ),
                  SizedBox(height: 54.v),
                  CustomElevatedButton(
                    height: 54.v,
                    text: "Change Password",
                    buttonStyle: CustomButtonStyles.fillSecondaryContainerTL12,
                  ),
                  SizedBox(height: 5.v)
                ],
              ),
            ),
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
          top: 15.v,
          bottom: 19.v,
        ),
        onTap: () {
          onTapArrowleftone(context);
        },
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "Change Password",
      ),
    );
  }

  /// Navigates back to the previous screen.
  onTapArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }
}
