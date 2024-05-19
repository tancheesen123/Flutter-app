import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/app_export.dart';
import '../../../widgets/custom_bottom_bar.dart';
import '../../../widgets/custom_icon_button.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../home_client_page/home_client_page.dart';
import 'widgets/listchageemy_item_widget.dart';

class PostListScreen extends StatelessWidget {
  PostListScreen({Key? key});

  TextEditingController searchTextFieldController = TextEditingController();

  List<Map<String, dynamic>> jobPost = [
    {
      "company": "Chagee MY",
      "jobTitle": "Warehouse Crew",
      "Location": "Bukit Raja, Klang",
      "status": 1
    },
    {
      "company": "Chagee MY",
      "jobTitle": "Warehouse Crew",
      "Location": "Bukit Raja, Klang",
      "status": 2
    },
    {
      "company": "Chagee MY",
      "jobTitle": "Warehouse Crew",
      "Location": "Bukit Raja, Klang",
      "status": 2
    },
    {
      "company": "Chagee MY",
      "jobTitle": "Warehouse Crew",
      "Location": "Bukit Raja, Klang",
      "status": 2
    },
    {
      "company": "Chagee MY",
      "jobTitle": "Warehouse Crew",
      "Location": "Bukit Raja, Klang",
      "status": 2
    },
    {
      "company": "Chagee MY",
      "jobTitle": "Warehouse Crew",
      "Location": "Bukit Raja, Klang",
      "status": 2
    },
    {
      "company": "Chagee MY",
      "jobTitle": "Warehouse Crew",
      "Location": "Bukit Raja, Klang",
      "status": 2
    },
    {
      "company": "Chagee MY",
      "jobTitle": "Warehouse Crew",
      "Location": "Bukit Raja, Klang",
      "status": 2
    },
    {
      "company": "Chagee MY",
      "jobTitle": "Warehouse Crew",
      "Location": "Bukit Raja, Klang",
      "status": 2
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: EdgeInsets.all(28),
                child: Container(
                  child: Text(
                    "Post",
                    style: theme.textTheme.titleLarge,
                  ),
                ),
              ),
            ),
            Container(
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
                        controller: searchTextFieldController,
                        decoration: InputDecoration(
                            filled: true,
                            // focusColor: Colors.amber,
                            fillColor: Colors.white,
                            hintText: "Search here...",
                            hintStyle: TextStyle(fontWeight: FontWeight.w300),
                            contentPadding: EdgeInsets.all(8),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Color(0xff007BFF)))),
                      ),
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          elevation: MaterialStateProperty.all<double>(0.5),
                        ),
                        child: SvgPicture.asset(
                          ImageConstant.imgGoBtn,
                          colorFilter: ColorFilter.mode(
                              Color(0xff007BFF), BlendMode.srcIn),
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
            Expanded(
              child: Container(
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(jobPost.length, (index) {
                      return JobPostContainer(jobPost[index]);
                    }),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class JobPostContainer extends StatelessWidget {
  final Map<String, dynamic> jobPostDetail;
  JobPostContainer(this.jobPostDetail, {Key? key}) : super(key: key);

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
      margin: EdgeInsets.only(bottom: 20),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Chagee MY",
                    style: theme.textTheme.bodySmall,
                  ),
                  Text(
                    "Warehouse Crew",
                    style: theme.textTheme.titleMedium,
                  ),
                  Text(
                    "Bukit Raja, Klang",
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            jobPostDetail["status"] == 1
                ? Container(
                    height: 32,
                    decoration: BoxDecoration(
                        color: Color(0xffDDFFE9).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "Completed",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16,
                            color: Color(0xff1ED760)),
                      ),
                    ),
                  )
                : Container(
                    height: 32,
                    decoration: BoxDecoration(
                        color: Color(0xff007BFF).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "Employed",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 16,
                            color: Color(0xff007BFF)),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
