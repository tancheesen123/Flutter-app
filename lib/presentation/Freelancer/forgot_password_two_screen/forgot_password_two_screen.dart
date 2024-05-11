import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import 'package:get/get.dart';
import 'package:workwise/Controller/ForgotPasswordController.dart';
import 'package:workwise/presentation/log_in_screen/log_in_screen.dart';
import '../../../core/app_export.dart';
import '../../../theme/custom_button_style.dart';
import '../../../widgets/app_bar/appbar_leading_image.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_outlined_button.dart';

class ForgotPasswordTwoScreen extends StatelessWidget {
  final String email;
  const ForgotPasswordTwoScreen({Key? key, required this.email})
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
            horizontal: 17.h,
            vertical: 9.v,
          ),
          child: Column(
            children: [
              Text(
                "Check your email",
                style: theme.textTheme.headlineLarge,
              ),
              SizedBox(height: 28.v),
              Container(
                width: 302.h,
                margin: EdgeInsets.symmetric(horizontal: 19.h),
                child: Text(
                  "We have sent a reset password link to your email address. Kindly follow the instructions to reset your password. ",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: CustomTextStyles.bodyLargeGray700.copyWith(
                    height: 1.50,
                  ),
                ),
              ),
              SizedBox(height: 39.v),
              SizedBox(
                height: 212.v,
                width: 278.h,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 90.h,
                          vertical: 46.v,
                        ),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: fs.Svg(
                              ImageConstant.imgGroup46,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(height: 43.v),
                            Container(
                              height: 56.v,
                              width: 59.h,
                              padding: EdgeInsets.symmetric(
                                horizontal: 5.h,
                                vertical: 8.v,
                              ),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: fs.Svg(
                                    ImageConstant.imgGroup47,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: CustomImageView(
                                imagePath: ImageConstant.imgTelevision,
                                height: 9.v,
                                width: 17.h,
                                alignment: Alignment.topRight,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        height: 116.v,
                        width: 215.h,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgPath,
                              height: 12.v,
                              width: 215.h,
                              alignment: Alignment.bottomCenter,
                              margin: EdgeInsets.only(bottom: 5.v),
                            ),
                            CustomImageView(
                              imagePath: ImageConstant.imgEnvelopes2,
                              height: 64.v,
                              width: 208.h,
                              alignment: Alignment.bottomCenter,
                              margin: EdgeInsets.only(bottom: 13.v),
                            ),
                            CustomImageView(
                              imagePath: ImageConstant.imgEnvelopes1,
                              height: 10.v,
                              width: 160.h,
                              alignment: Alignment.bottomRight,
                              margin: EdgeInsets.only(right: 18.h),
                            ),
                            CustomImageView(
                              imagePath: ImageConstant.imgThumbsUp,
                              height: 65.v,
                              width: 38.h,
                              alignment: Alignment.bottomRight,
                              margin: EdgeInsets.only(
                                right: 1.h,
                                bottom: 12.v,
                              ),
                            ),
                            CustomImageView(
                              imagePath: ImageConstant.imgMailBox,
                              height: 104.v,
                              width: 40.h,
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(left: 11.h),
                            ),
                            CustomImageView(
                              imagePath: ImageConstant.imgGroup,
                              height: 113.v,
                              width: 91.h,
                              alignment: Alignment.center,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 63.v),
              CustomElevatedButton(
                height: 54.v,
                text: "DONE",
                margin: EdgeInsets.only(
                  left: 1.h,
                  right: 5.h,
                ),
                buttonStyle: CustomButtonStyles.fillPrimaryTL12,
                buttonTextStyle: CustomTextStyles.titleMediumWhiteA700,
                onPressed: ()=> Navigator.pushNamed(context, AppRoutes.logInScreen)
              ),
              SizedBox(height: 20.v),
              CustomOutlinedButton(
                text: "RESEND EMAIL",
                margin: EdgeInsets.only(right: 5.h),
                onPressed: () => ForgotPasswordController.instance.resendPasswordResetEmail(email),
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
