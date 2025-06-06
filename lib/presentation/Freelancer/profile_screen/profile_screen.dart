import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/app_export.dart';
import '../../../widgets/app_bar/appbar_leading_image.dart';
import '../../../widgets/app_bar/appbar_title.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../widgets/custom_drop_down.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_text_form_field.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:workwise/presentation/loading_screen/loading_screen.dart';
// ignore_for_file: must_be_immutable

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<void> _userDataFuture;

  @override
  void initState() {
    super.initState();
    _userDataFuture = _getUserData();
  }

  String? username;
  String? profileImageUrl;
  String? selectedGender;
  String? selectedNationality;
  bool _isUpdating = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController identityNumberController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<String> genderdropdownItemList = ["Male", "Female"];
  List<String> nationalityDropDownList = ["Malaysian", "Non-Malaysian"];

  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _userDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting || _isUpdating) {
          return LoadingScreen();
        } else {
          // Data and image are loaded, show profile screen
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
              padding: EdgeInsets.only(
                  top: 33.v,
                  bottom: 80
                      .v), // Added bottom padding to avoid overlapping with the button
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
                          GestureDetector(
                            onTap: _pickImage,
                            child: CircleAvatar(
                              radius: 40.h,
                              backgroundImage: _image != null
                                  ? FileImage(File(_image!.path))
                                  : profileImageUrl != null
                                      ? CachedNetworkImageProvider(
                                          profileImageUrl!)
                                      : AssetImage(
                                              ImageConstant.imgRectangle382)
                                          as ImageProvider<Object>,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                              onTap: _pickImage,
                              child: Container(
                                height: 19.adaptSize,
                                width: 19.adaptSize,
                                margin: EdgeInsets.only(right: 6.h),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5.h, vertical: 6.v),
                                decoration:
                                    AppDecoration.outlineGray5001.copyWith(
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder9,
                                ),
                                child: CustomImageView(
                                  imagePath: ImageConstant.imgFill244,
                                  height: 5.v,
                                  width: 6.h,
                                  alignment: Alignment.centerLeft,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 10.v),
                    Text(username ?? '', style: theme.textTheme.headlineLarge),
                    Text("Edit Profile", style: theme.textTheme.bodyMedium),
                    SizedBox(height: 34.v),
                    _buildNameColumn(context),
                    SizedBox(height: 24.v),
                    _buildEmailColumn(context),
                    SizedBox(height: 24.v),
                    _buildDateOfBirthColumn(context),
                    SizedBox(height: 29.v),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 25.h),
                        child: Text("Identity Number",
                            style: theme.textTheme.bodyLarge),
                      ),
                    ),
                    SizedBox(height: 9.v),
                    Padding(
                      padding: EdgeInsets.only(left: 25.h, right: 15.h),
                      child: CustomTextFormField(
                        controller: identityNumberController,
                        textInputAction: TextInputAction.done,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 21.h, vertical: 19.v),
                        textStyle: TextStyle(color: Color(0xFF1A1D1E)),
                      ),
                    ),
                    SizedBox(height: 25.v),
                    _buildGenderColumn(context),
                    SizedBox(height: 5.v),
                    _buildStackCloseOne(context),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Change the color to white
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.5),
                    topRight: Radius.circular(30.5),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 12.v),
                child: CustomElevatedButton(
                  height: 48.v,
                  text: "Save Now",
                  buttonTextStyle: CustomTextStyles.titleSmallWhiteA700SemiBold,
                  onPressed: () => _updateUserData(context),
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
              child: CustomTextFormField(
                controller: nameController,
                textInputAction: TextInputAction.done,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 21.h, vertical: 19.v),
                textStyle: TextStyle(color: Color(0xFF1A1D1E)),
              ),
            ),
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
              child: CustomTextFormField(
                controller: emailController,
                readOnly: true,
                textInputAction: TextInputAction.done,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 21.h, vertical: 19.v),
                textStyle: TextStyle(color: Color(0xFF1A1D1E)),
              ),
            ),
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
              child: GestureDetector(
                onTap: () async {
                  var datePicked = await DatePicker.showSimpleDatePicker(
                    context,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                    dateFormat: "dd-MMMM-yyyy",
                    locale: DateTimePickerLocale.en_us,
                    looping: true,
                  );

                  if (datePicked != null) {
                    setState(() {
                      dateOfBirthController.text =
                          "${datePicked.day}-${datePicked.month}-${datePicked.year}";
                    });
                  }
                },
                child: AbsorbPointer(
                  child: CustomTextFormField(
                    controller: dateOfBirthController,
                    textInputAction: TextInputAction.done,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 21.h, vertical: 19.v),
                    textStyle: TextStyle(color: Color(0xFF1A1D1E)),
                  ),
                ),
              ),
            ),
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
            padding: EdgeInsets.only(left: 10.h),
            child: Row(
              children: [
                Expanded(
                  child: CustomDropDown(
                      icon: Container(
                        margin: EdgeInsets.symmetric(horizontal: 17.h),
                        child: CustomImageView(
                          imagePath: ImageConstant.imgArrowdown,
                          height: 7.v,
                          width: 13.h,
                        ),
                      ),
                      hintText: selectedGender,
                      textStyle: TextStyle(color: Color(0xFF1A1D1E)),
                      items: genderdropdownItemList,
                      onChanged: (String? value) {
                        setState(() {
                          selectedGender = value;
                        });
                      }),
                ),
              ],
            ),
          )
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
            padding: EdgeInsets.only(left: 10.h),
            child: Row(
              children: [
                Expanded(
                  child: CustomDropDown(
                      icon: Container(
                        margin: EdgeInsets.symmetric(horizontal: 17.h),
                        child: CustomImageView(
                          imagePath: ImageConstant.imgArrowdown,
                          height: 7.v,
                          width: 13.h,
                        ),
                      ),
                      hintText: selectedNationality,
                      textStyle: TextStyle(color: Color(0xFF1A1D1E)),
                      items: nationalityDropDownList,
                      onChanged: (String? value) {
                        setState(() {
                          selectedNationality = value;
                        });
                      }),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _getUserData() async {
    try {
      // Fetch user data from Firestore
      DocumentSnapshot<Map<String, dynamic>> snapshot = await firestore
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .get();

      // Extract data from snapshot
      Map<String, dynamic> userData = snapshot.data() ?? {};

      setState(() {
        // Set data to variables
        username = userData['username'];
        nameController.text = userData['username'] ?? '';
        emailController.text = userData['email'] ?? '';
        dateOfBirthController.text = userData['dateOfBirth'] ?? '';
        identityNumberController.text = userData['IdentityNum'] ?? '';
        selectedGender = userData['gender'] != null
            ? userData['gender'].toString().substring(0, 1).toUpperCase() +
                userData['gender'].toString().substring(1)
            : genderdropdownItemList[0];
        selectedNationality = userData['Nationality'] ?? '';
        profileImageUrl = userData['profileImageUrl'];
      });
    } catch (e) {
      print('Error retrieving user data: $e');
    }
  }

  Future<String?> _uploadImage(File imageFile) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('profile_pictures/${user.uid}');
        UploadTask uploadTask = storageReference.putFile(imageFile);
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        return downloadUrl;
      }
    } catch (e) {
      print("Error uploading image: $e");
    }
    return null;
  }

  void _updateUserData(BuildContext context) async {
  if (_isUpdating) {
    return;
  }

  setState(() {
    _isUpdating = true;
  });
  RegExp digitRegex = RegExp(r'^[0-9]+$');

  if (nameController.text.isEmpty) {
    ElegantNotification.error(
      width: 360,
      isDismissable: false,
      animation: AnimationType.fromTop,
      title: Text("Error"),
      description: Text("Name cannot be empty"),
    ).show(context);
    setState(() {
      _isUpdating = false;
    });
    return;
  } else if (dateOfBirthController.text.isEmpty) {
    ElegantNotification.error(
      width: 360,
      isDismissable: false,
      animation: AnimationType.fromTop,
      title: Text("Error"),
      description: Text("Date of birth cannot be empty"),
    ).show(context);
    setState(() {
      _isUpdating = false;
    });
    return;
  } else if (identityNumberController.text.isEmpty) {
    ElegantNotification.error(
      width: 360,
      isDismissable: false,
      animation: AnimationType.fromTop,
      title: Text("Error"),
      description: Text("Identity number cannot be empty"),
    ).show(context);
    setState(() {
      _isUpdating = false;
    });
    return;
  } else if (identityNumberController.text.length != 12) {
    ElegantNotification.error(
      width: 360,
      isDismissable: false,
      animation: AnimationType.fromTop,
      title: Text("Error"),
      description: Text("Identity number must be 12 digits long"),
    ).show(context);
    setState(() {
      _isUpdating = false;
    });
    return;
  } else if (identityNumberController.text.contains('-')) {
    ElegantNotification.error(
      width: 360,
      isDismissable: false,
      animation: AnimationType.fromTop,
      title: Text("Error"),
      description: Text("Do not include - in your identity number"),
    ).show(context);
    setState(() {
      _isUpdating = false;
    });
    return;
  } else if (selectedGender == null) {
    ElegantNotification.error(
      width: 360,
      isDismissable: false,
      animation: AnimationType.fromTop,
      title: Text("Error"),
      description: Text("Gender cannot be empty"),
    ).show(context);
    setState(() {
      _isUpdating = false;
    });
    return;
  } else if (!digitRegex.hasMatch(identityNumberController.text)) {
    ElegantNotification.error(
      width: 360,
      isDismissable: false,
      animation: AnimationType.fromTop,
      title: Text("Error"),
      description: Text("Identity number must contain only digits."),
    ).show(context);
    setState(() {
      _isUpdating = false;
    });
    return;
  }

  // Reference to the Firestore collection
  CollectionReference user = firestore.collection('user');

  String? imageUrl;
  if (_image != null) {
    imageUrl = await _uploadImage(File(_image!.path));
  }

  try {
    await user.doc(FirebaseAuth.instance.currentUser!.email).update({
      'username': nameController.text,
      'dateOfBirth': dateOfBirthController.text,
      'IdentityNum': identityNumberController.text.toString(),
      'gender': selectedGender,
      'Nationality': selectedNationality,
      if (imageUrl != null) 'profileImageUrl': imageUrl,
    });

    // Handle success
    print("User data updated successfully!");
    setState(() {
      username = nameController.text;
    });

    // Show success notification
    ElegantNotification.success(
      width: 360,
      isDismissable: false,
      animation: AnimationType.fromTop,
      title: Text('Profile Updated'),
      description: Text('Your profile has been updated'),
      onDismiss: () {},
      onNotificationPressed: () {},
      shadow: BoxShadow(
        color: Colors.green.withOpacity(0.2),
        spreadRadius: 2,
        blurRadius: 5,
        offset: const Offset(0, 4),
      ),
    ).show(context);
  } catch (error) {
    // Handle error
    print("Failed to update user data: $error");

    // Show error notification
    ElegantNotification.error(
      title: Text("Update Failed"),
      description: Text("Failed to update profile. Please try again."),
    ).show(context);
  } finally {
    setState(() {
      _isUpdating = false;
    });
  }
}


  void _pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
      });
    }
  }

  /// Navigates back to the previous screen.
  void onTapArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }
}
