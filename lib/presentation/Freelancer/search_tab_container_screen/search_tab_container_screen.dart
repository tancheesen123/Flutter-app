import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../widgets/app_bar/appbar_leading_image.dart';
import '../../../widgets/app_bar/appbar_title.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../widgets/custom_icon_button.dart';
import '../../../widgets/custom_search_view.dart';
import '../search_page/search_page.dart';

class SearchTabContainerScreen extends StatefulWidget {
  const SearchTabContainerScreen({Key? key})
      : super(
          key: key,
        );

  @override
  SearchTabContainerScreenState createState() =>
      SearchTabContainerScreenState();
}
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class SearchTabContainerScreenState extends State<SearchTabContainerScreen>
    with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();

  late TabController tabviewController;

  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 11.v),
              _buildSearchBox(context),
              SizedBox(height: 19.v),
              Padding(
                padding: EdgeInsets.only(left: 20.h),
                child: Text(
                  "35 Job Opportunity",
                  style: CustomTextStyles.bodyLargePrimaryContainer,
                ),
              ),
              SizedBox(height: 12.v),
              Container(
                height: 50.v,
                width: 295.h,
                margin: EdgeInsets.only(left: 20.h),
                child: TabBar(
                  controller: tabviewController,
                  labelPadding: EdgeInsets.zero,
                  labelColor: appTheme.gray700,
                  labelStyle: TextStyle(
                    fontSize: 14.fSize,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                  unselectedLabelColor: appTheme.whiteA700,
                  unselectedLabelStyle: TextStyle(
                    fontSize: 14.fSize,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    color: appTheme.gray5002,
                    borderRadius: BorderRadius.circular(
                      12.h,
                    ),
                  ),
                  tabs: [
                    Tab(
                      child: Text(
                        "Most Relevent",
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Most Recent",
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 557.v,
                child: TabBarView(
                  controller: tabviewController,
                  children: [SearchPage(), SearchPage()],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 30.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(
          left: 20.h,
          top: 18.v,
          bottom: 16.v,
        ),
        onTap: () {
          onTapArrowleftone(context);
        },
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "Search",
      ),
    );
  }

  /// Section Widget
  Widget _buildSearchBox(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: CustomSearchView(
                controller: searchController,
                hintText: "Warehouse Crew",
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.h),
              child: CustomIconButton(
                height: 54.adaptSize,
                width: 54.adaptSize,
                padding: EdgeInsets.all(17.h),
                decoration: IconButtonStyleHelper.fillPrimary,
                child: CustomImageView(
                  imagePath: ImageConstant.imgUser,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Navigates back to the previous screen.
  onTapArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }
}
