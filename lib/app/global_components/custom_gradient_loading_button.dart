// import 'package:flutter/material.dart';

// import '../utils/colors.dart';
// import '../utils/responsive.dart';

// class CustomGradientLoadingButton extends StatelessWidget {
//   const CustomGradientLoadingButton({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         width: Responsive.getWidth(context),
//         padding:
//             const EdgeInsetsDirectional.symmetric(vertical: 12, horizontal: 12),
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [
//               BUTTON_GRADIENT_FIRST_COLOR,
//               BUTTON_GRADIENT_SECOND_COLOR,
//             ],
//             begin: Alignment.centerLeft,
//             end: Alignment.centerRight,
//           ),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: const Center(
//           child: SizedBox(
//             height: 24,
//             width: 24,
//             child:
//                 CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
//           ),
//         ));
//   }
// }
