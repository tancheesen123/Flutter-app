import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_text_form_field.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class LogInScreen extends StatelessWidget {
  LogInScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _formKey,
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(
                  left: 20.h,
                  top: 92.v,
                  right: 20.h,
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.h),
                        child: Text(
                          "Welcome Back!",
                          style: theme.textTheme.headlineLarge,
                        ),
                      ),
                    ),
                    SizedBox(height: 3.v),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 212.h,
                        margin: EdgeInsets.only(left: 10.h),
                        child: Text(
                          "Fill your details or continue with social media",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyLarge!.copyWith(
                            height: 1.50,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 28.v),
                    CustomTextFormField(
                      controller: emailController,
                      hintText: "Email Address",
                      textInputType: TextInputType.emailAddress,
                      prefix: Container(
                        margin: EdgeInsets.fromLTRB(20.h, 15.v, 10.h, 15.v),
                        child: CustomImageView(
                          imagePath: ImageConstant.imgMessage,
                          height: 24.adaptSize,
                          width: 24.adaptSize,
                        ),
                      ),
                      prefixConstraints: BoxConstraints(
                        maxHeight: 54.v,
                      ),
                    ),
                    SizedBox(height: 24.v),
                    CustomTextFormField(
                      controller: passwordController,
                      hintText: "Password",
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.visiblePassword,
                      prefix: Container(
                        margin: EdgeInsets.fromLTRB(20.h, 14.v, 14.h, 14.v),
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
                    ),
                    SizedBox(height: 8.v),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forget Password?",
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                    SizedBox(height: 35.v),
                    CustomElevatedButton(
                      text: "LOG IN",
                      buttonTextStyle:
                          CustomTextStyles.titleMediumOnErrorContainer,
                      onPressed: () {
                        navigateToSignUp(context);
                      },
                    ),
                    SizedBox(height: 35.v),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 12.v,
                            bottom: 9.v,
                          ),
                          child: SizedBox(
                            width: 20.h,
                            child: Divider(),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.h),
                          child: Text(
                            "Or Continue with",
                            style: theme.textTheme.bodyLarge,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 12.v,
                            bottom: 9.v,
                          ),
                          child: SizedBox(
                            width: 30.h,
                            child: Divider(
                              indent: 10.h,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 26.v),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomIconButton(
                          height: 60.adaptSize,
                          width: 60.adaptSize,
                          padding: EdgeInsets.all(13.h),
                          decoration: IconButtonStyleHelper.fillBlue,
                          child: CustomImageView(
                            imagePath: ImageConstant.img1421929991558096326,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.h),
                          child: CustomIconButton(
                            height: 60.adaptSize,
                            width: 60.adaptSize,
                            padding: EdgeInsets.all(14.h),
                            decoration: IconButtonStyleHelper.fillIndigo,
                            child: CustomImageView(
                              imagePath: ImageConstant.imgFacebook,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 43.v),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "New User? ",
                            style: CustomTextStyles.titleMediumGray700,
                          ),
                          TextSpan(
                            text: "Create Account",
                            style:
                                CustomTextStyles.titleMediumPrimaryContainer_1,
                          )
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 5.v)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Navigates to the signUpScreen when the action is triggered.
  navigateToSignUp(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.signUpScreen);
  }
}
