import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/app_export.dart';
import '../../../widgets/app_bar/appbar_leading_image.dart';
import '../../../widgets/app_bar/appbar_title.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../widgets/custom_elevated_button.dart';
import 'package:workwise/Controller/ApplyJobController.dart';
import 'package:workwise/Controller/UserController.dart'; // Import the JobPost model
import 'package:workwise/Controller/PostInsightController.dart';
import 'descriptionMenu.dart';
import 'companyMenu.dart';
import "../myjob_applications_page/myjob_applications_page.dart";

class ApplyJobScreen extends StatefulWidget {
  final String? postId;

  ApplyJobScreen({Key? key, this.postId}) : super(key: key);

  @override
  State<ApplyJobScreen> createState() => _ApplyJobScreenState();
}

class _ApplyJobScreenState extends State<ApplyJobScreen>
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
    print("This is postId in applyJobPage $postId");
    postInsightController.saveClicks(postId ?? "");
  }

  @override
  void dispose() {
    tabviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    print("This is widget postId ${widget.postId}");
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: FutureBuilder(
          future: Future.wait([
            applyJobController.getJobPostData(widget.postId ?? ""),
            userController.getUserInformation(),
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
              print("This is Data $data");
              Map<String, dynamic> jobPostData = data[0];
              Map<String, dynamic> userData = data[1];
              DocumentReference? userRef =
                  jobPostData["jobpostData"]['user'] as DocumentReference?;
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
                            child: FutureBuilder<DocumentSnapshot>(
                              future: applyJobController.getUserData(userRef!),
                              builder: (context, userSnapshot) {
                                if (userSnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return _buildShimmerLoading_CompanyLogo();
                                } else if (userSnapshot.hasError) {
                                  return Text('Error: ${userSnapshot.error}');
                                } else if (!userSnapshot.hasData ||
                                    !userSnapshot.data!.exists) {
                                  return Text('No user data found');
                                } else {
                                  String? profileImageUrl =
                                      userSnapshot.data!.get('profileImageUrl');
                                  return Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      CircleAvatar(
                                        radius: 40.h,
                                        backgroundImage: profileImageUrl != null
                                            ? CachedNetworkImageProvider(
                                                profileImageUrl)
                                            : AssetImage(ImageConstant
                                                    .imgRectangle515)
                                                as ImageProvider<Object>,
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),
                          ),
                          SizedBox(height: 10.v),
                          Text(
                            jobPostData["jobpostData"]['title'] ?? "Job Title",
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          SizedBox(height: 20.v),
                          RichText(
                            text: TextSpan(
                              text: "${jobPostData['companyData']['name']} -",
                              style: Theme.of(context).textTheme.bodyLarge,
                              children: [
                                WidgetSpan(
                                  child: Icon(
                                    Icons.location_on_outlined,
                                    size: 24.0,
                                  ),
                                ),
                                TextSpan(
                                  text: jobPostData["jobpostData"]
                                          ['location'] ??
                                      "Location",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.v),
                          RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Icon(
                                    Icons.access_time,
                                    size: 24.0,
                                  ),
                                ),
                                TextSpan(
                                  text: jobPostData["jobpostData"]['status'] ??
                                      "status",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                TextSpan(
                                  text:
                                      "                   RM${jobPostData["jobpostData"]['budget'] ?? "123"}/${jobPostData["jobpostData"]['workingHours'] ?? "123"}h  ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                          ),
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
                                Tab(child: Text("Description")),
                                Tab(child: Text("Company")),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 300.v,
                            child: TabBarView(
                              controller: tabviewController,
                              children: [
                                // descriptionMenuPage(
                                //     description: jobPostData["jobpostData"]
                                //             ['description'] ??
                                //         "No description available"), // Pass description here
                                // CompanyMenuPage(
                                //     description: jobPostData["companyData"]
                                //             ['CompanyDetail'] ??
                                //         "No Company Detail available"),
                                Expanded(
                                    child: Container(
                                  child: TabBarView(
                                    controller: tabviewController,
                                    children: [
                                      SingleChildScrollView(
                                        child: Padding(
                                          padding: const EdgeInsets.all(32.0),
                                          child: SizedBox(
                                            height: 500.v,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Job Descriptions",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: SingleChildScrollView(
                                                    child: Text(
                                                      jobPostData["jobpostData"]
                                                          ["description"],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SingleChildScrollView(
                                        child: Padding(
                                          padding: const EdgeInsets.all(32.0),
                                          child: SizedBox(
                                            height: 500.v,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Company Detail",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: SingleChildScrollView(
                                                    child: Text(
                                                      "${jobPostData["companyData"]["CompanyDetail"]}",
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.5),
                          topRight: Radius.circular(30.5),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.h, vertical: 12.v),
                      child: CustomElevatedButton(
                        height: 48.v,
                        text: "Apply",
                        buttonTextStyle:
                            CustomTextStyles.titleSmallWhiteA700SemiBold,
                        onPressed: () async {
                          Map<String, dynamic> candidateData = {
                            'label': "${userData["email"]}",
                            'name': "${userData["username"]}",
                            'email': "${userData["email"]}",
                            'status': "pending",
                          };

                          // await applyJobController.addCandidate(
                          //     "$postId", candidateData);

                          bool addedCandidateRef = await applyJobController
                              .addCandidate2("$postId", candidateData);

                          // If candidate added successfully, navigate to specific page
                          if (addedCandidateRef) {
                            ElegantNotification.success(
                              width: 360,
                              isDismissable: false,
                              animation: AnimationType.fromTop,
                              title: Text('Successful Apply'),
                              description:
                                  Text("You successful Apply to this Job"),
                              onDismiss: () {},
                              onNotificationPressed: () {},
                              shadow: BoxShadow(
                                color: Colors.green.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 4),
                              ),
                            ).show(context);
                          } else {
                            ElegantNotification.error(
                              width: 360,
                              isDismissable: false,
                              animation: AnimationType.fromTop,
                              title: Text('Failed Apply'),
                              description: Text("Already apply to this job"),
                              onDismiss: () {},
                              onNotificationPressed: () {},
                              shadow: BoxShadow(
                                color: Colors.red.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 4),
                              ),
                            ).show(context);
                          }
                        },
                      ),
                    ),
                  ),
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

  Widget _buildShimmerLoading_CompanyLogo() {
    return SizedBox(
      height: 50.v,
      width: 50.h,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: CircleAvatar(
          radius: 40.h,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
