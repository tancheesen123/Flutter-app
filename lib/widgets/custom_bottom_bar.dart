import 'package:flutter/material.dart';
import '../core/app_export.dart';

enum BottomBarEnum { Settings }
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class CustomBottomBar extends StatefulWidget {
  CustomBottomBar({this.onChanged});

  Function(BottomBarEnum)? onChanged;

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 0;

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.imgHome,
      activeIcon: ImageConstant.imgHome,
      title: "Settings",
      type: BottomBarEnum.Settings,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgUserOnprimarycontainer,
      activeIcon: ImageConstant.imgUserOnprimarycontainer,
      title: "Settings",
      type: BottomBarEnum.Settings,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgPhBagFillOnprimarycontainer,
      activeIcon: ImageConstant.imgPhBagFillOnprimarycontainer,
      title: "Settings",
      type: BottomBarEnum.Settings,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgHomeOnprimarycontainer,
      activeIcon: ImageConstant.imgHomeOnprimarycontainer,
      title: "Settings",
      type: BottomBarEnum.Settings,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgNavSettings,
      activeIcon: ImageConstant.imgNavSettings,
      title: "Settings",
      type: BottomBarEnum.Settings,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.v,
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0,
        elevation: 0,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: List.generate(bottomMenuList.length, (index) {
          return BottomNavigationBarItem(
            icon: CustomImageView(
              imagePath: bottomMenuList[index].icon,
              height: 18.v,
              width: 17.h,
              color: theme.colorScheme.primary,
            ),
            activeIcon: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: bottomMenuList[index].activeIcon,
                  height: 18.v,
                  width: 17.h,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 2.v),
                  child: Text(
                    bottomMenuList[index].title ?? "",
                    style:
                        CustomTextStyles.bodySmallOnPrimaryContainer.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                )
              ],
            ),
            label: '',
          );
        }),
        onTap: (index) {
          selectedIndex = index;
          widget.onChanged?.call(bottomMenuList[index].type);
          setState(() {});
        },
      ),
    );
  }
}
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class BottomMenuModel {
  BottomMenuModel(
      {required this.icon,
      required this.activeIcon,
      this.title,
      required this.type});

  String icon;

  String activeIcon;

  String? title;

  BottomBarEnum type;
}

class DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffffffff),
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
