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

class CandidateScreen extends StatelessWidget {
  CandidateScreen({Key? key});

  TextEditingController searchTextFieldController = TextEditingController();

  List<Map<String, dynamic>> jobPost = [
    {
      "image": 'img_rectangle_515.png',
      "candidateName": "Rozanne Barrientes",

    },
    {
      "company": "Chagee MY",
      "jobTitle": "Warehouse Crew",

    },
    {
      "company": "Chagee MY",
      "jobTitle": "Warehouse Crew",

    },
    {
      "company": "Chagee MY",
      "jobTitle": "Warehouse Crew",

    },
    {
      "company": "Chagee MY",
      "jobTitle": "Warehouse Crew",

    },
    {
      "company": "Chagee MY",
      "jobTitle": "Warehouse Crew",

    },
    {
      "company": "Chagee MY",
      "jobTitle": "Warehouse Crew",

    },
    {
      "company": "Chagee MY",
      "jobTitle": "Warehouse Crew",

    },
    {
      "company": "Chagee MY",
      "jobTitle": "Warehouse Crew",

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
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(width: 16), // Space between the button and the text
                    Text(
                      "Application",
                      style: theme.textTheme.titleLarge,
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
                            "Tea Barista",
                            style: theme.textTheme.titleMedium,
                          ),
                          Text(
                          
                            "Intermark Mall, KL",
                            style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      
                          ),
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
                    children: List.generate(jobPost.length, (index) {//list job post yg kita nk tukar ke candidate list
                      return CandidateContainer(jobPost[index]);
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

class CandidateContainer extends StatefulWidget {
  final Map<String, dynamic> jobPostDetail;
  CandidateContainer(this.jobPostDetail, {Key? key}) : super(key: key);

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
        padding: const EdgeInsets.fromLTRB(20,12,20,12),
        
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [

              CustomImageView(//gambar candidate
                alignment: Alignment.topLeft,
                imagePath: ImageConstant.imgRectangle382,
                height: 50.adaptSize,
                width: 50.adaptSize,
                radius:  BorderRadius.all(Radius.circular(6)),
              ),
            Container(
              padding: const EdgeInsets.fromLTRB(20,0,20,0),
              child: Text(
              "Tea Barista",
              style: theme.textTheme.titleMedium,
            ),
            ),  
            Spacer(),
              Container(//container utk kotak checkbox
                  //alignment: Alignment.topRight,
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(//checkbox
                  color: Color.fromARGB(255, 90, 151, 229),
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        isChecked = !isChecked;
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}


