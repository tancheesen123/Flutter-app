import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:workwise/widgets/custom_elevated_button.dart';
import '../../../../core/app_export.dart'; // ignore: must_be_immutable
import '../../post_insight_page/post_insight_page.dart';
import "../../../Client/new_post_client.dart";
import 'package:workwise/Controller/ViewHierarchyController.dart';

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
  late Future buildFuture;
  Widget? jobPostContainer;
  Map<String, dynamic> company = {};
  Map<String, dynamic> clientData = {};

  String _searchText = "";
  List<Map> search_results = [];
  TextEditingController searchTextFieldController = TextEditingController();

  late TabController tabviewController;

  final ViewHierarchyController viewHierarchyController =
      Get.put(ViewHierarchyController());

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

  Future<void> refreshData2() async {
    setState(() {
      buildFuture = viewHierarchyController.getAllData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: buildFuture,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildShimmerLoading();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            if (snapshot.hasError) {
              return Container();
            } else if (snapshot.hasData) {
              jobPostList.clear();
              List<dynamic> results = snapshot.data as List<dynamic>;

              jobPostList.addAll(results[0]);
              company.addAll(results[1]);
              clientData.addAll(results[2]);
            }
            return Column(
              children: [
                RefreshIndicator(
                  onRefresh: refreshData,
                  child: Padding(
                    padding: EdgeInsets.only(left: 33, right: 20),
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
                                      color:
                                          Color(0xffB3BAC3).withOpacity(0.25),
                                      spreadRadius: 0,
                                      blurRadius: 4,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: TextField(
                                  onChanged: (text) {
                                    setState(() {
                                      _searchText = text.toLowerCase();
                                      search_results.clear();
                                      for (var post in jobPostList) {
                                        if (post['data']["title"]
                                            .toLowerCase()
                                            .contains(_searchText)) {
                                          search_results.add(post);
                                        }
                                      }
                                    });
                                  },
                                  controller: searchTextFieldController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    hintText: "Search here...",
                                    hintStyle:
                                        TextStyle(fontWeight: FontWeight.w300),
                                    contentPadding: EdgeInsets.all(8),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: Color(0xff007BFF)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                elevation:
                                    MaterialStateProperty.all<double>(0.5),
                              ),
                              child: SvgPicture.asset(
                                ImageConstant.imgGoBtn,
                                colorFilter: ColorFilter.mode(
                                    Color(0xff007BFF), BlendMode.srcIn),
                              ),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return NewPostScreen(
                                          clientData: clientData,
                                          companyData: company);
                                    },
                                  ),
                                );
                              },
                              child: Icon(Icons.add, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: jobPostList.isNotEmpty
                        ? Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              children: List.generate(
                                search_results.isEmpty
                                    ? jobPostList.length
                                    : search_results.length,
                                (index) {
                                  var currentJobPost = search_results.isEmpty
                                      ? jobPostList[index]
                                      : search_results[index];
                                  Widget buttonType;

                                  switch (currentJobPost['data']
                                      ["postStatus"]) {
                                    case "OPEN":
                                      buttonType = Row(
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                elevation: MaterialStateProperty
                                                    .all<double>(0),
                                                shadowColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Colors.transparent),
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Color(0xffEEEEF3)),
                                              ),
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                  context,
                                                  AppRoutes.candidatePage,
                                                  arguments: {
                                                    "view": false,
                                                    "post": currentJobPost,
                                                    "clientData": clientData,
                                                  },
                                                );
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text("Open"),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Text.rich(
                                                  TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: (currentJobPost[
                                                                        "candidate"]
                                                                    as List)
                                                                .isNotEmpty
                                                            ? "${currentJobPost["candidate"].length}\n"
                                                            : "0\n",
                                                        style: TextStyle(
                                                            fontSize: 24,
                                                            color: Color(
                                                                0xff007BFF)),
                                                      ),
                                                      TextSpan(
                                                        text: "applications",
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xff007BFF)),
                                                      ),
                                                    ],
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(height: 0.9),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                      break;
                                    case "EMPLOYED":
                                      buttonType = Row(
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                elevation: MaterialStateProperty
                                                    .all<double>(0),
                                                shadowColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Colors.transparent),
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Color(0xff007BFF)
                                                            .withOpacity(0.2)),
                                              ),
                                              onPressed: () {},
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Employed",
                                                  style: TextStyle(
                                                      color: Color(0xff007BFF)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                      break;
                                    case "COMPLETED":
                                      buttonType = Row(
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                elevation: MaterialStateProperty
                                                    .all<double>(0),
                                                shadowColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Colors.transparent),
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Color(0xffDDFFE9)
                                                            .withOpacity(0.5)),
                                              ),
                                              onPressed: () {},
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Completed",
                                                  style: TextStyle(
                                                      color: Color(0xff1ED760)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                      break;
                                    default:
                                      buttonType = Row(
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                elevation: MaterialStateProperty
                                                    .all<double>(0),
                                                shadowColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Colors.transparent),
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        Color(0xffDDFFE9)
                                                            .withOpacity(0.5)),
                                              ),
                                              onPressed: () {},
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Completed",
                                                  style: TextStyle(
                                                      color: Color(0xff1ED760)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                  }

                                  return InkWell(
                                    onTap: () {
                                      showBottomSheetPreviewPost(
                                        context,
                                        currentJobPost,
                                        company,
                                        clientData,
                                        currentJobPost['data']["postStatus"]
                                                    .toString()
                                                    .toUpperCase() ==
                                                "OPEN"
                                            ? false
                                            : true,
                                      );
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.only(bottom: 24),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 24, vertical: 16),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0xffB3BAC3)
                                                .withOpacity(0.25),
                                            spreadRadius: 0,
                                            blurRadius: 4,
                                            offset: Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 5),
                                            child: Row(
                                              children: [
                                                Text(
                                                  currentJobPost['data']
                                                      ["title"],
                                                  style: theme
                                                      .textTheme.titleLarge,
                                                ),
                                                Spacer(),
                                                PopupMenuButton<int>(
                                                  elevation: 2,
                                                  onSelected: (item) async {
                                                    if (item == 1) {
                                                      showBottomSheetPreviewPost(
                                                        context,
                                                        currentJobPost,
                                                        company,
                                                        clientData,
                                                        currentJobPost['data'][
                                                                        "postStatus"]
                                                                    .toString()
                                                                    .toUpperCase() ==
                                                                "OPEN"
                                                            ? false
                                                            : true,
                                                      );
                                                    } else if (item == 2) {
                                                      print("click 2");
                                                      await viewHierarchyController
                                                          .deletePostStatus(
                                                              jobPostList[index]
                                                                  ['id']);
                                                      await refreshData();
                                                    } else if (item == 3) {
                                                      await viewHierarchyController
                                                          .updatePostStatus(
                                                              jobPostList[index]
                                                                  ['id'],
                                                              "COMPLETED");
                                                      await refreshData();
                                                    }
                                                  },
                                                  itemBuilder:
                                                      (BuildContext context) =>
                                                          <PopupMenuEntry<int>>[
                                                    const PopupMenuItem<int>(
                                                      value: 1,
                                                      child: Row(
                                                        children: [
                                                          Icon(Icons
                                                              .remove_red_eye_outlined),
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
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 5),
                                            child: Text(
                                              currentJobPost['data']
                                                  ["location"],
                                              style:
                                                  theme.textTheme.titleMedium,
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          buttonType,
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        : Container(),
                  ),
                ),
              ],
            );
          }
        }));
  }

  Future showBottomSheetPreviewPost(BuildContext context, dynamic jobPostDetail,
      dynamic company, dynamic clientData, bool viewOnly) {
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
        String? profileImageUrl = clientData['profileImageUrl'];
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
                                CircleAvatar(
                                  radius: 40.h,
                                  backgroundImage: profileImageUrl != null
                                      ? CachedNetworkImageProvider(
                                          profileImageUrl)
                                      : AssetImage(
                                              ImageConstant.imgRectangle515)
                                          as ImageProvider<Object>,
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
                                  text: jobPostDetail["data"]['location'] ??
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
                                  text: jobPostDetail["data"]['status'] ??
                                      "status",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                TextSpan(
                                  text:
                                      "                   RM${jobPostDetail["data"]['budget'] ?? "123"}/${jobPostDetail["data"]['workingHours'] ?? "123"}h  ",
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
                                                jobPostDetail["data"]
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
                                      Navigator.pushNamed(
                                          context, AppRoutes.editPostPage,
                                          arguments: {
                                            "jobPostDetail": jobPostDetail,
                                            "companyDetail": company
                                          });
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
                                                postId: jobPostDetail["id"],
                                                clientData: clientData);
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
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.candidatePage,
                                      arguments: {
                                        "view": viewOnly,
                                        "post": jobPostDetail,
                                        "clientData": clientData
                                      },
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

  Widget _buildShimmerLoading() {
    return SizedBox(
      width: 370.h,
      child: Padding(
        padding: EdgeInsets.only(bottom: 1.0),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 14,
              );
            },
            itemCount: 5, // Set the desired number of shimmer items
            itemBuilder: (context, index) {
              return Align(
                alignment: Alignment.topCenter,
                child: Container(
                  // padding: EdgeInsets.all(15.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadiusStyle.roundedBorder20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 130,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(15.h),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.h, bottom: 4.v),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 20.v,
                              width: 150.h,
                              color: Colors.grey[300],
                            ),
                            SizedBox(height: 2.v),
                            Container(
                              height: 14.v,
                              width: 100.h,
                              color: Colors.grey[300],
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(top: 15.v, bottom: 16.v),
                        child: Container(
                          height: 20.v,
                          width: 80.h,
                          color: Colors.grey[300],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
