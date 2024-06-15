import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../../Controller/SearchPageController.dart';
import '../../../core/app_export.dart';
import '../../../widgets/app_bar/appbar_leading_image.dart';
import '../../../widgets/app_bar/appbar_title.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../widgets/custom_icon_button.dart';
import '../../../widgets/custom_search_view.dart';
import '../applyjob/apply_job_page.dart';
import 'package:workwise/Controller/ApplyJobController.dart';

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
              final DocumentSnapshot snapshot = searchPageController.searchResults[index];
            final data = snapshot.data() as Map<String, dynamic>;
              DocumentReference userRef = data['user'] as DocumentReference;
              return FutureBuilder<DocumentSnapshot>(
                future: userRef.get(),
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return _buildShimmerJobCard(context);
                  } else if (userSnapshot.hasError) {
                    return Text('Error: ${userSnapshot.error}');
                  } else if (!userSnapshot.hasData ||
                      !userSnapshot.data!.exists) {
                    return Text('No user data found');
                  } else {
                    final userData = userSnapshot.data!.data() as Map<String, dynamic>;
                  String profileImageUrl = userData['profileImageUrl'] ?? '';
                  return _buildJobCard(snapshot, data, profileImageUrl, context);
                  }
                },
              );
            },
          );
        }
      }),
    );
  }

  Widget _buildJobCard(DocumentSnapshot snapshot,
      Map<String, dynamic> data, String profileImageUrl, BuildContext context) {
    return GestureDetector(
      onTap: () {
        String? postId = snapshot.id;
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
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Center items vertically
              children: [
                CircleAvatar(
                  radius: 30.h,
                  backgroundImage: profileImageUrl != null
                      ? CachedNetworkImageProvider(profileImageUrl)
                      : AssetImage(ImageConstant.imgRectangle382)
                          as ImageProvider<Object>,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 5.v),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 233.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 6.v, bottom: 4.v),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
  }

  void onTapArrowleftone(BuildContext context) {
    searchPageController.searchResults.clear();
    Navigator.pop(context);
  }

  Widget _buildShimmerJobCard(BuildContext context) {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 12.v),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadiusStyle.roundedBorder20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 60.h,
                height: 60.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.circle,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5.v),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 233.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 150.h,
                            height: 10.v,
                            color: Colors.grey[300],
                          ),
                          Container(
                            width: 28.adaptSize,
                            height: 28.adaptSize,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(14.h),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 233.h,
                      height: 20.v,
                      color: Colors.grey[300],
                      margin: EdgeInsets.symmetric(vertical: 4.v),
                    ),
                    SizedBox(
                      width: 231.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 70.h,
                            height: 14.v,
                            color: Colors.grey[300],
                          ),
                          Container(
                            width: 80.h,
                            height: 14.v,
                            color: Colors.grey[300],
                          ),
                          Container(
                            width: 30.h,
                            height: 14.v,
                            color: Colors.grey[300],
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
        SizedBox(height: 15.v),
      ],
    ),
  );
}

}
