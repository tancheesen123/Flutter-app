import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Controller/SearchPageController.dart';
import '../../../core/app_export.dart';
import '../../../widgets/app_bar/appbar_leading_image.dart';
import '../../../widgets/app_bar/appbar_title.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../widgets/custom_icon_button.dart';
import '../../../widgets/custom_search_view.dart';
import '../applyjob/apply_job_page.dart';

class SearchTabContainerScreen extends StatefulWidget {
  const SearchTabContainerScreen({Key? key}) : super(key: key);

  @override
  SearchTabContainerScreenState createState() =>
      SearchTabContainerScreenState();
}

class SearchTabContainerScreenState extends State<SearchTabContainerScreen>
    with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  final SearchPageController searchPageController =
      Get.put(SearchPageController());

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
        resizeToAvoidBottomInset: true,
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 11.v),
                _buildSearchBox(context),
                SizedBox(height: 19.v),
                Padding(
                  padding: EdgeInsets.only(left: 20.h),
                  child: Obx(() {
                    int jobCount = searchPageController.searchResults.length;
                    return Text(
                      "$jobCount Job Opportunit${jobCount == 1 || jobCount == 0 ? 'y' : 'ies'}",
                      style: CustomTextStyles.bodyLargePrimaryContainer,
                    );
                  }),
                ),
                SizedBox(height: 12.v),
                buildSearchedJobs(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 30.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(left: 20.h, top: 18.v, bottom: 16.v),
        onTap: () {
          onTapArrowleftone(context);
        },
      ),
      centerTitle: true,
      title: AppbarTitle(text: "Search"),
    );
  }

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
                hintText: "Search Here...",
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    searchPageController.searchJobPosts(value);
                  } else {
                    // Clear search results when search text is empty
                    searchPageController.searchResults.clear();
                  }
                },
                textStyle: TextStyle(color: Colors.black),
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
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSearchedJobs(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: Obx(() {
        if (searchPageController.searchResults.isEmpty) {
          return Center(child: Text('No results found'));
        } else {
          return ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: searchPageController.searchResults.length,
            itemBuilder: (context, index) {
              final data = searchPageController.searchResults[index].data()
                  as Map<String, dynamic>;
              return GestureDetector(
                onTap: () {
                  String postId = data['postId'];
                  Navigator.of(context, rootNavigator: true).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return ApplyJobScreen(
                          postId: postId,
                        );
                      },
                    ),
                  );
                },
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 12.v),
                      decoration: AppDecoration.outlineGray.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgRectangle516,
                            height: 50.adaptSize,
                            width: 50.adaptSize,
                            radius: BorderRadius.circular(15.h),
                            margin: EdgeInsets.symmetric(vertical: 13.v),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 5.v),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 233.h,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 6.v, bottom: 4.v),
                                        child: Text(
                                          data['title'] ?? '',
                                          style: theme.textTheme.bodySmall,
                                        ),
                                      ),
                                      CustomIconButton(
                                        height: 28.adaptSize,
                                        width: 28.adaptSize,
                                        padding: EdgeInsets.all(6.h),
                                        child: CustomImageView(
                                          imagePath: ImageConstant.imgFavorite,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  data['title'] ?? 'Warehouse Crew',
                                  style: theme.textTheme.titleMedium,
                                ),
                                SizedBox(height: 4.v),
                                SizedBox(
                                  width: 231.h,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        data['budget'] != null
                                            ? 'RM${data['budget']}/12h'
                                            : '',
                                        style: theme.textTheme.bodySmall,
                                      ),
                                      Text(
                                        data['location'] ?? '',
                                        style: theme.textTheme.bodySmall,
                                      ),
                                      Text(
                                        data['workingHours'] != null
                                            ? '${data['workingHours']}h'
                                            : '',
                                        style: theme.textTheme.labelLarge,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.v), // Add spacing between items
                  ],
                ),
              );
            },
          );
        }
      }),
    );
  }

  void onTapArrowleftone(BuildContext context) {
    searchPageController.searchResults.clear();
    Navigator.pop(context);
  }
}
