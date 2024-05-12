import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
                  Padding(
                    padding: EdgeInsets.only(left: 6.h),
                    child: FutureBuilder<String?>(
                      future: _validateOldPassword(), // Perform asynchronous validation
                      builder: (context, snapshot) {
                        return CustomTextFormField(
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
                              color: Colors.grey,
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
                          // Validator retrieves error message from snapshot
                          validator: (value) {
                            return snapshot.data;
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 44.v),
                  Padding(
                    padding: EdgeInsets.only(left: 6.h),
                    child: FutureBuilder<String?>(
                      future:
                          _validateNewPassword(), // Perform asynchronous validation
                      builder: (context, snapshot) {
                        return CustomTextFormField(
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
                          // Validator retrieves error message from snapshot
                          validator: (value) {
                            return snapshot.data;
                          },
                        );
                      },
                    ),
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
                    borderDecoration: TextFormFieldStyleHelper.fillOnErrorContainerTL12,
                    textStyle: TextStyle(color: Colors.black),
                    //Check new password match with confirm new password
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Confirm new password cannot be empty';
                      }else if (value != newpasswordController.text) {
                        return 'New password and confirm new password does not\nmatch';
                      }
                      return null;
                    },
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
                      if (_formKey.currentState!.validate()) {
                        ChangePassword();
                      }
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
        if (user != null &&
            (newPassword == confirmNewPassword) &&
            (newPassword != oldPassword) &&
            (newPassword.length >= 8 &&
                newPassword.contains(RegExp(r'[A-Z]')) &&
                newPassword.contains(RegExp(r'[a-z]')) &&
                newPassword.contains(RegExp(r'[0-9]')))) {
          print("account exist");
          print("New password same with confirm new password");
          await user.updatePassword(newPassword);
          print('Password changed successfully');
          //Pop up message
          Fluttertoast.showToast(
            msg: "Your password is updated successfully",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          // Clear text fields
        oldpasswordController.clear();
        newpasswordController.clear();
        newpassword1Controller.clear();
        } else {
          print("account does not exist");
        }
        
      }).catchError((error) {
        print("Error: ${error}");
      });
    };
  }

  Future<String?> _validateOldPassword() async {
  String? value = oldpasswordController.text;
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? userEmail = prefs.getString('userEmail');
  if (value == null || value.isEmpty) {
    return 'Old password cannot be empty';
  } else {
    try {
      // Attempt to sign in with the current user's email and the entered old password
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userEmail!,
        password: value,
      );
      // If sign-in is successful, return null to indicate no error
      return null;
    } catch (error) {
      // If sign-in fails, return an error message indicating the old password is incorrect
      return 'Incorrect old password';
    }
  }

}

Future<String?> _validateNewPassword() async {
    String? value = newpasswordController.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userEmail = prefs.getString('userEmail');
    if (value == null || value.isEmpty) {
      return 'New password cannot be empty';
    } else if (value != newpasswordController.text) {
      return 'New password and confirm new password does not\nmatch';
    } else {
      try {
        // Attempt to sign in with the current user's email and the entered old password
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: userEmail!,
          password: value,
        );
        return 'New Password cannot be same as current password';
      } catch (error) {
        return null;
      }
    }
  
  }
}
