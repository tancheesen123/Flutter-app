import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:workwise/Controller/ManageJobPostController.dart';
import 'package:workwise/presentation/Client/success_post_client.dart';
import '../../../core/app_export.dart';

class NewPostScreen extends StatefulWidget {
  NewPostScreen({Key? key});

  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> with TickerProviderStateMixin {
  bool validToSubmit = false;
  late TabController tabviewController;

  TextEditingController titleTextFieldController = TextEditingController();
  TextEditingController locationTextFieldController = TextEditingController();
  TextEditingController budgetTextFieldController = TextEditingController();
  TextEditingController descriptionTextFieldController = TextEditingController();
  TextEditingController titleMessageTextFieldController = TextEditingController();
  TextEditingController bodyMessageTextFieldController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    tabviewController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    tabviewController.dispose();
    super.dispose();
  }

  void checkValidToSubmit() {
    if (titleTextFieldController.text.isNotEmpty &&
        locationTextFieldController.text.isNotEmpty &&
        budgetTextFieldController.text.isNotEmpty &&
        descriptionTextFieldController.text.isNotEmpty &&
        titleMessageTextFieldController.text.isNotEmpty &&
        bodyMessageTextFieldController.text.isNotEmpty) {
      setState(() {
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
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text(
                      "Write a message that will be shown when a freelancer get accepted.",
                      style: TextStyle(fontWeight: FontWeight.w600),
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
                                "Message title",
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
                            controller: titleMessageTextFieldController,
                            onChanged: (value) {
                              checkValidToSubmit();
                            },
                            decoration: InputDecoration(
                                filled: true,
                                // focusColor: Colors.amber,
                                fillColor: Colors.white,
                                hintText: "Enter the message title",
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
                                "Message body",
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
                            maxLines: 10,
                            controller: bodyMessageTextFieldController,
                            onChanged: (value) {
                              checkValidToSubmit();
                            },
                            decoration: InputDecoration(
                                filled: true,
                                // focusColor: Colors.amber,
                                fillColor: Colors.white,
                                hintText: "Enter the message body",
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
                            onPressed: validToSubmit ? () {} : null,
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
                              titleTextFieldController.text,
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
                                    locationTextFieldController.text,
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
                                        Text(descriptionTextFieldController.text)
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
                                        ManageJobPostController _manageJobPostController = Get.put(ManageJobPostController());

                                        _manageJobPostController
                                            .submitJobPost(
                                                titleTextFieldController.text,
                                                locationTextFieldController.text,
                                                budgetTextFieldController.text,
                                                descriptionTextFieldController.text,
                                                titleMessageTextFieldController.text,
                                                bodyMessageTextFieldController.text)
                                            .then(
                                          (success) {
                                            if (success) {
                                              Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                  builder: (BuildContext context) {
                                                    return SuccessPostClientScreen();
                                                  },
                                                ),
                                                (_) => false,
                                              );
                                            }
                                          },
                                        );
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
