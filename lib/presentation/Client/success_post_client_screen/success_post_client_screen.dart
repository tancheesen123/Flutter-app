import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../widgets/custom_elevated_button.dart';

class SuccessPostClientScreen extends StatelessWidget {
  const SuccessPostClientScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 39.v),
          child: Column(
            children: [
              Text(
                "New Job Post",
                style: theme.textTheme.titleLarge,
              ),
              SizedBox(height: 98.v),
              CustomImageView(
                imagePath: ImageConstant.imgVector,
                height: 102.adaptSize,
                width: 102.adaptSize,
              ),
              SizedBox(height: 32.v),
              Text(
                "Successfully Posted",
                style: theme.textTheme.bodyLarge,
              ),
              SizedBox(height: 5.v)
            ],
          ),
        ),
        bottomNavigationBar: _buildBackToPost(context),
      ),
    );
  }

  /// Section Widget
  Widget _buildBackToPost(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 20.h,
        right: 20.h,
        bottom: 11.v,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            ImageConstant.imgGroup56,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: CustomElevatedButton(
        text: "Back to Post",
      ),
    );
  }
}
