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
            applyJobController.getJobPostData(widget.postId!),
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
              Map<String, dynamic> jobPostData = data[0];
              Map<String, dynamic> userData = data[1];
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
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    height: 19.adaptSize,
                                    width: 19.adaptSize,
                                    margin: EdgeInsets.only(right: 6.h),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5.h, vertical: 6.v),
                                    decoration:
                                        AppDecoration.outlineGray5001.copyWith(
                                      borderRadius:
                                          BorderRadiusStyle.roundedBorder9,
                                    ),
                                    child: CustomImageView(
                                      imagePath: ImageConstant.imgFill244,
                                      height: 5.v,
                                      width: 6.h,
                                      alignment: Alignment.centerLeft,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 10.v),
                          Text(
                            jobPostData['title'] ?? "Job Title",
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          SizedBox(height: 20.v),
                          RichText(
                            text: TextSpan(
                              text: "Chargee MY -",
                              style: Theme.of(context).textTheme.bodyLarge,
                              children: [
                                WidgetSpan(
                                  child: Icon(
                                    Icons.location_on_outlined,
                                    size: 24.0,
                                  ),
                                ),
                                TextSpan(
                                  text: jobPostData['location'] ?? "Location",
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
                                  text: jobPostData['status'] ?? "status",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                TextSpan(
                                  text:
                                      "                   RM${jobPostData['budget'] ?? "123"}/${jobPostData['workingHours'] ?? "123"}h  ",
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
                            height: 557.v,
                            child: TabBarView(
                              controller: tabviewController,
                              children: [
                                descriptionMenuPage(
                                    description: jobPostData['description'] ??
                                        "No description available"), // Pass description here
                                CompanyMenuPage(),
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
                          // await applyJobController.getCandidates("$postId");
                          // // Print candidates' data to console
                          // for (var candidate in applyJobController.candidates) {
                          //   print(
                          //       'Candidate: ${candidate['name']}, Email: ${candidate['email']}, status: ${candidate['status']}');
                          // }
                          // print("clicked");
                          // print('Post ID in ApplyJobScreen: $postId');
                          // String username =
                          //     await applyJobController.loadUsername();
                          // print("Loaded Username: $username");
                          // // Add the logic to save the form data

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
}
