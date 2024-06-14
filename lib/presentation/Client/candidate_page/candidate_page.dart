import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import '../../../core/app_export.dart';

class CandidateScreen extends StatefulWidget {
  CandidateScreen(this.postDetail, {Key? key});

  final dynamic postDetail;

  @override
  State<CandidateScreen> createState() => _CandidateScreenState();
}

class _CandidateScreenState extends State<CandidateScreen> {
  final TextEditingController searchTextFieldController = TextEditingController();
  bool validToSubmit = false;
  List chosenCheckbox = [];

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
  Widget build(BuildContext context) {
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
                        CustomImageView(
                          imagePath: ImageConstant.imgRectangle515,
                          height: 80.adaptSize,
                          width: 80.adaptSize,
                          radius: BorderRadius.circular(40.h),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "${widget.postDetail["data"]["title"]}",
                          style: theme.textTheme.titleMedium,
                        ),
                        Text("${widget.postDetail["data"]["location"]}", style: Theme.of(context).textTheme.bodyLarge),
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
                  children: List.generate(widget.postDetail["candidate"].length, (index) {
                    //list job post yg kita nk tukar ke candidate list
                    return CandidateContainer(widget.postDetail["candidate"][index], setChosenCheckbox, checkValidToSubmit);
                  }),
                ),
              ),
            ),
          ),
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
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: validToSubmit
                                  ? () {
                                      acceptCandidate(widget.postDetail, chosenCheckbox).then((success) {
                                        if (success) {
                                          Navigator.of(context, rootNavigator: true).pushNamed(AppRoutes.homeClientPage);
                                        } else {
                                          print("Something went wrong");
                                        }
                                      });
                                    }
                                  : null,
                              style: ButtonStyle(
                                elevation: MaterialStatePropertyAll(0),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                )),
                                backgroundColor: MaterialStatePropertyAll(validToSubmit ? Color(0xff5598FF) : Color(0xffF4F6F8)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 14),
                                child: Text(
                                  "Employ",
                                  style: TextStyle(fontWeight: FontWeight.w600, color: validToSubmit ? Colors.white : Color(0xffC2C2C2)),
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
  }
}

class CandidateContainer extends StatefulWidget {
  final dynamic candidateDetail;
  final Function setChosenCheckbox;
  final Function checkValidToSubmit;
  CandidateContainer(this.candidateDetail, this.setChosenCheckbox, this.checkValidToSubmit, {Key? key});

  @override
  _CandidateContainerState createState() => _CandidateContainerState();
}

class _CandidateContainerState extends State<CandidateContainer> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
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
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImageView(
              //gambar candidate
              alignment: Alignment.topLeft,
              imagePath: ImageConstant.imgRectangle382,
              height: 50.adaptSize,
              width: 50.adaptSize,
              radius: BorderRadius.all(Radius.circular(6)),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Text(
                widget.candidateDetail["detail"]["name"],
                style: theme.textTheme.titleMedium,
              ),
            ),
            Spacer(),
            Container(
              //container utk kotak checkbox
              //alignment: Alignment.topRight,
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                //checkbox
                color: Color.fromARGB(255, 90, 151, 229),
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              child: InkWell(
                onTap: () {
                  setState(() {
                    isChecked = !isChecked;
                    widget.setChosenCheckbox(widget.candidateDetail);
                    widget.checkValidToSubmit();
                  });
                },
                child: isChecked
                    ? const Icon(Icons.check_rounded, color: Colors.white)
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
            ),
            SizedBox(width: 10),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [Align()],
            // ),
          ],
        ),
      ),
    );
  }
}

Future<bool> acceptCandidate(dynamic postDetail, List listAcceptedCandidate) async {
  try {
    await FirebaseFirestore.instance.collection('jobPost').doc(postDetail["id"]).update({"postStatus": "EMPLOYED"});

    await Future.forEach<dynamic>(listAcceptedCandidate, (candidate) async {
      FirebaseFirestore.instance
          .collection('jobPost')
          .doc(postDetail["id"])
          .collection("candidate")
          .doc(candidate["id"])
          .update({"status": "Accept"});
    });

    await Future.forEach<dynamic>(listAcceptedCandidate, (candidate) async {
      dynamic userApplication = await FirebaseFirestore.instance
          .collection('user')
          .doc(candidate["id"])
          .collection("Application")
          .where("postRefPath", isEqualTo: postDetail["postReference"].reference)
          .get();

      print(userApplication);
      await FirebaseFirestore.instance
          .collection('user')
          .doc(candidate["id"])
          .collection("Application")
          .doc(userApplication.docs[0].id)
          .update({"status": "Accept"});
    });
    return true;
  } catch (e) {
    return false;
  }
}
