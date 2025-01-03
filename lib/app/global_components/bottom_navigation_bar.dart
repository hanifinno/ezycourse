// import 'package:flutter/material.dart';
// import 'package:get/get.dart';


// import '../config/app_assets.dart';
// import '../routes/app_pages.dart';


// class CustomBottomNavigationBar extends StatefulWidget {
//   final int currentIndex;
//   final Function(int) onTap;

//   const CustomBottomNavigationBar({
//     super.key,
//     required this.currentIndex,
//     required this.onTap,
//   });

//   @override
//   State<CustomBottomNavigationBar> createState() =>
//       _CustomBottomNavigationBarState();
// }

// class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
//   List<Widget> inactiveItemList = const [
//     InactiveItem(icon: AppAssets.HOME_ICON),
//     InactiveItem(icon: AppAssets.NOTICE_ICON),
//     InactiveItem(icon: AppAssets.SIGNAL_ICON),
//     InactiveItem(icon: AppAssets.USER_ICON),
//   ];

//   List<Widget> activeItemList = const [
//     ActiveItem(icon: AppAssets.HOME_ICON, label: 'Home'),
//     ActiveItem(icon: AppAssets.NOTICE_ICON, label: 'Notices'),
//     ActiveItem(icon: AppAssets.SIGNAL_ICON, label: 'Signals'),
//     ActiveItem(icon: AppAssets.USER_ICON, label: 'Profile'),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       physics: const ClampingScrollPhysics(),
//       child: Container(
//           width: Responsive.getWidth(context),
//           padding: const EdgeInsetsDirectional.symmetric(
//               vertical: 8, horizontal: 16),
//           decoration: BoxDecoration(
//             gradient: CustomGradient.getCustomGradient(
//               colors: [
//                 const Color(0xFF6E00B8), // First color
//                 const Color(0xFFC400E8), // Second color
//                 const Color(0xFF310052), // Third color
//               ],
//               stops: [0.0, 0.5, 1.0], // Stops for color transition
//             ),
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(10), // Apply border radius to top-left
//               topRight: Radius.circular(10), // Apply border radius to top-right
//             ),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: List.generate(inactiveItemList.length, (index) {
//               return IconButton(
//                 onPressed: () => changeIndex(index),
//                 icon: index == widget.currentIndex
//                     ? activeItemList[index]
//                     : inactiveItemList[index],
//               );
//             }),
//           )),
//     );
//   }

//   changeIndex(int index) {
//     switch (index) {
//       case 0:
//         // Home Icon (can be your home screen if needed)
//         Get.offNamed(Routes.HOME);
//         break;
//       case 1:
//         // Notice Icon - Navigate to NoticeListView
//         Get.offNamed(Routes.NOTICE);
//         break;
//       case 2:
//         // Signal Icon - Navigate to SignalsListView
//         Get.offNamed(Routes.SIGNAL_DETAILS_LIST);
//         break;
//       case 3:
//         // Profile Icon - Navigate to ProfileView
//         Get.offNamed(Routes.PROFILE);
//         break;
//     }

//     // You can call the onTap function as well if needed for external state management.
//     widget.onTap(index);
//   }
// }

// class InactiveItem extends StatelessWidget {
//   final String icon;
//   const InactiveItem({required this.icon, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Image.asset(
//       icon,
//       height: 24, // You can adjust the size as needed
//       width: 24,
//     );
//   }
// }

// class ActiveItem extends StatelessWidget {
//   final String icon;
//   final String label;
//   const ActiveItem({required this.icon, required this.label, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Image.asset(
//           icon,
//           height: 24, // Adjust the active icon size as well
//           width: 24,
//         ),
//         const SizedBox(height: 4),
//         Text(
//           label,
//           textAlign: TextAlign.center,
//           style: const TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w400,
//               fontFamily: 'Inter',
//               color: Colors.white),
//         ) // Small gap between icon and label
//       ],
//     );
//   }
// }
