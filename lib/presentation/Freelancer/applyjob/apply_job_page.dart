import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../widgets/app_bar/appbar_leading_image.dart';
import '../../../widgets/app_bar/appbar_title.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../widgets/custom_drop_down.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_text_form_field.dart';
import 'descriptionMenu.dart';
import 'companyMenu.dart';

class ApplyJobScreen extends StatefulWidget {
  final String? postId;

  ApplyJobScreen({Key? key, this.postId}) : super(key: key);

  @override
  State<ApplyJobScreen> createState() => _ApplyJobScreenState();
}

class _ApplyJobScreenState extends State<ApplyJobScreen>
    with TickerProviderStateMixin {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  List<String> dropdownItemList = ["Item One", "Item Two", "Item Three"];
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TabController tabviewController;
  late String? postId;

  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 2, vsync: this);
    postId = widget.postId;
  }

  @override
  void dispose() {
    tabviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
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
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          height: 19.adaptSize,
                          width: 19.adaptSize,
                          margin: EdgeInsets.only(right: 6.h),
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.h, vertical: 6.v),
                          decoration: AppDecoration.outlineGray5001.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder9,
                          ),
                          child: CustomImageView(
                            imagePath: ImageConstant.imgFill244,
                            height: 5.v,
                            width: 6.h,
                            alignment: Alignment.centerLeft,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10.v),
                Text(
                  "Chargee",
                  style: theme.textTheme.headlineLarge,
                ),
                SizedBox(height: 20.v),
                RichText(
                  text: TextSpan(
                    text: "Chargee MY -",
                    style: theme.textTheme.bodyLarge,
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.location_on_outlined,
                          size: 24.0,
                        ),
                      ),
                      TextSpan(
                        text: "Intermark Mall, KL",
                        style: theme.textTheme.bodyLarge?.copyWith(
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
                        text: " Part Time ",
                        style: theme.textTheme.bodyLarge,
                      ),
                      TextSpan(
                        text: "                   RM81/9h ",
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15.v),
                Container(
                  height: 50.v,
                  width: screenWidth - 30.h,
                  margin: EdgeInsets.only(left: 20.h),
                  child: TabBar(
                    controller: tabviewController,
                    labelPadding: EdgeInsets.zero,
                    labelColor: appTheme.whiteA700,
                    labelStyle: TextStyle(
                      fontSize: 14.fSize,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                    unselectedLabelColor: appTheme.black900,
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
                      Tab(
                        child: Text("Description"),
                      ),
                      Tab(
                        child: Text("Company"),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 557.v,
                  child: TabBarView(
                    controller: tabviewController,
                    children: [
                      descriptionMenuPage(),
                      CompanyMenuPage(),
                    ],
                  ),
                ),
                SizedBox(height: 15.v),
                _buildStackCloseOne(context),
                SizedBox(height: 10.v),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 60.v,
      leadingWidth: 30.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(
          left: 20.h,
          top: 20.v,
          bottom: 19.v,
        ),
        onTap: () {
          onTapArrowleftone(context);
        },
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "",
        margin: EdgeInsets.only(
          top: 39.v,
          bottom: 15.v,
        ),
      ),
      styleType: Style.bgFill,
    );
  }

  Widget _buildStackCloseOne(BuildContext context) {
    return SizedBox(
      height: 48.v,
      width: double.infinity,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 50.h),
          child: CustomElevatedButton(
            height: 48.v,
            text: "Apply Now",
            buttonTextStyle: CustomTextStyles.titleSmallWhiteA700SemiBold,
            onPressed: () {
              print("clicked");
              print('Post ID in ApplyJobScreen: $postId');
            },
          ),
        ),
      ),
    );
  }

  void onTapArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }
}
