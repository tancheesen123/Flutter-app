import 'package:flutter/material.dart';
import '../../../../core/app_export.dart';
import '../../../../widgets/custom_bottom_bar.dart';
import '../settings_page/settings_page.dart';
import '../../profile_screen/profile_screen.dart';
import '../../home_page/home_page.dart'; // ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class SettingsContainerScreen extends StatelessWidget {
  SettingsContainerScreen({Key? key})
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
          initialRoute: AppRoutes.settingsScreen,
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
      case BottomBarEnum.Jobs:
        return "/";
      case BottomBarEnum.Notifications:
        return "/";
      case BottomBarEnum.Settings:
        return AppRoutes.settingsContainerScreen;
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.homePage:
        return HomePage();
      case AppRoutes.profileScreen:
        return ProfileScreen();
      case AppRoutes.settingsContainerScreen:
        return SettingsContainerScreen();
      default:
        return DefaultWidget();
    }
  }
}
