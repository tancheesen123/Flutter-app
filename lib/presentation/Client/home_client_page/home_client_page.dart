import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import 'widgets/viewhierarchy_item_widget.dart'; // ignore_for_file: must_be_immutable

class HomeClientPage extends StatelessWidget {
  const HomeClientPage({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillGray,
          child: Column(
            children: [
              SizedBox(height: 32.v),
              _buildWelcomeBack(context),
              SizedBox(height: 33.v),
              _buildYourJobPost(context),
              SizedBox(height: 17.v),
              _buildViewHierarchy(context),
              Spacer(),
              Container(
                height: 48.v,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0, 0),
                    end: Alignment(0, 1),
                    colors: [appTheme.gray90011, appTheme.gray40011],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildWelcomeBack(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 33.h,
        right: 26.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 1.h),
                child: Text(
                  "Welcome Back!",
                  style: theme.textTheme.titleSmall,
                ),
              ),
              SizedBox(height: 2.v),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "  ",
                    ),
                    TextSpan(
                      text: "Chagee MY",
                      style: CustomTextStyles.titleLargeOnPrimary,
                    ),
                    TextSpan(
                      text: " 👋",
                      style: CustomTextStyles.titleLargeOnPrimaryBold,
                    )
                  ],
                ),
                textAlign: TextAlign.left,
              )
            ],
          ),
          CustomImageView(
            imagePath: ImageConstant.imgRectangle517,
            height: 48.v,
            width: 42.h,
            radius: BorderRadius.circular(
              20.h,
            ),
            margin: EdgeInsets.only(top: 7.v),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildYourJobPost(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 33.h,
        right: 20.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Your Job Post",
            style: CustomTextStyles.titleLargeSemiBold,
          ),
          GestureDetector(
            onTap: () {
              onTapTxtShowall(context);
            },
            child: Padding(
              padding: EdgeInsets.only(top: 11.v),
              child: Text(
                "Show All",
                style: theme.textTheme.bodySmall,
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildViewHierarchy(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 20.v,
          );
        },
        itemCount: 3,
        itemBuilder: (context, index) {
          return ViewhierarchyItemWidget();
        },
      ),
    );
  }

  /// Navigates to the postClientScreen when the action is triggered.
  onTapTxtShowall(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.postClientScreen);
  }
}
