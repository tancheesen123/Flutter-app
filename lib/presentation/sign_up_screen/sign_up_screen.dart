import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
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
                padding: EdgeInsets.symmetric(
                  horizontal: 20.h,
                  vertical: 17.v,
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.h),
                        child: Text(
                          "Register Account",
                          style: CustomTextStyles.headlineLargeSemiBold,
                        ),
                      ),
                    ),
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
                    _buildUserName(context),
                    SizedBox(height: 24.v),
                    _buildEmail(context),
                    SizedBox(height: 24.v),
                    _buildPassword(context),
                    SizedBox(height: 40.v),
                    _buildSignUp(context),
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
                    SizedBox(height: 45.v),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Already Have Account? ",
                            style: theme.textTheme.bodyLarge,
                          ),
                          TextSpan(
                            text: "Log In",
                            style:
                                CustomTextStyles.titleMediumPrimaryContainer_1,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                navigateToLogin(context);
                              },
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

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: double.maxFinite,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.fromLTRB(30.h, 17.v, 335.h, 17.v),
        onTap: () {
          onTapArrowleftone(context);
        },
      ),
    );
  }

  Widget _buildUserName(BuildContext context) {
    return CustomTextFormField(
      controller: userNameController,
      hintText: "User Name",
      prefix: Container(
        margin: EdgeInsets.fromLTRB(20.h, 13.v, 15.h, 13.v),
        child: CustomImageView(
          imagePath: ImageConstant.imgLock,
          height: 22.v,
          width: 20.h,
        ),
      ),
      prefixConstraints: BoxConstraints(
        maxHeight: 54.v,
      ),
    );
  }

  Widget _buildEmail(BuildContext context) {
    return CustomTextFormField(
      controller: emailController,
      hintText: "Email Address",
      textInputType: TextInputType.emailAddress,
      prefix: Container(
        margin: EdgeInsets.fromLTRB(20.h, 17.v, 15.h, 17.v),
        child: CustomImageView(
          imagePath: ImageConstant.imgMessage,
          height: 20.adaptSize,
          width: 20.adaptSize,
        ),
      ),
      prefixConstraints: BoxConstraints(
        maxHeight: 54.v,
      ),
    );
  }

  Widget _buildPassword(BuildContext context) {
    return CustomTextFormField(
      controller: passwordController,
      hintText: "Password",
      textInputAction: TextInputAction.done,
      textInputType: TextInputType.visiblePassword,
      prefix: Container(
        margin: EdgeInsets.fromLTRB(20.h, 12.v, 15.h, 16.v),
        child: CustomImageView(
          imagePath: ImageConstant.imgLocationGray700,
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
    );
  }

  Widget _buildSignUp(BuildContext context) {
    return CustomElevatedButton(
      text: "SIGN UP",
      buttonTextStyle: CustomTextStyles.titleMediumOnErrorContainer,
      onPressed: () {
        _signUp(context);
      },
    );
  }

  navigateToLogin(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.logInScreen);
  }

  onTapArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }

  onTapTxtAlreadyhaveaccount(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.logInScreen);
  }

  void _signUp(BuildContext context) async {
    String username = userNameController.text;
    String email = emailController.text;
    String password = passwordController.text;

    User? user = await _firebaseAuthService.signUpWithEmailAndPassword(
        email, password);

    if (user != null) {
      print("User created successfully");
      Navigator.pushNamed(context, AppRoutes.homeContainerScreen);
    } else {
      print("User creation failed");
    }
  }
}
