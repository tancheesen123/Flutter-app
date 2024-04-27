import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../theme/custom_button_style.dart';
import '../../../widgets/app_bar/appbar_leading_image.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../widgets/custom_elevated_button.dart';

class SignUpVerificationScreen extends StatelessWidget {
  const SignUpVerificationScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 19.h,
            vertical: 17.v,
          ),
          child: Column(
            children: [
              Text(
                "Verify Your Email",
                style: theme.textTheme.headlineLarge,
              ),
              SizedBox(height: 20.v),
              Container(
                width: 306.h,
                margin: EdgeInsets.symmetric(horizontal: 15.h),
                child: Text(
                  "An email has been send to your email for verification. Once verified, you’ ll be able to login.",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.bodyLargeGray700.copyWith(
                    height: 1.50,
                  ),
                ),
              ),
              SizedBox(height: 38.v),
              CustomImageView(
                imagePath: ImageConstant.imgEmail,
                height: 256.v,
                width: 278.h,
              ),
              SizedBox(height: 67.v),
              CustomElevatedButton(
                height: 54.v,
                text: "GO TO LOGIN",
                buttonStyle: CustomButtonStyles.fillSecondaryContainerTL12,
              ),
              SizedBox(height: 5.v)
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
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

  /// Navigates back to the previous screen.
  onTapArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }
}
