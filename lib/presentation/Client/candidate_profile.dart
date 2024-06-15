import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:workwise/Controller/CandidateController.dart';
import '../../../core/app_export.dart';
import '../../../widgets/app_bar/appbar_leading_image.dart';
import '../../../widgets/app_bar/appbar_title.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../widgets/custom_drop_down.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_text_form_field.dart';
import 'package:workwise/presentation/loading_screen/loading_screen.dart';
// ignore_for_file: must_be_immutable

class CandidateProfile extends StatefulWidget {
  final dynamic candidateDetail;
  CandidateProfile(this.candidateDetail, {Key? key}) : super(key: key);

  @override
  _CandidateProfileState createState() => _CandidateProfileState();
}

class _CandidateProfileState extends State<CandidateProfile> {
  late Future<void> _userDataFuture;
  CandidateController _candidateController = CandidateController();
  dynamic userDetail;

  @override
  void initState() {
    super.initState();
    _userDataFuture = _candidateController.getCandidateDetail(widget.candidateDetail["id"]);
  }

  String? username;
  String? profileImageUrl;
  String? selectedGender;
  String? selectedNationality;
  bool _isUpdating = false;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<String> genderdropdownItemList = ["Male", "Female"];
  List<String> nationalityDropDownList = ["Malaysian", "Non-Malaysian"];

  XFile? _image;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _userDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting || _isUpdating) {
          return LoadingScreen();
        } else {
          if (snapshot.hasError) {
            return Container();
          } else if (snapshot.hasData) {
            dynamic results = snapshot.data;
            userDetail = results;
          }
          return _buildProfileScreen(context);
        }
      },
    );
  }

  Widget _buildProfileScreen(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: _buildAppBar(context),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(top: 33.v, bottom: 80.v), // Added bottom padding to avoid overlapping with the button
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 82.v,
                      width: 80.h,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 40.h,
                            backgroundImage: _image != null
                                ? FileImage(File(_image!.path))
                                : profileImageUrl != null
                                    ? CachedNetworkImageProvider(profileImageUrl!)
                                    : AssetImage(ImageConstant.imgRectangle382) as ImageProvider<Object>,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.v),
                    Text(userDetail["username"], style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                    SizedBox(height: 34.v),
                    _buildNameColumn(context),
                    SizedBox(height: 24.v),
                    _buildEmailColumn(context),
                    SizedBox(height: 24.v),
                    _buildDateOfBirthColumn(context),
                    SizedBox(height: 25.v),
                    _buildGenderColumn(context),
                    SizedBox(height: 25.v),
                    _buildStackCloseOne(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 85.v,
      leadingWidth: 30.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(left: 20.h, top: 45.v, bottom: 19.v),
        onTap: () {
          onTapArrowleftone(context);
        },
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "Profile",
        margin: EdgeInsets.only(top: 39.v, bottom: 15.v),
      ),
      styleType: Style.bgFill,
    );
  }

  /// Section Widget
  Widget _buildNameColumn(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 25.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name",
              style: theme.textTheme.bodyLarge,
            ),
            SizedBox(height: 9.v),
            Padding(
                padding: EdgeInsets.only(right: 15.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20), border: Border.all(color: Color.fromARGB(43, 26, 29, 30)), color: Colors.white),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 21.h, vertical: 19.v),
                          child: Text(
                            userDetail["username"],
                            style: TextStyle(color: Color(0xFF1A1D1E)),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildEmailColumn(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 25.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Email",
              style: theme.textTheme.bodyLarge,
            ),
            SizedBox(height: 9.v),
            Padding(
                padding: EdgeInsets.only(right: 15.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20), border: Border.all(color: Color.fromARGB(43, 26, 29, 30)), color: Colors.white),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 21.h, vertical: 19.v),
                          child: Text(
                            userDetail["email"],
                            style: TextStyle(color: Color(0xFF1A1D1E)),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildDateOfBirthColumn(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 25.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Date of Birth",
              style: theme.textTheme.bodyLarge,
            ),
            SizedBox(height: 9.v),
            Padding(
                padding: EdgeInsets.only(right: 15.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20), border: Border.all(color: Color.fromARGB(43, 26, 29, 30)), color: Colors.white),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 21.h, vertical: 19.v),
                          child: Text(
                            userDetail["dateOfBirth"],
                            style: TextStyle(color: Color(0xFF1A1D1E)),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildGenderColumn(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10.h),
            child: Text(
              "Gender",
              style: theme.textTheme.bodyLarge,
            ),
          ),
          SizedBox(height: 4.v),
          Padding(
              padding: EdgeInsets.only(right: 15.h),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20), border: Border.all(color: Color.fromARGB(43, 26, 29, 30)), color: Colors.white),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 21.h, vertical: 19.v),
                        child: Text(
                          userDetail["gender"],
                          style: TextStyle(color: Color(0xFF1A1D1E)),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildStackCloseOne(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10.h),
            child: Text(
              "Nationality",
              style: theme.textTheme.bodyLarge,
            ),
          ),
          SizedBox(height: 4.v),
          Padding(
              padding: EdgeInsets.only(right: 15.h),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20), border: Border.all(color: Color.fromARGB(43, 26, 29, 30)), color: Colors.white),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 21.h, vertical: 19.v),
                        child: Text(
                          userDetail["Nationality"],
                          style: TextStyle(color: Color(0xFF1A1D1E)),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  /// Navigates back to the previous screen.
  void onTapArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }

  Future<void> getCandidateDetail() async {}
}
