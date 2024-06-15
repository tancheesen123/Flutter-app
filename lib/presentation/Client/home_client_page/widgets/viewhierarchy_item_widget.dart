import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workwise/widgets/custom_elevated_button.dart';
import '../../../../core/app_export.dart'; // ignore: must_be_immutable
import '../../post_insight_page/post_insight_page.dart';
import 'package:workwise/Controller/ViewHierarchyController.dart';

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
  late Future buildFuture;
  Widget? jobPostContainer;
  Map<String, dynamic> company = {};

  String _searchText = "";
  List<Map> search_results = [];
  TextEditingController searchTextFieldController = TextEditingController();

  late TabController tabviewController;

  final ViewHierarchyController viewHierarchyController = Get.put(ViewHierarchyController());

  @override
  void initState() {
    // TODO: implement initState
    tabviewController = TabController(length: 2, vsync: this);
    buildFuture = viewHierarchyController.getAllData();
    super.initState();
  }

  Future<void> refreshData() async {
    setState(() {
      buildFuture = viewHierarchyController.getAllData();
    });
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
              jobPostList.clear();
              List<dynamic> results = snapshot.data as List<dynamic>;

              jobPostList.addAll(results[0]);
              company.addAll(results[1]);
            }
          }

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 33.h,
                  right: 20.h,
                ),
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xffB3BAC3).withOpacity(0.25),
                                spreadRadius: 0,
                                blurRadius: 4,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: TextField(
                            onChanged: ((text) {
                              setState(() {
                                _searchText = text;

                                search_results.clear();
                                for (var post in jobPostList) {
                                  if ((post['data']["title"] as String).toLowerCase().contains(_searchText.toLowerCase())) {
                                    search_results.add(post);
                                  }
                                }
                              });
                            }),
                            controller: searchTextFieldController,
                            decoration: InputDecoration(
                                filled: true,
                                // focusColor: Colors.amber,
                                fillColor: Colors.white,
                                hintText: "Search here...",
                                hintStyle: TextStyle(fontWeight: FontWeight.w300),
                                contentPadding: EdgeInsets.all(8),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Color(0xff007BFF)))),
                          ),
                        )),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                              elevation: MaterialStateProperty.all<double>(0.5),
                            ),
                            child: SvgPicture.asset(
                              ImageConstant.imgGoBtn,
                              colorFilter: ColorFilter.mode(Color(0xff007BFF), BlendMode.srcIn),
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, AppRoutes.newPostPage);
                            },
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: refreshData,
                  child: SingleChildScrollView(
                    child: jobPostList.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                                children: List.generate(search_results.isEmpty ? jobPostList.length : search_results.length, (index) {
                              Widget buttonType;

                              List currentJobPost = search_results.isEmpty ? jobPostList : search_results;

                              switch (currentJobPost[index]['data']["postStatus"]) {
                                case "OPEN":
                                  buttonType = Row(children: [
                                    Expanded(
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                                elevation: WidgetStatePropertyAll(0),
                                                shadowColor: WidgetStateColor.transparent,
                                                backgroundColor: WidgetStatePropertyAll(Color(0xffEEEEF3))),
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                context,
                                                AppRoutes.candidatePage,
                                                arguments: {"view": false, "post": currentJobPost[index]},
                                              );
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text("Open"),
                                            ))),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Expanded(
                                        child: Column(
                                      children: [
                                        Text.rich(
                                          TextSpan(children: [
                                            TextSpan(
                                                text: (currentJobPost[index]["candidate"] as List).isNotEmpty
                                                    ? "${currentJobPost[index]["candidate"].length}\n"
                                                    : "0\n",
                                                style: TextStyle(fontSize: 24, color: Color(0xff007BFF))),
                                            TextSpan(text: "applications", style: TextStyle(color: Color(0xff007BFF)))
                                          ]),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(height: 0.9),
                                        )
                                      ],
                                    )),
                                  ]);
                                  break;

                                case "EMPLOYED":
                                  buttonType = Row(
                                    children: [
                                      Expanded(
                                          child: ElevatedButton(
                                              style: ButtonStyle(
                                                  elevation: WidgetStatePropertyAll(0),
                                                  shadowColor: WidgetStateColor.transparent,
                                                  backgroundColor: WidgetStatePropertyAll(Color(0xff007BFF).withOpacity(0.2))),
                                              onPressed: () {},
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Employed",
                                                  style: TextStyle(color: Color(0xff007BFF)),
                                                ),
                                              ))),
                                    ],
                                  );
                                  break;
                                case "COMPLETED":
                                  buttonType = Row(
                                    children: [
                                      Expanded(
                                          child: ElevatedButton(
                                              style: ButtonStyle(
                                                  elevation: WidgetStatePropertyAll(0),
                                                  shadowColor: WidgetStateColor.transparent,
                                                  backgroundColor: WidgetStatePropertyAll(Color(0xffDDFFE9).withOpacity(0.5))),
                                              onPressed: () {},
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Completed",
                                                  style: TextStyle(color: Color(0xff1ED760)),
                                                ),
                                              ))),
                                    ],
                                  );
                                  break;

                                default:
                                  buttonType = Row(
                                    children: [
                                      Expanded(
                                          child: ElevatedButton(
                                              style: ButtonStyle(
                                                  elevation: WidgetStatePropertyAll(0),
                                                  shadowColor: WidgetStateColor.transparent,
                                                  backgroundColor: WidgetStatePropertyAll(Color(0xffDDFFE9).withOpacity(0.5))),
                                              onPressed: () {},
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Completed",
                                                  style: TextStyle(color: Color(0xff1ED760)),
                                                ),
                                              ))),
                                    ],
                                  );
                              }

                              return InkWell(
                                  onTap: () {
                                    showBottomSheetPreviewPost(context, currentJobPost[index], company,
                                        (currentJobPost[index]['data']["postStatus"].toString().toUpperCase() == "OPEN") ? false : true);
                                  },
                                  child: Container(
                                    width: double.infinity,
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
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 5.h),
                                          child: Row(
                                            children: [
                                              Text(
                                                currentJobPost[index]['data']["title"],
                                                style: theme.textTheme.titleLarge,
                                              ),
                                              Spacer(),
                                              PopupMenuButton<int>(
                                                elevation: 2,
                                                onSelected: (item) async {
                                                  if (item == 1) {
                                                    showBottomSheetPreviewPost(
                                                        context,
                                                        jobPostList[index],
                                                        company,
                                                        (currentJobPost[index]['data']["postStatus"].toString().toUpperCase() == "OPEN")
                                                            ? false
                                                            : true);
                                                  } else if (item == 2) {
                                                    print("click 2");
                                                    await viewHierarchyController.deletePostStatus(jobPostList[index]['id']);
                                                    await refreshData();
                                                  } else if (item == 3) {
                                                    await viewHierarchyController.updatePostStatus(jobPostList[index]['id'], "COMPLETED");
                                                    await refreshData();
                                                  }
                                                },
                                                itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                                                  const PopupMenuItem<int>(
                                                    value: 1,
                                                    child: Row(
                                                      children: [
                                                        Icon(Icons.remove_red_eye_outlined),
                                                        SizedBox(width: 10),
                                                        Text('Post Details'),
                                                      ],
                                                    ),
                                                  ),
                                                  const PopupMenuItem<int>(
                                                    value: 2,
                                                    child: Row(
                                                      children: [
                                                        Icon(Icons.delete),
                                                        SizedBox(width: 10),
                                                        Text('Delete'),
                                                      ],
                                                    ),
                                                  ),
                                                  const PopupMenuItem<int>(
                                                    value: 3,
                                                    child: Row(
                                                      children: [
                                                        Icon(Icons.edit),
                                                        SizedBox(width: 10),
                                                        Text('Complete'),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5.h),
                                          child: Text(
                                            currentJobPost[index]['data']["location"],
                                            style: theme.textTheme.titleMedium,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        buttonType
                                      ],
                                    ),
                                  ));
                            })),
                          )
                        : Container(),
                  ),
                ),
              )
            ],
          );
        }));
  }

  Future showBottomSheetPreviewPost(BuildContext context, dynamic jobPostDetail, dynamic company, bool viewOnly) {
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
                            jobPostDetail["data"]['title'] ?? "Job Title",
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          SizedBox(height: 20.v),
                          RichText(
                            text: TextSpan(
                              text: "${company["name"]} -",
                              style: Theme.of(context).textTheme.bodyLarge,
                              children: [
                                WidgetSpan(
                                  child: Icon(
                                    Icons.location_on_outlined,
                                    size: 24.0,
                                  ),
                                ),
                                TextSpan(
                                  text: jobPostDetail["data"]['location'] ?? "Location",
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
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
                                  text: jobPostDetail["data"]['status'] ?? "status",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                TextSpan(
                                  text:
                                      "                   RM${jobPostDetail["data"]['budget'] ?? "123"}/${jobPostDetail["data"]['workingHours'] ?? "123"}h  ",
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
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
                                    child: SizedBox(
                                      height: 500.v,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                                jobPostDetail["data"]["description"],
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
                                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                                "${company["CompanyDetail"]}",
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
                                    buttonTextStyle: CustomTextStyles.titleSmallWhiteA700SemiBold.copyWith(
                                      color: Colors.black, // Set the text color to black
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(context, AppRoutes.editPostPage,
                                          arguments: {"jobPostDetail": jobPostDetail, "companyDetail": company});
                                    },
                                    buttonStyle: ElevatedButton.styleFrom(
                                      backgroundColor: Color.fromARGB(255, 255, 255, 255), // Set the background color here
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.0), // Set the border radius here
                                        side: BorderSide(color: Colors.black), // Set the border color here
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                  width: 80, // Set the desired width
                                  child: CustomElevatedButton(
                                    height: 48.v,
                                    text: "Insight",
                                    buttonTextStyle: CustomTextStyles.titleSmallWhiteA700SemiBold.copyWith(
                                      color: Colors.black, // Set the text color to black
                                    ),
                                    onPressed: () {
                                      Navigator.of(context, rootNavigator: true).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return PostInsightScreen(postId: jobPostDetail["id"]);
                                          },
                                        ),
                                      );
                                    },
                                    buttonStyle: ElevatedButton.styleFrom(
                                      backgroundColor: Color.fromARGB(255, 255, 255, 255), // Set the background color here
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8.0), // Set the border radius here
                                        side: BorderSide(color: Colors.black), // Set the border color here
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                width: 150, // Set the desired width
                                child: CustomElevatedButton(
                                  height: 48.v,
                                  text: "Candidate",
                                  buttonTextStyle: CustomTextStyles.titleSmallWhiteA700SemiBold,
                                  onPressed: () async {
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.candidatePage,
                                      arguments: {"view": viewOnly, "post": jobPostDetail},
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
