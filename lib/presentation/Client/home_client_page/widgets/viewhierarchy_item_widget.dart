import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workwise/widgets/custom_elevated_button.dart';
import '../../../../core/app_export.dart'; // ignore: must_be_immutable
import '../../post_insight_page/widgets/post_insight_item.dart';
import '../../post_insight_page/post_insight_page.dart';

class ViewhierarchyItemWidget extends StatefulWidget {
  const ViewhierarchyItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  State<ViewhierarchyItemWidget> createState() =>
      _ViewhierarchyItemWidgetState();
}

class _ViewhierarchyItemWidgetState extends State<ViewhierarchyItemWidget>
    with TickerProviderStateMixin {
  List data = [];
  List<dynamic> jobPostList = [];
  bool refresh = false;
  late Future buildFuture;

  late TabController tabviewController;

  @override
  void initState() {
    // TODO: implement initState
    tabviewController = TabController(length: 2, vsync: this);
    buildFuture = getAllJobPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: buildFuture,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Container();
            } else if (snapshot.hasData) {
              data.clear();
              jobPostList.clear();
              data.addAll(snapshot.data! as List<dynamic>);
              data.forEach((job) {
                jobPostList.add(job.data());
              });
            }
          }

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: SingleChildScrollView(
              child: jobPostList.isNotEmpty
                  ? Column(
                      children: List.generate(jobPostList.length, (index) {
                      return InkWell(
                        onTap: () {
                          showBottomSheetPreviewPost(
                              context, jobPostList[index]);
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 24),
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.h,
                            vertical: 16.v,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xffB3BAC3).withOpacity(0.25),
                                spreadRadius: 0,
                                blurRadius: 4,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 4.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      jobPostList[index]["title"],
                                      style: theme.textTheme.titleMedium,
                                    ),
                                    SizedBox(height: 4.v),
                                    Text(
                                      jobPostList[index]["location"],
                                      style: theme.textTheme.bodySmall,
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 17.v,
                                  bottom: 11.v,
                                ),
                                child: Text(
                                  "Completed",
                                  style: CustomTextStyles.labelLargeGreenA700,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }))
                  : Container(),
            ),
          );
        }));
  }

  Future getAllJobPost() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? companyID =
        jsonDecode(prefs.getString("companyDetail")!)["id"];

    DocumentReference companyRef =
        await FirebaseFirestore.instance.collection("company").doc(companyID);
    return await FirebaseFirestore.instance
        .collection("jobPost")
        .where("company", isEqualTo: companyRef)
        .get()
        .then((querySnapshot) {
      return querySnapshot.docs;
    });
  }

  Future showBottomSheetPreviewPost(
      BuildContext context, dynamic jobPostDetail) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      builder: (BuildContext context) {
        final Size screenSize = MediaQuery.of(context).size;

        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              color: Colors.white,
              height: screenSize.height * 0.95,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xffB3BAC3).withOpacity(0.25),
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            child: Center(
                              child: SizedBox(
                                height: 54,
                              ),
                            ),
                          ),
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
                          SizedBox(height: 10.v),
                          Text(
                            jobPostDetail['title'] ?? "Job Title",
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
                                  text: jobPostDetail['location'] ?? "Location",
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
                                  text: jobPostDetail['status'] ?? "status",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                TextSpan(
                                  text:
                                      "                   RM${jobPostDetail['budget'] ?? "123"}/${jobPostDetail['workingHours'] ?? "123"}h  ",
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
                                Tab(child: Text("Insight")),
                              ],
                            ),
                          ),
                          Expanded(
                              child: Container(
                            child: TabBarView(
                              controller: tabviewController,
                              children: [
                                SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.all(32.0),
                                    child: SizedBox(
                                      height: 200.v,
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
                                                jobPostDetail["description"],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                PostInsightItemPage(),
                              ],
                            ),
                          ))
                        ],
                      ),
                    ),
                  ),
                  // Spacer(),
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xffB3BAC3).withOpacity(0.25),
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: Offset(0, -4),
                          ),
                        ],
                      ),
                      height: 75,
                      child: Align(
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
                            horizontal: 20.h,
                            vertical: 12.v,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                  width: 80, // Set the desired width
                                  child: CustomElevatedButton(
                                    height: 48.v,
                                    text: "Edit",
                                    buttonTextStyle: CustomTextStyles
                                        .titleSmallWhiteA700SemiBold
                                        .copyWith(
                                      color: Colors
                                          .black, // Set the text color to black
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    buttonStyle: ElevatedButton.styleFrom(
                                      backgroundColor: Color.fromARGB(
                                          255,
                                          255,
                                          255,
                                          255), // Set the background color here
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            8.0), // Set the border radius here
                                        side: BorderSide(
                                            color: Colors
                                                .black), // Set the border color here
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                  width: 80, // Set the desired width
                                  child: CustomElevatedButton(
                                    height: 48.v,
                                    text: "Insight",
                                    buttonTextStyle: CustomTextStyles
                                        .titleSmallWhiteA700SemiBold
                                        .copyWith(
                                      color: Colors
                                          .black, // Set the text color to black
                                    ),
                                    onPressed: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return PostInsightScreen(
                                                postId: "a3");
                                          },
                                        ),
                                      );
                                    },
                                    buttonStyle: ElevatedButton.styleFrom(
                                      backgroundColor: Color.fromARGB(
                                          255,
                                          255,
                                          255,
                                          255), // Set the background color here
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            8.0), // Set the border radius here
                                        side: BorderSide(
                                            color: Colors
                                                .black), // Set the border color here
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                width: 150, // Set the desired width
                                child: CustomElevatedButton(
                                  height: 48.v,
                                  text: "Candidate",
                                  buttonTextStyle: CustomTextStyles
                                      .titleSmallWhiteA700SemiBold,
                                  onPressed: () async {
                                    Navigator.of(context, rootNavigator: true)
                                        .push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return PostInsightScreen(
                                              postId: "a3");
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
