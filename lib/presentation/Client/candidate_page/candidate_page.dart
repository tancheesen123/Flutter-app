import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shimmer/shimmer.dart';
import 'package:workwise/presentation/Client/home_client_container_screen/home_client_container_screen.dart';
import 'package:workwise/presentation/Client/home_client_page/home_client_page.dart';
import '../../../core/app_export.dart';
import 'package:workwise/Controller/CandidateController.dart';
import 'package:workwise/Controller/UserController.dart';

class CandidateScreen extends StatefulWidget {
  CandidateScreen(this.postDetail, {Key? key});

  final dynamic postDetail;

  @override
  State<CandidateScreen> createState() => _CandidateScreenState();
}

class _CandidateScreenState extends State<CandidateScreen> {
  final CandidateController candidateController =
      Get.put(CandidateController());
  final TextEditingController searchTextFieldController =
      TextEditingController();
  bool validToSubmit = false;
  List chosenCheckbox = [];
  List acceptCandidateList = [];
  List pendingCandidateList = [];
  List rejectCandidateList = [];

  void setChosenCheckbox(dynamic checkboxValue) {
    bool alreadyExist = false;

    for (int i = 0; i < chosenCheckbox.length; i++) {
      if (chosenCheckbox[i]["id"] == checkboxValue["id"]) {
        alreadyExist = true;
        setState(() {
          chosenCheckbox.remove(chosenCheckbox[i]);
        });
      } else {
        alreadyExist = false;
      }
    }

    if (alreadyExist == false) {
      chosenCheckbox.add(checkboxValue);
    }
  }

  void checkValidToSubmit() {
    setState(() {
      if (chosenCheckbox.isEmpty) {
        validToSubmit = false;
      } else {
        validToSubmit = true;
      }
    });
  }

  @override
  void initState() {
    (widget.postDetail["post"]["candidate"] as List).forEach((candidate) {
      if (candidate["detail"]["status"].toString().toUpperCase() == "ACCEPT") {
        acceptCandidateList.add(candidate);
      } else if (candidate["detail"]["status"].toString().toUpperCase() ==
          "PENDING") {
        pendingCandidateList.add(candidate);
      } else {
        rejectCandidateList.add(candidate);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? profileImageUrl =
        widget.postDetail["clientData"]['profileImageUrl'];
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.chevron_left,
                      size: 40,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    "Application",
                    style: theme.textTheme.titleLarge,
                  ),
                  IconButton(
                    icon: Icon(Icons.search, size: 40),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: IntrinsicHeight(
              child: Row(
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40.h,
                          backgroundImage: profileImageUrl != null
                              ? CachedNetworkImageProvider(profileImageUrl)
                              : AssetImage(ImageConstant.imgRectangle515)
                                  as ImageProvider<Object>,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "${widget.postDetail["post"]["data"]["title"]}",
                          style: theme.textTheme.titleMedium,
                        ),
                        Text("${widget.postDetail["post"]["data"]["location"]}",
                            style: Theme.of(context).textTheme.bodyLarge),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...List.generate(pendingCandidateList.length, (index) {
                      return CandidateContainer(
                          pendingCandidateList[index],
                          setChosenCheckbox,
                          checkValidToSubmit,
                          widget.postDetail["view"]);
                    }),
                    ...List.generate(acceptCandidateList.length, (index) {
                      return CandidateContainer(
                          acceptCandidateList[index],
                          setChosenCheckbox,
                          checkValidToSubmit,
                          widget.postDetail["view"]);
                    }),
                    // ...List.generate(rejectCandidateList.length, (index) {
                    //   return CandidateContainer(
                    //       rejectCandidateList[index],
                    //       setChosenCheckbox,
                    //       checkValidToSubmit,
                    //       widget.postDetail["view"]);
                    // })
                  ],
                ),
              ),
            ),
          ),
          widget.postDetail["view"] == false
              ? Container(
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
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Container(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 20),
                          child: IntrinsicHeight(
                            child: Row(
                              children: [
                                acceptCandidateList.isNotEmpty
                                    ? Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            candidateController
                                                .acceptCandidate(
                                                    widget.postDetail["post"],
                                                    [
                                                      ...chosenCheckbox,
                                                      ...acceptCandidateList
                                                    ],
                                                    true)
                                                .then((success) {
                                              if (success) {
                                                Navigator.of(context,
                                                        rootNavigator: true)
                                                    .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                    builder:
                                                        (BuildContext context) {
                                                      return HomeClientContainerScreen();
                                                    },
                                                  ),
                                                  (_) => false,
                                                );
                                              } else {
                                                print("Something went wrong");
                                              }
                                            });
                                          },
                                          style: ButtonStyle(
                                            elevation:
                                                MaterialStatePropertyAll(0),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            )),
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Color.fromARGB(
                                                        255, 155, 211, 136)),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 14),
                                            child: Text(
                                              "Stop accepting candidate",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(),
                                SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: validToSubmit
                                        ? () {
                                            candidateController
                                                .acceptCandidate(
                                                    widget.postDetail["post"],
                                                    [
                                                      ...chosenCheckbox,
                                                      ...acceptCandidateList
                                                    ],
                                                    false)
                                                .then((success) {
                                              if (success) {
                                                Navigator.of(context,
                                                        rootNavigator: true)
                                                    .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                    builder:
                                                        (BuildContext context) {
                                                      return HomeClientContainerScreen();
                                                    },
                                                  ),
                                                  (_) => false,
                                                );
                                              } else {
                                                print("Something went wrong");
                                              }
                                            });
                                          }
                                        : null,
                                    style: ButtonStyle(
                                      elevation: MaterialStatePropertyAll(0),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      )),
                                      backgroundColor: MaterialStatePropertyAll(
                                          validToSubmit
                                              ? Color(0xff5598FF)
                                              : Color(0xffF4F6F8)),
                                    ),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 14),
                                      child: Text(
                                        "Employ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: validToSubmit
                                                ? Colors.white
                                                : Color(0xffC2C2C2)),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ))
              : Container()
        ],
      ),
    );
  }
}

class CandidateContainer extends StatefulWidget {
  final dynamic candidateDetail;
  final Function setChosenCheckbox;
  final Function checkValidToSubmit;
  final bool viewOnly;
  CandidateContainer(this.candidateDetail, this.setChosenCheckbox,
      this.checkValidToSubmit, this.viewOnly,
      {Key? key});

  @override
  _CandidateContainerState createState() => _CandidateContainerState();
}

class _CandidateContainerState extends State<CandidateContainer> {
  bool isChecked = false;
  final UserController userController = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    print("${widget.candidateDetail}");
    return FutureBuilder<Map<String, dynamic>?>(
      future: userController
          .getSpecificUserInformation(widget.candidateDetail["id"]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildShimmerLoading();
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text('User data not found'));
        } else {
          Map<String, dynamic> userData = snapshot.data!;
          String? profileImageUrl = userData['profileImageUrl'];
          String name = userData['username'];

          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Color(0xffB3BAC3).withOpacity(0.25),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            margin: EdgeInsets.all(3),
            width: double.infinity,
            height: 75,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.viewEmployeeProfileScreen,
                        arguments: widget.candidateDetail,
                      );
                    },
                    child: CircleAvatar(
                      radius: 40.h,
                      backgroundImage: profileImageUrl != null
                          ? CachedNetworkImageProvider(profileImageUrl)
                          : AssetImage(ImageConstant.imgRectangle515)
                              as ImageProvider<Object>,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Text(
                      name,
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  Spacer(),
                  !widget.viewOnly
                      ? Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 90, 151, 229),
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                          ),
                          child: InkWell(
                            onTap: (widget.candidateDetail["detail"]["status"]
                                        .toString()
                                        .toUpperCase() !=
                                    "ACCEPT")
                                ? () {
                                    setState(() {
                                      isChecked = !isChecked;
                                      widget.setChosenCheckbox(
                                          widget.candidateDetail);
                                      widget.checkValidToSubmit();
                                    });
                                  }
                                : () {},
                            child: (isChecked ||
                                    (widget.candidateDetail["detail"]["status"]
                                            .toString()
                                            .toUpperCase() ==
                                        "ACCEPT"))
                                ? const Icon(Icons.check_rounded,
                                    color: Colors.white)
                                : Padding(
                                    padding: const EdgeInsets.all(2.5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),
                          ),
                        )
                      : Container(),
                  SizedBox(width: 10),
                ],
              ),
            ),
          );
        }
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
                height: 10,
              );
            },
            itemCount: 5, // Set the desired number of shimmer items
            itemBuilder: (context, index) {
              return Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding: EdgeInsets.all(15.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadiusStyle.roundedBorder20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50.adaptSize,
                        width: 50.adaptSize,
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
