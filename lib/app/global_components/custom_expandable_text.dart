// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:learning_management_system_flutter/app/modules/course_details/controllers/course_details_controller.dart';
// import 'package:learning_management_system_flutter/app/utils/colors.dart';
// import 'package:expandable_text/expandable_text.dart';

// class CustomExpandableText extends StatelessWidget {
//   final String text;
//   final int maxLength;

//   CustomExpandableText({required this.text, this.maxLength = 100});

//   @override
//   Widget build(BuildContext context) {
//     // Use Obx to listen to the isExpanded state reactively
//     return Obx(() {
//       final controller = Get.find<CourseDetailsController>(); // Get the controller

//       String displayText = controller.isExpanded.value
//           ? text
//           : text.length > maxLength
//               ? text.substring(0, maxLength) + '...'
//               : text;

//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Flexible(
//                 child: Text(
//                   displayText,
//                   maxLines: 2,
//                   textAlign: TextAlign.justify,
//                   softWrap: true,
//                   style: const TextStyle(
//                     fontSize: 15,
//                     color: Colors.white,
//                     fontWeight: FontWeight.normal,
//                   ),
//                 ),
//               ),
//               if (text.length > maxLength)
//                 TextButton(
//                   onPressed: () {
//                     controller.toggleExpansion();
//                   },
//                   child: Text(
//                     controller.isExpanded.value ? 'Read Less' : 'Read More',
//                     style: const TextStyle(color: GREEN_COLOR),
//                   ),
//                 ),
//             ],
//           ),
//         ],
//       );
//     });
//   }
// }
