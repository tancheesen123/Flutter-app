import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../core/app_export.dart';
import '../../../widgets/app_bar/appbar_leading_image.dart';
import '../../../widgets/app_bar/appbar_title.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import 'widgets/userprofile_item_widget.dart';
import 'package:workwise/Controller/MyJobController.dart';
import 'package:workwise/Controller/UserController.dart';
// ignore_for_file: must_be_immutable

class MyjobApplicationsPage extends StatefulWidget {
  const MyjobApplicationsPage({Key? key}) : super(key: key);

  @override
  State<MyjobApplicationsPage> createState() => _MyjobApplicationsPageState();
}

class _MyjobApplicationsPageState extends State<MyjobApplicationsPage> {
  final MyJobController myJobController = Get.put(MyJobController());
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: myJobController
              .fetchData(), // Use the fetchData function as the future
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              // Use the data returned by the future
              List<Map<String, dynamic>> dataList = snapshot.data ?? [];
              print("this is dataList $dataList");
              return Padding(
                padding: EdgeInsets.only(top: 4.v),
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 26.v,
                    );
                  },
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    // Pass data to UserprofileItemWidget
                    // print("adasdadsa");
                    // print(dataList[index]);
                    return UserprofileItemWidget(data: dataList[index]);
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 30.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(
          left: 20.h,
          top: 16.v,
          bottom: 18.v,
        ),
        onTap: () {
          onTapArrowleftone(context);
        },
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "Applications",
      ),
    );
  }

  /// Navigates back to the previous screen.
  onTapArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }
}
