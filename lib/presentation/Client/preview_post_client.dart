// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:intl/intl.dart';

// Future showBottomSheetPreviewPost(BuildContext context) {
//   return showModalBottomSheet(
//     isScrollControlled: true,
//     context: context,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(
//         top: Radius.circular(20),
//       ),
//     ),
//     clipBehavior: Clip.antiAlias,
//     builder: (BuildContext context) {
//       final Size screenSize = MediaQuery.of(context).size;

//       return StatefulBuilder(
//         builder: (context, setState) {
//           return Container(
//             color: Colors.white,
//             height: screenSize.height * 0.95,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Container(
//                   margin: EdgeInsets.only(bottom: 12),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Color(0xffB3BAC3).withOpacity(0.25),
//                         spreadRadius: 0,
//                         blurRadius: 4,
//                         offset: Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.only(top: 10, right: 20, bottom: 0, left: 20),
//                     child: Column(
//                       children: [],
//                     ),
//                   ),
//                 ),
//                 Spacer(),
//                 Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Color(0xffB3BAC3).withOpacity(0.25),
//                           spreadRadius: 0,
//                           blurRadius: 4,
//                           offset: Offset(0, -4),
//                         ),
//                       ],
//                     ),
//                     height: 100,
//                     child: Align(
//                       alignment: FractionalOffset.bottomCenter,
//                       child: Container(
//                         child: Center(
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 16),
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: ElevatedButton(
//                                     onPressed: () {
//                                       Navigator.pop(context);
//                                     },
//                                     style: ButtonStyle(
//                                       elevation: MaterialStatePropertyAll(0),
//                                       shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(15),
//                                       )),
//                                       backgroundColor: MaterialStatePropertyAll(Colors.transparent),
//                                     ),
//                                     child: Padding(
//                                       padding: EdgeInsets.symmetric(vertical: 14),
//                                       child: Text(
//                                         "Edit",
//                                         style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xffC2C2C2)),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 20,
//                                 ),
//                                 Expanded(
//                                   child: ElevatedButton(
//                                     onPressed: () {
//                                     submitJobPost();

//                                     },
//                                     style: ButtonStyle(
//                                       elevation: MaterialStatePropertyAll(0),
//                                       shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(15),
//                                       )),
//                                       backgroundColor: MaterialStatePropertyAll(Color(0xff5598FF)),
//                                     ),
//                                     child: Padding(
//                                       padding: EdgeInsets.symmetric(vertical: 14),
//                                       child: Text(
//                                         "Post",
//                                         style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ))
//               ],
//             ),
//           );
//         },
//       );
//     },
//   );
// }

