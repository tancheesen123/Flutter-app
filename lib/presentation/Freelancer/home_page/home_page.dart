import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_button.dart';
import 'widgets/recentPost_item_widget.dart';
import 'widgets/featuredJob_item_widget.dart';
import 'package:workwise/Controller/ApplyJobController.dart';
import 'package:workwise/Controller/HomePageController.dart';

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
  final ApplyJobController _jobPostController = Get.put(ApplyJobController());
  final HomePageController _homePageController = Get.put(HomePageController(
    firestore: FirebaseFirestore.instance,
    firebaseAuth: FirebaseAuth.instance,
  ));

  late Future<String> _usernameFuture;
  String? _username;

  @override
  void initState() {
    super.initState();

    _getUsername();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Obx(() {
          return Container(
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
                        _buildRecentJobSection(context),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }),
        // floatingActionButton: ElevatedButton(
        //   onPressed: () async {
        //     await _jobPostController.getCandidates("a2");
        //     for (var candidate in _jobPostController.candidates) {
        //       print(
        //           'Candidate: ${candidate['name']}, Email: ${candidate['email']}, status: ${candidate['status']}');
        //     }
        //   },
        //   child: Text('Fetch Candidates'),
        // ),
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
                SizedBox(height: 10.v),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "  ",
                      ),
                      TextSpan(
                        text: "${_homePageController.username.value} 👋",
                        style: CustomTextStyles.titleLargeOnPrimary,
                      )
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            Container(
              height: 44.adaptSize,
              width: 44.adaptSize,
              margin: EdgeInsets.only(top: 7.v, bottom: 26.v),
              decoration: BoxDecoration(
                shape: BoxShape.circle, // Set shape to circle
              ),
              child: ClipOval(
                // Use ClipOval to clip the image into a circle
                child: _homePageController.profileImageUrl.value.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: _homePageController.profileImageUrl.value,
                        placeholder: (context, url) => Shimmer.fromColors(
                          child: Container(color: Colors.grey),
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        ImageConstant.imgRectangle382,
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
            child: SizedBox(
              height: 54.adaptSize, // Adjust the height as needed
              child: TextButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed(AppRoutes.searchTabContainerScreen);
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.white),
                  padding: WidgetStateProperty.all(
                    EdgeInsets.symmetric(vertical: 10.h),
                  ),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.h),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Icon(
                        Icons.search,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Search here...",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
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
        SizedBox(height: 1.v),
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            height: 185.v,
            child: FeaturedJobItemWidget(), // Remove 'return' keyword here
          ),
        )
      ],
    );
  }

  Widget _buildRecentJobSection(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: _buildRecentPostSection(
            context,
            recentPostText: "Recent Post",
            showAllText: "Show All",
          ),
        ),
        SizedBox(height: 20.v),
        // SizedBox(
        //   height: 380.v,
        //   width: double.maxFinite,
        //   child: Stack(
        //     alignment: Alignment.topCenter,
        //     children: [_buildUserProfile(context)],
        //   ),
        // )
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            height: 450.v,
            width: double.maxFinite,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                RecentPostItemWidget(),
              ],
            ),
          ),
        )
      ],
    );
  }

  // /// Section Widget
  // Widget _buildUserProfile(BuildContext context) {
  //   return Align(
  //     alignment: Alignment.topCenter,
  //     child: Padding(
  //       padding: EdgeInsets.only(bottom: 1.0),
  //       child: ListView.separated(
  //         // Remove physics: NeverScrollableScrollPhysics(),
  //         shrinkWrap: true,
  //         separatorBuilder: (context, index) {
  //           return SizedBox(
  //             height: 10,
  //           );
  //         },
  //         itemCount: 8,
  //         itemBuilder: (context, index) {
  //           return RecentPostItemWidget();
  //         },
  //       ),
  //     ),
  //   );
  // }

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
    return prefs.getString('username') ?? '';
  }

  Future<String> _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    _username = prefs.getString('username');
    return prefs.getString('username') ?? "";
  }

  Future<String> _getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool usernameRetrieved = prefs.getBool('usernameRetrieved') ?? false;

    if (!usernameRetrieved) {
      String? userEmail = prefs.getString('userEmail');

      if (userEmail != null) {
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('user')
            .where('email', isEqualTo: userEmail)
            .get();

        if (snapshot.docs.isNotEmpty) {
          String username = snapshot.docs.first.get('username');
          setState(() {
            _username = username;
          });
          prefs.setBool('usernameRetrieved', true);
          await prefs.setString('username', username);
          return username;
        }
      }
    }

    return '';
  }

  Future<List<DocumentSnapshot>> _getCandidates(String jobPostId) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('jobPost')
        .doc(jobPostId)
        .collection('candidate')
        .get();
    return snapshot.docs;
  }
}
