import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../widgets/custom_bottom_bar.dart';
import '../../../widgets/custom_icon_button.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../home_client_page/home_client_page.dart';
import 'widgets/listchageemy_item_widget.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class PostClientScreen extends StatelessWidget {
  PostClientScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController serachhereController = TextEditingController();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(height: 40.v),
              GestureDetector(
                onTap: () {
                  onTapTxtPost(context);
                },
                child: Text(
                  "Post",
                  style: theme.textTheme.titleLarge,
                ),
              ),
              SizedBox(height: 12.v),
              _buildSearchHere(context),
              SizedBox(height: 33.v),
              _buildListChageemy(context),
              SizedBox(height: 78.v),
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
        bottomNavigationBar: _buildBottomBar(context),
      ),
    );
  }

  /// Section Widget
  Widget _buildSerachhere(BuildContext context) {
    return CustomTextFormField(
      width: 192.h,
      controller: serachhereController,
      hintText: "Serach here...",
      textInputAction: TextInputAction.done,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 20.h,
        vertical: 15.v,
      ),
    );
  }

  /// Section Widget
  Widget _buildSearchHere(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 23.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSerachhere(context),
          Padding(
            padding: EdgeInsets.only(left: 10.h),
            child: CustomIconButton(
              height: 54.adaptSize,
              width: 54.adaptSize,
              padding: EdgeInsets.all(17.h),
              child: CustomImageView(
                imagePath: ImageConstant.imgGoBtn,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 19.h),
            child: CustomIconButton(
              height: 54.adaptSize,
              width: 54.adaptSize,
              padding: EdgeInsets.all(10.h),
              decoration: IconButtonStyleHelper.fillSecondaryContainer,
              onTap: () {
                onTapBtnUserone(context);
              },
              child: CustomImageView(
                imagePath: ImageConstant.imgUser,
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildListChageemy(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 26.v,
          );
        },
        itemCount: 3,
        itemBuilder: (context, index) {
          return ListchageemyItemWidget();
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(
      onChanged: (BottomBarEnum type) {
        Navigator.pushNamed(
            navigatorKey.currentContext!, getCurrentRoute(type));
      },
    );
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.homeClientPage;
      case BottomBarEnum.Messages:
        return "/";
      case BottomBarEnum.Jobs:
        return "/";
      case BottomBarEnum.Notifications:
        return "/";
      case BottomBarEnum.Settings:
        return "/";
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.homeClientPage:
        return HomeClientPage();
      default:
        return DefaultWidget();
    }
  }

  /// Navigates to the homeClientContainerScreen when the action is triggered.
  onTapTxtPost(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.homeClientContainerScreen);
  }

  /// Navigates to the postClientOneScreen when the action is triggered.
  onTapBtnUserone(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.postClientOneScreen);
  }
}
