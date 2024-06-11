import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/app_export.dart'; // ignore: must_be_immutable

class ViewhierarchyItemWidget extends StatefulWidget {
  const ViewhierarchyItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  State<ViewhierarchyItemWidget> createState() => _ViewhierarchyItemWidgetState();
}

class _ViewhierarchyItemWidgetState extends State<ViewhierarchyItemWidget> with TickerProviderStateMixin {
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
                          showBottomSheetPreviewPost(context, jobPostList[index]);
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
    final String? companyID = jsonDecode(prefs.getString("companyDetail")!)["id"];

    DocumentReference companyRef = await FirebaseFirestore.instance.collection("company").doc(companyID);
    return await FirebaseFirestore.instance.collection("jobPost").where("company", isEqualTo: companyRef).get().then((querySnapshot) {
      return querySnapshot.docs;
    });
  }

  Future showBottomSheetPreviewPost(BuildContext context, dynamic jobPostDetail) {
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
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: Text(
                              jobPostDetail["title"],
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('Chagee MY ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                                  Text(
                                    '-',
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xff6A6A6A)),
                                  ),
                                  Icon(
                                    Icons.location_on_outlined,
                                    size: 20,
                                    color: Color(0xff6A6A6A),
                                  ),
                                  Text(
                                    jobPostDetail["location"],
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xff6A6A6A)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 28),
                            child: Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time,
                                        color: Color(0xff6A6A6A),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Part Time",
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Color(0xff6A6A6A)),
                                      )
                                    ],
                                  ),
                                  Text(
                                    "RM15/h",
                                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Color(0xff6A6A6A)),
                                  )
                                ],
                              ),
                            ),
                          ),
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
                                Tab(child: Text("Company")),
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
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Job Descriptions",
                                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                        ),
                                        Text(jobPostDetail["description"])
                                      ],
                                    ),
                                  ),
                                ),
                                // CompanyMenuPage(),
                                Container()
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
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xffB3BAC3).withOpacity(0.25),
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: Offset(0, -4),
                          ),
                        ],
                      ),
                      height: 100,
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Container(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      style: ButtonStyle(
                                        elevation: MaterialStatePropertyAll(0),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        )),
                                        backgroundColor: MaterialStatePropertyAll(Colors.transparent),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 14),
                                        child: Text(
                                          "Edit",
                                          style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xffC2C2C2)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // submitJobPost().then(
                                        //   (success) {
                                        //     if (success) {
                                        //       Navigator.pushNamed(context, AppRoutes.successPostClientScreen);
                                        //     }
                                        //   },
                                        // );
                                      },
                                      style: ButtonStyle(
                                        elevation: MaterialStatePropertyAll(0),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        )),
                                        backgroundColor: MaterialStatePropertyAll(Color(0xff5598FF)),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 14),
                                        child: Text(
                                          "Post",
                                          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            );
          },
        );
      },
    );
  }
}
