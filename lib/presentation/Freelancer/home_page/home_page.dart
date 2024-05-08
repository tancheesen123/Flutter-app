import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_button.dart';
import '../../../widgets/custom_search_view.dart';
import 'widgets/userprofile1_item_widget.dart';
import 'widgets/userprofile_item_widget.dart';
import '../profile_screen/profile_screen.dart';
// ignore_for_file: must_be_immutable
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class HomePage extends StatefulWidget {
  HomePage({Key? key})
      : super(
          key: key,
        );

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 13.v),
          decoration: AppDecoration.fillGray,
          child: Column(
            children: [
              SizedBox(height: 19.v),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildWelcomeBackSection(context),
                      SizedBox(height: 3.v),
                      _buildSearchBoxSection(context),
                      SizedBox(height: 24.v),
                      _buildFeaturedJobSection(context),
                      SizedBox(height: 20.v),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.h),
                        child: _buildRecentPostSection(
                          context,
                          recentPostText: "Recent Post",
                          showAllText: "Show All",
                        ),
                      ),
                      SizedBox(
                        height: 380.v,
                        width: double.maxFinite,
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            // _buildSlack(context),
                            _buildUserProfile(context)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          //button
        ),
        floatingActionButton: ElevatedButton(
          onPressed: () async {
            String userEmail = await getUserEmail();
            // Now you can use the userEmail variable here
            print('User email: $userEmail');
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildWelcomeBackSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 32.h,
        right: 20.h,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context, rootNavigator: true)
              .pushNamed(AppRoutes.profileScreen);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome Back!",
                  style: CustomTextStyles.titleSmallGray50001,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "  ",
                      ),
                      TextSpan(
                        text: "Adam Shafi 👋",
                        style: CustomTextStyles.titleLargeOnPrimary,
                      )
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 1.v),
                Text(
                  "Total Earning: RM2,590.00",
                  style: CustomTextStyles.titleSmallBluegray900,
                )
              ],
            ),
            Container(
              height: 44.adaptSize,
              width: 44.adaptSize,
              margin: EdgeInsets.only(
                top: 7.v,
                bottom: 26.v,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  22.h,
                ),
                image: DecorationImage(
                  image: AssetImage(
                    ImageConstant.imgRectangle382,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildSearchBoxSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: CustomSearchView(
              controller: searchController,
              hintText: "Search here...",
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
    );
  }

  /// Section Widget
  Widget _buildFeaturedJobSection(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: _buildRecentPostSection(
            context,
            recentPostText: "Featured Job",
            showAllText: "Show All",
          ),
        ),
        SizedBox(height: 20.v),
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            height: 185.v,
            child: UserprofileItemWidget(), // Remove 'return' keyword here
          ),
        )
      ],
    );
  }

  /// Section Widget
  Widget _buildSlack(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 80.v,
        width: 339.h,
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.only(left: 4.h),
                padding: EdgeInsets.all(15.h),
                decoration: AppDecoration.outlineErrorContainer.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomIconButton(
                      height: 50.adaptSize,
                      width: 50.adaptSize,
                      padding: EdgeInsets.all(14.h),
                      decoration: IconButtonStyleHelper.fillGray,
                      child: CustomImageView(
                        imagePath: ImageConstant.imgTelevision,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 20.h,
                        top: 4.v,
                        bottom: 7.v,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Visual Designer",
                            style: CustomTextStyles
                                .titleMediumSofiaProPrimaryContainer,
                          ),
                          SizedBox(height: 3.v),
                          Text(
                            "Full Time",
                            style: CustomTextStyles.bodySmallSofiaProGray500,
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 15.v,
                        right: 3.h,
                        bottom: 17.v,
                      ),
                      child: Text(
                        "4500/m",
                        style: CustomTextStyles.labelLargeSofiaProGray500,
                      ),
                    )
                  ],
                ),
              ),
            ),
            // Align(
            //   alignment: Alignment.topLeft,
            //   child: Padding(
            //     padding: EdgeInsets.only(top: 11.v),
            //     child: Row(
            //       children: [
            //         Padding(
            //           padding: EdgeInsets.only(bottom: 2.v),
            //           child: Text(
            //             "Home",
            //             style: CustomTextStyles.bodySmallPrimary,
            //           ),
            //         ),
            //         Padding(
            //           padding: EdgeInsets.only(
            //             left: 25.h,
            //             top: 2.v,
            //           ),
            //           child: Text(
            //             "Messages",
            //             style: CustomTextStyles.bodySmallOnPrimaryContainer,
            //           ),
            //         ),
            //         Padding(
            //           padding: EdgeInsets.only(
            //             left: 24.h,
            //             top: 2.v,
            //           ),
            //           child: Text(
            //             "My Jobs",
            //             style: CustomTextStyles.bodySmallOnPrimaryContainer,
            //           ),
            //         ),
            //         Padding(
            //           padding: EdgeInsets.only(left: 25.h),
            //           child: Text(
            //             "Notifications",
            //             style: CustomTextStyles.bodySmallOnPrimaryContainer,
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildUserProfile(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(bottom: 1.0),
        child: ListView.separated(
          // Remove physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 10,
            );
          },
          itemCount: 8,
          itemBuilder: (context, index) {
            return Userprofile1ItemWidget();
          },
        ),
      ),
    );
  }

  /// Common widget
  Widget _buildRecentPostSection(
    BuildContext context, {
    required String recentPostText,
    required String showAllText,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          recentPostText,
          style: theme.textTheme.titleLarge!.copyWith(
            color: theme.colorScheme.primaryContainer,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 9.v,
            bottom: 2.v,
          ),
          child: Text(
            showAllText,
            style: theme.textTheme.bodySmall!.copyWith(
              color: appTheme.gray700,
            ),
          ),
        )
      ],
    );
  }

  Future<List<Map<String, dynamic>>> fetchData() async {
    List<Map<String, dynamic>> dataList = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('ClientJobList').get();

    querySnapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      dataList.add(data);
    });

    return dataList;
  }

  Future<String> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userEmail') ?? '';
  }
}
