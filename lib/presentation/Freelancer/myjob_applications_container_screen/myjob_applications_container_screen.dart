import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../widgets/custom_bottom_bar.dart';
import '../myjob_applications_page/myjob_applications_page.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class MyjobApplicationsContainerScreen extends StatelessWidget {
  MyjobApplicationsContainerScreen({Key? key})
      : super(
          key: key,
        );

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Navigator(
          key: navigatorKey,
          initialRoute: AppRoutes.myjobApplicationsPage,
          onGenerateRoute: (routeSetting) => PageRouteBuilder(
            pageBuilder: (ctx, ani, ani1) => getCurrentPage(routeSetting.name!),
            transitionDuration: Duration(seconds: 0),
          ),
        ),
        bottomNavigationBar: _buildBottomBar(context),
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
        return AppRoutes.homeContainerScreen;
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
      case AppRoutes.myjobApplicationsPage:
        return MyjobApplicationsPage();
      default:
        return DefaultWidget();
    }
  }
}
