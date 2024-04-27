import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../core/app_export.dart';
import '../../../../widgets/custom_icon_button.dart'; // ignore: must_be_immutable

class UserprofileItemWidget extends StatelessWidget {
  const UserprofileItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return SizedBox(
            width: 370.h,
            child: ListView.separated(
              padding: EdgeInsets.only(left: 20.h),
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 20.h,
                );
              },
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> data = snapshot.data![index];
                String jobTitle = data['JobTitle'];
                int salary = data['SalaryPerHours'];
                String location = data['Location'];
                String title = data['Title'];
                int workingHours = data['WorkingHours'];

                return SizedBox(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: EdgeInsets.all(10.h),
                      decoration: AppDecoration.outlineBlack900.copyWith(
                        borderRadius: BorderRadiusStyle.roundedBorder20,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 40.adaptSize,
                                width: 40.adaptSize,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    13.h,
                                  ),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      ImageConstant.imgRectangle515,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 157.h,
                                  top: 5.v,
                                  bottom: 7.v,
                                ),
                                child: CustomIconButton(
                                  height: 28.adaptSize,
                                  width: 28.adaptSize,
                                  padding: EdgeInsets.all(6.h),
                                  child: CustomImageView(
                                    imagePath: ImageConstant.imgFavorite,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 3.v),
                          Text(
                            "$title",
                            style: theme.textTheme.bodySmall,
                          ),
                          SizedBox(height: 11.v),
                          Text(
                            "$jobTitle",
                            style: theme.textTheme.titleMedium,
                          ),
                          SizedBox(height: 8.v),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 1.v),
                                child: Text(
                                  "RM$salary/$workingHours",
                                  style: CustomTextStyles.labelLargeGray900,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 60.h),
                                child: Text(
                                  "$location",
                                  style: theme.textTheme.bodySmall,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 5.v)
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }

  Future<List<Map<String, dynamic>>> fetchData() async {
    List<Map<String, dynamic>> dataList = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('ClientJobList').get();

    querySnapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      dataList.add(data);
    });

    return dataList;
  }
}
