import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workwise/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import '../../../core/app_export.dart';
import '../../../theme/custom_button_style.dart';
import '../../../widgets/app_bar/appbar_leading_image.dart';
import '../../../widgets/app_bar/appbar_title.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_text_form_field.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class ChangePasswordScreen extends StatefulWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();
  TextEditingController oldpasswordController = TextEditingController();
  TextEditingController newpasswordController = TextEditingController();
  TextEditingController newpassword1Controller = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isOldPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmNewPasswordVisible = false;


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
                    controller: oldpasswordController,
                    hintText: "Old Password",
                    textInputType: TextInputType.visiblePassword,
                    obscureText: !_isOldPasswordVisible,
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
                    suffix: IconButton(
                        icon: Icon(
                          _isOldPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors
                              .grey, // Explicitly use the default icon color
                        ),
                        onPressed: () {
                          setState(() {
                            _isOldPasswordVisible = !_isOldPasswordVisible;
                          });
                        },
                      ),
                    suffixConstraints: BoxConstraints(
                      maxHeight: 54.v,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 15.v),
                    borderDecoration:
                        TextFormFieldStyleHelper.fillOnErrorContainerTL12,
                    textStyle: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 44.v),
                  CustomTextFormField(
                    controller: newpasswordController,
                    hintText: "New Password",
                    textInputType: TextInputType.visiblePassword,
                    obscureText: !_isNewPasswordVisible,
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
                    suffix: IconButton(
                        icon: Icon(
                          _isNewPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors
                              .grey, // Explicitly use the default icon color
                        ),
                        onPressed: () {
                          setState(() {
                            _isNewPasswordVisible = !_isNewPasswordVisible;
                          });
                        },
                      ),
                    suffixConstraints: BoxConstraints(
                      maxHeight: 54.v,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 15.v),
                    borderDecoration:
                        TextFormFieldStyleHelper.fillOnErrorContainerTL12,
                    textStyle: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 46.v),
                  CustomTextFormField(
                    controller: newpassword1Controller,
                    hintText: "Confirm New Password",
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.visiblePassword,
                    obscureText: !_isConfirmNewPasswordVisible,
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
                    suffix: IconButton(
                        icon: Icon(
                          _isConfirmNewPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors
                              .grey, // Explicitly use the default icon color
                        ),
                        onPressed: () {
                          setState(() {
                            _isConfirmNewPasswordVisible = !_isConfirmNewPasswordVisible;
                          });
                        },
                      ),
                    suffixConstraints: BoxConstraints(
                      maxHeight: 54.v,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 15.v),
                    borderDecoration:
                        TextFormFieldStyleHelper.fillOnErrorContainerTL12,
                    textStyle: TextStyle(color: Colors.black),
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
                    onPressed: () {
                      ChangePassword();
                    },
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

  void ChangePassword() async {
    String oldPassword = oldpasswordController.text;
    String newPassword = newpasswordController.text;
    String confirmNewPassword = newpassword1Controller.text;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userEmail = prefs.getString('userEmail');

    print("Old Password: ${oldPassword}");
    print("New Password: ${newPassword}");
    print("Confirm New Password: ${confirmNewPassword}");
    print("User Email: ${userEmail}");

    if (userEmail != null && oldPassword != null) {
      _firebaseAuthService
          .signInWithEmailAndPassword(userEmail!, oldPassword)
          .then((user) async {
        if (user != null && (newPassword == confirmNewPassword)) {
          print("account exist");
          print("New password same with confirm new password");
          await user.updatePassword(newPassword);
          print('Password changed successfully');
        } else {
          print("account does not exist");
        }
      }).catchError((error) {
        print("Error: ${error}");
      });
    }
    ;
  }
}
