import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:workwise/presentation/Client/preview_post_client.dart';
import '../../../core/app_export.dart';
import 'package:firebase_database/firebase_database.dart';

class NewPostScreen extends StatefulWidget {
  NewPostScreen({Key? key});

  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  bool validToSubmit = false;

  TextEditingController titleTextFieldController = TextEditingController();
  TextEditingController locationTextFieldController = TextEditingController();
  TextEditingController budgetTextFieldController = TextEditingController();
  TextEditingController descriptionTextFieldController = TextEditingController();

  void checkValidToSubmit() {
    if (titleTextFieldController.text.isNotEmpty &&
        locationTextFieldController.text.isNotEmpty &&
        budgetTextFieldController.text.isNotEmpty &&
        descriptionTextFieldController.text.isNotEmpty) {
      setState(() {
        print("Hello");
        validToSubmit = true;
      });
    } else {
      setState(() {
        validToSubmit = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
          child: AppBar(
            centerTitle: true,
            title: Text('New Job Post'),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 40),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                "Title",
                                style: theme.textTheme.titleMedium,
                              )),
                              Icon(
                                Icons.info_outline,
                                color: Color(0xff007BFF),
                              )
                            ],
                          ),
                        ),
                        Container(
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
                            controller: titleTextFieldController,
                            onChanged: (value) {
                              checkValidToSubmit();
                            },
                            decoration: InputDecoration(
                                filled: true,
                                // focusColor: Colors.amber,
                                fillColor: Colors.white,
                                hintText: "Enter the job title",
                                hintStyle: TextStyle(fontWeight: FontWeight.w300),
                                contentPadding: EdgeInsets.all(8),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Color(0xff007BFF)))),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 40),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                "Location",
                                style: theme.textTheme.titleMedium,
                              )),
                            ],
                          ),
                        ),
                        Container(
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
                            controller: locationTextFieldController,
                            onChanged: (value) {
                              checkValidToSubmit();
                            },
                            decoration: InputDecoration(
                                filled: true,
                                // focusColor: Colors.amber,
                                fillColor: Colors.white,
                                hintText: "Enter the location",
                                hintStyle: TextStyle(fontWeight: FontWeight.w300),
                                contentPadding: EdgeInsets.all(8),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Color(0xff007BFF)))),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 40),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                "Your budget per hour",
                                style: theme.textTheme.titleMedium,
                              )),
                              Icon(
                                Icons.info_outline,
                                color: Color(0xff007BFF),
                              )
                            ],
                          ),
                        ),
                        Container(
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
                            controller: budgetTextFieldController,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              checkValidToSubmit();
                            },
                            decoration: InputDecoration(
                                filled: true,
                                // focusColor: Colors.amber,
                                fillColor: Colors.white,
                                hintText: "Enter your budget",
                                hintStyle: TextStyle(fontWeight: FontWeight.w300),
                                contentPadding: EdgeInsets.all(8),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Color(0xff007BFF)))),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 40),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                "Description",
                                style: theme.textTheme.titleMedium,
                              )),
                              Icon(
                                Icons.info_outline,
                                color: Color(0xff007BFF),
                              )
                            ],
                          ),
                        ),
                        Container(
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
                            maxLines: 10,
                            controller: descriptionTextFieldController,
                            onChanged: (value) {
                              checkValidToSubmit();
                            },
                            decoration: InputDecoration(
                                filled: true,
                                // focusColor: Colors.amber,
                                fillColor: Colors.white,
                                hintText: "Describe the rules, requirement and detail about this job ",
                                hintStyle: TextStyle(fontWeight: FontWeight.w300),
                                contentPadding: EdgeInsets.all(8),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Color(0xff007BFF)))),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
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
                            onPressed: validToSubmit
                                ? () {
                                    // Future.delayed(Duration(seconds: 2)).then((value) => showBottomSheetSubmitted(context));
                                  }
                                : null,
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
                                "Cancel",
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
                            onPressed: validToSubmit
                                ? () {
                                    // Future.delayed(Duration(seconds: 2)).then((value) => showBottomSheetSubmitted(context));
                                    // submitJobPost();
                                    showBottomSheetPreviewPost(
                                      context,
                                    );
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
                                "Preview",
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
    ));
  }

  Future showBottomSheetPreviewPost(BuildContext context) {
    List<Map> tabActions = {"title": "Description"};

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
                  Container(
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
                              width: 10,
                              height: 20,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: Text(titleTextFieldController.text),
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
                                  'Intermark Mall, KL',
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
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ButtonStyle(
                                      elevation: MaterialStatePropertyAll(0),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      )),
                                      backgroundColor: MaterialStatePropertyAll(Color(0xff5598FF)),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(15),
                                      child: Text(
                                        "Description",
                                        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                    elevation: MaterialStatePropertyAll(0),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    )),
                                    backgroundColor: MaterialStatePropertyAll(Color(0xff5598FF)),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Text(
                                      "Company",
                                      style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                    elevation: MaterialStatePropertyAll(0),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    )),
                                    backgroundColor: MaterialStatePropertyAll(Color(0xff5598FF)),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Text(
                                      "Reviews",
                                      style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
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
                                        submitJobPost();
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

  Future<void> submitJobPost() async {
    // DatabaseReference ref = FirebaseDatabase.instance.ref("jobPost/");
    Map<String, dynamic> data = {
      "title": titleTextFieldController.text,
      "location": locationTextFieldController.text,
      "budget": int.parse(budgetTextFieldController.text),
      "description": descriptionTextFieldController.text,
    };

    FirebaseFirestore.instance.collection("jobPost").add(data).then((value) {
      print("Successfully add new post");
    });
  }
}
