import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/app_export.dart';
import '../../../widgets/app_bar/appbar_leading_image.dart';
import '../../../widgets/app_bar/appbar_title.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../widgets/custom_elevated_button.dart';
import 'package:workwise/Controller/ApplyJobController.dart';
import 'package:workwise/Controller/UserController.dart'; // Import the JobPost model
import 'package:workwise/Controller/PostInsightController.dart';
import 'widgets/click_insight_item.dart';
import 'widgets/apply_insight_item.dart';

class PostInsightScreen extends StatefulWidget {
  final String? postId;

  PostInsightScreen({Key? key, this.postId}) : super(key: key);

  @override
  State<PostInsightScreen> createState() => _PostInsightScreenState();
}

class _PostInsightScreenState extends State<PostInsightScreen>
    with TickerProviderStateMixin {
  late TabController tabviewController;
  final ApplyJobController applyJobController = Get.put(ApplyJobController());
  final UserController userController = Get.put(UserController());
  final PostInsightController postInsightController =
      Get.put(PostInsightController());
  String? postId;
  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 2, vsync: this);
    postId = widget.postId;
  }

  @override
  void dispose() {
    tabviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: FutureBuilder(
          future: Future.wait([
            applyJobController.getJobPostData(widget.postId ?? ""),
            userController.getUserInformation(),
            postInsightController.fetchPostInsight(widget.postId ?? ""),
            postInsightController.getTotalValues(widget.postId ?? ""),

            // Add your second future here
            // FutureOperation2()
          ]),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error loading job details"));
            } else if (!snapshot.hasData || snapshot.data == null) {
              return Center(child: Text("Job post not found"));
            } else {
              final data = snapshot.data!;
              Map<String, dynamic> jobPostData = data[0];
              Map<String, dynamic> userData = data[1];
              Map<String, dynamic> postInsightData = data[2];
              Map<String, int> totalValues = data[3];

              // Add your logic to handle the data from the second future
              // var secondFutureData = data[1];
              return Stack(
                children: [
                  SingleChildScrollView(
                    padding: EdgeInsets.only(
                        top: 5.v, bottom: 80.v), // Added bottom padding
                    child: Form(
                      key: GlobalKey<FormState>(),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 82.v,
                            width: 80.h,
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                CustomImageView(
                                  imagePath: ImageConstant.imgRectangle515,
                                  height: 80.adaptSize,
                                  width: 80.adaptSize,
                                  radius: BorderRadius.circular(40.h),
                                  alignment: Alignment.center,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 7.v),
                          Text(
                            jobPostData['title'] ?? "Job Title",
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          SizedBox(height: 15.v),
                          _buildDivider(),
                          SizedBox(height: 15.v),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Icon(Icons.insert_chart_outlined,
                                      color: Colors.black),
                                  Text(
                                    '${totalValues["impression"]}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight
                                              .bold, // Example modification: Make text bold
                                          fontSize:
                                              24, // Example modification: Set font size to 24
                                          color: Colors
                                              .black, // Example modification: Set text color to black
                                        ),
                                  ), // Add icon
                                  Text(
                                    'Impressions',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(Icons.touch_app, color: Colors.black),
                                  Text(
                                    '${totalValues["clicks"]}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight
                                              .bold, // Example modification: Make text bold
                                          fontSize:
                                              24, // Example modification: Set font size to 24
                                          color: Colors
                                              .black, // Example modification: Set text color to black
                                        ),
                                  ), // Add icon
                                  Text(
                                    'Clicks',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Icon(Icons.chat,
                                      color: Colors.black), // Add icon
                                  Text(
                                    '${totalValues["apply"]}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight
                                              .bold, // Example modification: Make text bold
                                          fontSize:
                                              24, // Example modification: Set font size to 24
                                          color: Colors
                                              .black, // Example modification: Set text color to black
                                        ),
                                  ),
                                  Text(
                                    'Apply',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20.v),
                          SizedBox(height: 15.v),
                          Container(
                            height: 50.v,
                            width: screenWidth - 30.h,
                            margin: EdgeInsets.only(left: 20.h),
                            child: TabBar(
                              dividerColor: Colors.transparent,
                              controller: tabviewController,
                              labelPadding: EdgeInsets.zero,
                              labelColor: Colors.white,
                              labelStyle: TextStyle(
                                fontSize: 14.fSize,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                              unselectedLabelColor: Colors.black,
                              unselectedLabelStyle: TextStyle(
                                fontSize: 14.fSize,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicator: BoxDecoration(
                                color: const Color(0xFF007BFF),
                                borderRadius: BorderRadius.circular(12.h),
                              ),
                              tabs: [
                                Tab(child: Text("Clicks")),
                                Tab(child: Text("Apply")),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 350.v,
                            child: TabBarView(
                              controller: tabviewController,
                              children: [
                                ClickInsightLineChart(
                                  postInsightData: postInsightData,
                                  totalValues: totalValues,
                                ), // Pass description here
                                ApplyInsightLineChart(
                                  postInsightData: postInsightData,
                                  totalValues: totalValues,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Align(
                  //   alignment: Alignment.bottomCenter,
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.only(
                  //         topLeft: Radius.circular(30.5),
                  //         topRight: Radius.circular(30.5),
                  //       ),
                  //     ),
                  //     padding: EdgeInsets.symmetric(
                  //       horizontal: 20.h,
                  //       vertical: 12.v,
                  //     ),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //       children: [
                  //         SizedBox(
                  //             width: 100, // Set the desired width
                  //             child: CustomElevatedButton(
                  //               height: 48.v,
                  //               text: "Edit",
                  //               buttonTextStyle: CustomTextStyles
                  //                   .titleSmallWhiteA700SemiBold,
                  //               onPressed: () {
                  //                 Navigator.pop(context);
                  //               },
                  //               buttonStyle: ElevatedButton.styleFrom(
                  //                 backgroundColor: Color(
                  //                     0xffC2C2C2), // Set the background color here
                  //               ),
                  //             )),

                  //         SizedBox(
                  //           width: 200, // Set the desired width
                  //           child: CustomElevatedButton(
                  //             height: 48.v,
                  //             text: "Apply",
                  //             buttonTextStyle:
                  //                 CustomTextStyles.titleSmallWhiteA700SemiBold,
                  //             onPressed: () async {
                  //               Map<String, dynamic> candidateData = {
                  //                 'label': "${userData["email"]}",
                  //                 'name': "${userData["username"]}",
                  //                 'email': "${userData["email"]}",
                  //                 'status': "pending",
                  //               };

                  //               bool addedCandidateRef =
                  //                   await applyJobController.addCandidate2(
                  //                       "$postId", candidateData);

                  //               if (addedCandidateRef) {
                  //                 ElegantNotification.success(
                  //                   width: 360,
                  //                   isDismissable: false,
                  //                   animation: AnimationType.fromTop,
                  //                   title: Text('Successful Apply'),
                  //                   description: Text(
                  //                       "You successfully applied to this job"),
                  //                   onDismiss: () {},
                  //                   onNotificationPressed: () {},
                  //                   shadow: BoxShadow(
                  //                     color: Colors.green.withOpacity(0.2),
                  //                     spreadRadius: 2,
                  //                     blurRadius: 5,
                  //                     offset: const Offset(0, 4),
                  //                   ),
                  //                 ).show(context);
                  //               } else {
                  //                 ElegantNotification.error(
                  //                   width: 360,
                  //                   isDismissable: false,
                  //                   animation: AnimationType.fromTop,
                  //                   title: Text('Failed Apply'),
                  //                   description:
                  //                       Text("Already applied to this job"),
                  //                   onDismiss: () {},
                  //                   onNotificationPressed: () {},
                  //                   shadow: BoxShadow(
                  //                     color: Colors.red.withOpacity(0.2),
                  //                     spreadRadius: 2,
                  //                     blurRadius: 5,
                  //                     offset: const Offset(0, 4),
                  //                   ),
                  //                 ).show(context);
                  //               }
                  //             },
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 60.v,
      leadingWidth: 30.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(
          left: 20.h,
          top: 20.v,
          bottom: 19.v,
        ),
        onTap: () {
          onTapArrowleftone(context);
        },
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "",
        margin: EdgeInsets.only(
          top: 39.v,
          bottom: 15.v,
        ),
      ),
      styleType: Style.bgFill,
    );
  }

  void onTapArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }

  Widget _buildDivider() {
    return Divider(
      color: appTheme.gray6007f,
      indent: 1.h,
      endIndent: 1.h,
      thickness: 1,
    );
  }
}
