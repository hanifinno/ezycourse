// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:quantum_possibilities_flutter/app/modules/NAVIGATION_MENUS/user_menu/sub_menus/all_groups/group_profile/components/custom_report_bottomsheet.dart';
// import '../../post_tag_list.dart';
// import '../../../modules/NAVIGATION_MENUS/user_menu/sub_menus/all_pages/admin_page/controller/admin_page_controller.dart';
// import '../../../config/api_constant.dart';
// import '../../../config/app_assets.dart';
// import '../../../data/login_creadential.dart';
// import '../../../models/post.dart';
// import '../../../models/user.dart';
// import '../../../models/user_id.dart';
// import '../../../modules/NAVIGATION_MENUS/home/controllers/home_controller.dart';
// import '../../../routes/app_pages.dart';
// import '../../../utils/color.dart';
// import '../../../utils/image.dart';
// import '../../../utils/post_utlis.dart';
// import '../../image.dart';

// class PagePostHeader extends StatelessWidget {
//   final PostModel model;
//   final VoidCallback? onTapEditPost;

//   final VoidCallback? onTapBookMarkPost;
//   final VoidCallback? onTapRemoveBookMarkPost;
//   final VoidCallback? onTapCopyPost;
//   final VoidCallback? onTapViewPostHistory;
//   final VoidCallback? onTapPinPost;
//   final String? viewType;

//   PagePostHeader(
//       {super.key,
//       required this.model,
//       this.onTapEditPost,
//       this.onTapBookMarkPost,
//       this.onTapCopyPost,
//       this.onTapViewPostHistory,
//       this.viewType = 'PagePost',
//       this.onTapPinPost,
//       this.onTapRemoveBookMarkPost});

//   RxString character = 'spam'.obs;

//   TextEditingController reportDescription = TextEditingController();

//   HomeController homeController = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     UserIdModel userModel = model.user_id ?? UserIdModel();
//     UserModel currentUserModel = LoginCredential().getUserData();
//     return Container(
//       padding: const EdgeInsets.only(top: 10),
//       child: InkWell(
//         onTap: () {
//           if (model.post_type == 'Shared' &&
//               model.share_post_id?.post_type == 'campaign') {
//             Get.toNamed(Routes.PAGE_PROFILE,
//                 arguments:
//                     model.share_post_id?.adProduct?.pageInfo?.pageUserName);
//           } else {
//             Get.toNamed(Routes.PAGE_PROFILE,
//                 arguments: model.page_id?.pageUserName);
//           }
//         },
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(width: 10),
//             model.post_type == 'Shared' &&
//                     model.share_post_id?.post_type == 'campaign'
//                 ? RoundCornerNetworkImage(
//                     imageUrl: getFormatedPageProfileUrl(
//                       model.share_post_id?.adProduct?.pageInfo?.profilePic ??
//                           '',
//                     ),
//                   )
//                 : model.post_type == 'Shared'
//                     ? RoundCornerNetworkImage(
//                         imageUrl: getFormatedPageProfileUrl(
//                           model.share_post_id?.page_id?.profilePic ?? '',
//                         ),
//                       )
//                     : RoundCornerNetworkImage(
//                         imageUrl: getFormatedPageProfileUrl(
//                           model.page_id?.profilePic ?? '',
//                         ),
//                       ),
//             const SizedBox(width: 10),
//             Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   RichText(
//                     text: TextSpan(children: [
//                       model.post_type == 'Shared' &&
//                               model.share_post_id?.post_type == 'campaign'
//                           ? TextSpan(
//                               text:
//                                   '${model.share_post_id?.adProduct?.pageInfo?.pageName}',
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                                 color: Colors.black,
//                               ),
//                             )
//                           : TextSpan(
//                               children: [
//                                 TextSpan(
//                                   text: '${model.page_id?.pageName}',
//                                   style: const TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 16,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 TextSpan(
//                                     text: ' ${getHeaderTextAsPostType(model)}',
//                                     style: TextStyle(
//                                         color: Colors.grey.shade700,
//                                         fontSize: 16))
//                               ],
//                             ),
//                       TextSpan(children: [
//                         // model.share_post_id?.feeling_id != null
//                         // model.post_type == "Shared"
//                         model.feeling_id != null
//                             ? TextSpan(children: [
//                                 TextSpan(
//                                     children: [
//                                       const TextSpan(
//                                           text: ' is feeling',
//                                           style: TextStyle(
//                                               color: Colors.black,
//                                               fontWeight: FontWeight.w500,
//                                               fontSize: 16)),
//                                       WidgetSpan(
//                                           child: Padding(
//                                         padding:
//                                             const EdgeInsets.only(left: 3.0),
//                                         child: ReactionIcon(
//                                             model.feeling_id!.logo.toString()),
//                                       )),
//                                       TextSpan(
//                                           text:
//                                               ' ${model.feeling_id!.feelingName}',
//                                           style: const TextStyle(
//                                             color: Colors.black,
//                                             fontWeight: FontWeight.w500,
//                                             fontSize: 16,
//                                           )),
//                                     ],
//                                     style: const TextStyle(
//                                         color: Colors.black, fontSize: 16)),
//                               ])
//                             : TextSpan(
//                                 text: '',
//                                 style: TextStyle(
//                                     color: Colors.grey.shade700, fontSize: 16)),
//                         TextSpan(
//                             text: getLocationText(model),
//                             style: const TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 16)),
//                         TextSpan(
//                             text: getTagText(model),
//                             recognizer: TapGestureRecognizer()
//                               ..onTap = () {
//                                 Get.to(() => PostTagList(
//                                       postModel: model,
//                                     ));
//                               },
//                             style: const TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 16))
//                       ]),
//                     ]),
//                   ),
//                   const SizedBox(height: 4),
//                   model.post_type == 'Shared'
//                       ? Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text(
//                                 '${getDynamicFormatedTime(model.share_post_id?.createdAt ?? '')} '),
//                             Text(
//                               getTextAsPostType(
//                                   model.share_post_id?.post_type ?? ''),
//                               style:
//                                   const TextStyle(fontWeight: FontWeight.w500),
//                             ),
//                             Icon(
//                               getIconAsPrivacy(
//                                   model.share_post_id?.post_privacy ?? ''),
//                               size: 17,
//                             )
//                           ],
//                         )
//                       : Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text(
//                                 '${getDynamicFormatedTime(model.createdAt ?? '')} '),
//                             Text(
//                               getTextAsPostType(model.post_type ?? ''),
//                               style:
//                                   const TextStyle(fontWeight: FontWeight.w500),
//                             ),
//                             Icon(
//                               getIconAsPrivacy(model.post_privacy ?? ''),
//                               size: 17,
//                             )
//                           ],
//                         ),
//                 ],
//               ),
//             ),

//             // =========================================================== Three Dot Icon ===========================================================

//             model.isBookMarked == true
//                 ? const Padding(
//                     padding: EdgeInsets.only(top: 12.0),
//                     child: Icon(
//                       Icons.bookmark,
//                     ),
//                   )
//                 : Container(),
//             model.post_type == 'Shared' &&
//                     model.share_post_id?.post_type == 'campaign'
//                 ? const SizedBox()
//                 : model.user_id?.id == currentUserModel.id
//                     ? IconButton(
//                         onPressed: () {
//                           Get.bottomSheet(Container(
//                             height:
//                                 viewType == 'profile' || viewType == 'PagePost'
//                                     ? 325
//                                     : viewType == 'bookmark'
//                                         ? 320
//                                         : 355,
//                             color: Colors.white,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children: [
//                                 viewType == 'profile' || viewType == 'PagePost'
//                                     ? InkWell(
//                                         onTap: onTapPinPost,
//                                         child: Padding(
//                                           padding:
//                                               const EdgeInsets.only(top: 10),
//                                           child: Row(
//                                             children: [
//                                               const Padding(
//                                                 padding:
//                                                     EdgeInsets.only(left: 14),
//                                                 child: Icon(
//                                                   Icons.push_pin,
//                                                   size: 20,
//                                                 ),
//                                               ),
//                                               Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 8),
//                                                 child: model.pinPost == false
//                                                     ? const Text(
//                                                         'Pin Post',
//                                                         style: TextStyle(
//                                                             fontWeight:
//                                                                 FontWeight.bold,
//                                                             fontSize: 15),
//                                                       )
//                                                     : const Text(
//                                                         'UnPin Post',
//                                                         style: TextStyle(
//                                                             fontWeight:
//                                                                 FontWeight.bold,
//                                                             fontSize: 15),
//                                                       ),
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                       )
//                                     : const SizedBox(),
//                                 const SizedBox(
//                                   height: 15,
//                                 ),
//                                 InkWell(
//                                   onTap: onTapEditPost,
//                                   child: const Padding(
//                                     padding: EdgeInsets.only(top: 10),
//                                     child: Row(
//                                       children: [
//                                         Padding(
//                                           padding: EdgeInsets.only(left: 14),
//                                           child: Icon(
//                                             Icons.edit,
//                                             size: 20,
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: EdgeInsets.only(left: 8),
//                                           child: Text(
//                                             'Edit Post',
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 15),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 viewType == 'bookmark'
//                                     ? Container()
//                                     : const SizedBox(
//                                         height: 15,
//                                       ),
//                                 model.isBookMarked == false
//                                     ? InkWell(
//                                         onTap: onTapBookMarkPost ?? () {},
//                                         child: const Padding(
//                                           padding: EdgeInsets.only(top: 10),
//                                           child: Row(
//                                             children: [
//                                               Padding(
//                                                 padding:
//                                                     EdgeInsets.only(left: 8),
//                                                 child: Icon(
//                                                   Icons.bookmark,
//                                                   size: 20,
//                                                 ),
//                                               ),
//                                               Padding(
//                                                 padding:
//                                                     EdgeInsets.only(left: 8),
//                                                 child: Text(
//                                                   'Book Mark',
//                                                   style: TextStyle(
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       fontSize: 15),
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                       )
//                                     : InkWell(
//                                         onTap: onTapRemoveBookMarkPost ?? () {},
//                                         child: const Padding(
//                                           padding: EdgeInsets.only(top: 10),
//                                           child: Row(
//                                             children: [
//                                               Padding(
//                                                 padding:
//                                                     EdgeInsets.only(left: 8),
//                                                 child: Icon(
//                                                   Icons.bookmark,
//                                                   size: 20,
//                                                 ),
//                                               ),
//                                               Padding(
//                                                 padding:
//                                                     EdgeInsets.only(left: 8),
//                                                 child: Text(
//                                                   'Remove Book Mark',
//                                                   style: TextStyle(
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       fontSize: 15),
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                 const SizedBox(
//                                   height: 15,
//                                 ),
//                                 InkWell(
//                                   onTap: () {
//                                     Get.back();
//                                     Get.toNamed(Routes.EDIT_HISTORY,
//                                         arguments: model.id);
//                                   },
//                                   child: const Padding(
//                                     padding: EdgeInsets.only(top: 10),
//                                     child: Row(
//                                       children: [
//                                         Padding(
//                                           padding: EdgeInsets.only(left: 8),
//                                           child: Icon(
//                                             Icons.edit_note,
//                                             size: 20,
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: EdgeInsets.only(left: 8),
//                                           child: Text(
//                                             'Edit History',
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 15),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 15,
//                                 ),
//                                 const InkWell(
//                                   child: Padding(
//                                     padding: EdgeInsets.only(top: 10),
//                                     child: Row(
//                                       children: [
//                                         Padding(
//                                           padding: EdgeInsets.only(left: 8),
//                                           child: Icon(
//                                             Icons.notification_add,
//                                             size: 20,
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: EdgeInsets.only(left: 8),
//                                           child: Text(
//                                             'Turn off notification',
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 15),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 15,
//                                 ),
//                                 InkWell(
//                                   onTap: onTapCopyPost,
//                                   child: const Padding(
//                                     padding: EdgeInsets.only(top: 10),
//                                     child: Row(
//                                       children: [
//                                         Padding(
//                                           padding: EdgeInsets.only(left: 8),
//                                           child: Icon(
//                                             Icons.link_off,
//                                             size: 20,
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: EdgeInsets.only(left: 8),
//                                           child: Text(
//                                             'Copy link',
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 15),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 15,
//                                 ),
//                                 InkWell(
//                                   onTap: () async {
//                                     await showDialog(
//                                       context: context,
//                                       builder: (context) => AlertDialog(
//                                         content: SizedBox(
//                                           height: 220,
//                                           child: Column(
//                                             mainAxisSize: MainAxisSize.min,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.start,
//                                             children: [
//                                               const SizedBox(
//                                                 height: 20,
//                                               ),
//                                               const Image(
//                                                 height: 50,
//                                                 width: 50,
//                                                 fit: BoxFit.cover,
//                                                 image: AssetImage(
//                                                     AppAssets.DELETE__ICON),
//                                               ),
//                                               const Text(
//                                                 'Delete Post',
//                                                 style: TextStyle(
//                                                     fontWeight: FontWeight.w900,
//                                                     fontSize: 20),
//                                               ),
//                                               const Text(
//                                                   'Are you sure you want to delete this post ?'),
//                                               const Text(
//                                                   'This action cannot be undone.'),
//                                               const SizedBox(
//                                                 height: 20,
//                                               ),
//                                               Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceAround,
//                                                 children: [
//                                                   ElevatedButton(
//                                                     style: ElevatedButton
//                                                         .styleFrom(
//                                                       backgroundColor:
//                                                           Colors.white,
//                                                       side: const BorderSide(
//                                                           color: Colors.grey,
//                                                           width: 1),
//                                                       // shadowColor: Colors.greenAccent,
//                                                       shape:
//                                                           RoundedRectangleBorder(
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(
//                                                           10,
//                                                         ),
//                                                       ),
//                                                       minimumSize: const Size(
//                                                           100,
//                                                           40), //////// HERE
//                                                     ),
//                                                     onPressed: () async {
//                                                       Navigator.of(context)
//                                                           .pop(false);
//                                                       Get.back();
//                                                     },
//                                                     child: const Text(
//                                                       'Cancel',
//                                                       style: TextStyle(
//                                                           fontSize: 14,
//                                                           color: Colors.black,
//                                                           fontWeight:
//                                                               FontWeight.w500),
//                                                     ),
//                                                   ),
//                                                   ElevatedButton(
//                                                     style: ElevatedButton
//                                                         .styleFrom(
//                                                       backgroundColor:
//                                                           Colors.red,
//                                                       shape:
//                                                           RoundedRectangleBorder(
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(
//                                                           10,
//                                                         ),
//                                                       ),
//                                                       minimumSize: const Size(
//                                                           100,
//                                                           40), //////// HERE
//                                                     ),
//                                                     onPressed: () {
//                                                       AdminPageController
//                                                           controller = Get.put(
//                                                               AdminPageController());
//                                                       HomeController
//                                                           homeController =
//                                                           Get.put(
//                                                               HomeController());
//                                                       controller.deletePost(
//                                                           model.id.toString());
//                                                       Get.back();
//                                                       Navigator.of(context)
//                                                           .pop(false);
//                                                       controller.postList.value
//                                                           .removeWhere((element) =>
//                                                               element.id ==
//                                                               model.id
//                                                                   .toString());
//                                                       homeController
//                                                           .postList.value
//                                                           .removeWhere((element) =>
//                                                               element.id ==
//                                                               model.id
//                                                                   .toString());
//                                                       controller.postList
//                                                           .refresh();
//                                                       homeController.postList
//                                                           .refresh();
//                                                     },
//                                                     child: const Text(
//                                                       'Delete',
//                                                       style: TextStyle(
//                                                         fontSize: 14,
//                                                         color: Colors.white,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                   child: const Padding(
//                                     padding: EdgeInsets.only(top: 10),
//                                     child: Row(
//                                       children: [
//                                         Padding(
//                                           padding: EdgeInsets.only(left: 8),
//                                           child: Icon(
//                                             Icons.delete,
//                                             size: 20,
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: EdgeInsets.only(left: 8),
//                                           child: Text(
//                                             'Delete',
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 15),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                               ],
//                             ),
//                           ));
//                         },
//                         icon: const Icon(Icons.more_vert))

//                     //  :
//                     : IconButton(
//                         onPressed: () {
//                           Get.bottomSheet(Container(
//                             height: 250,
//                             color: Colors.white,
//                             child: Column(
//                               children: [
//                                 const SizedBox(
//                                   height: 15,
//                                 ),
//                                 viewType == 'bookmark'
//                                     ? Container()
//                                     : const SizedBox(
//                                         height: 15,
//                                       ),
//                                 const SizedBox(
//                                   height: 15,
//                                 ),
//                                 model.isBookMarked == false
//                                     ? InkWell(
//                                         onTap: onTapBookMarkPost ?? () {},
//                                         child: const Padding(
//                                           padding: EdgeInsets.only(top: 10),
//                                           child: Row(
//                                             children: [
//                                               Padding(
//                                                 padding:
//                                                     EdgeInsets.only(left: 8),
//                                                 child: Icon(
//                                                   Icons.bookmark,
//                                                   size: 20,
//                                                 ),
//                                               ),
//                                               Padding(
//                                                 padding:
//                                                     EdgeInsets.only(left: 8),
//                                                 child: Text(
//                                                   'Book Mark',
//                                                   style: TextStyle(
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       fontSize: 15),
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                       )
//                                     : InkWell(
//                                         onTap: onTapRemoveBookMarkPost ?? () {},
//                                         child: const Padding(
//                                           padding: EdgeInsets.only(top: 10),
//                                           child: Row(
//                                             children: [
//                                               Padding(
//                                                 padding:
//                                                     EdgeInsets.only(left: 8),
//                                                 child: Icon(
//                                                   Icons.bookmark,
//                                                   size: 20,
//                                                 ),
//                                               ),
//                                               Padding(
//                                                 padding:
//                                                     EdgeInsets.only(left: 8),
//                                                 child: Text(
//                                                   'Remove Book Mark',
//                                                   style: TextStyle(
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       fontSize: 15),
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                 const SizedBox(
//                                   height: 15,
//                                 ),
//                                 const InkWell(
//                                   child: Padding(
//                                     padding: EdgeInsets.only(top: 10),
//                                     child: Row(
//                                       children: [
//                                         Padding(
//                                           padding: EdgeInsets.only(left: 8),
//                                           child: Icon(
//                                             Icons.notification_add,
//                                             size: 20,
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: EdgeInsets.only(left: 8),
//                                           child: Text(
//                                             'Turn off notification',
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 15),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 15,
//                                 ),
//                                 InkWell(
//                                   onTap: onTapCopyPost,
//                                   child: const Padding(
//                                     padding: EdgeInsets.only(top: 10),
//                                     child: Row(
//                                       children: [
//                                         Padding(
//                                           padding: EdgeInsets.only(left: 8),
//                                           child: Icon(
//                                             Icons.link_off,
//                                             size: 20,
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: EdgeInsets.only(left: 8),
//                                           child: Text(
//                                             'Copy link',
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 15),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 15,
//                                 ),
//                                 InkWell(
//                                   onTap:() async{
//                                       await homeController.getReports();
//                                             CustomReportBottomSheet
//                                                 .showReportOptions(
//                                               pageReportList: homeController
//                                                   .pageReportList.value,
//                                               selectedReportType: homeController
//                                                   .selectedReportType,
//                                               selectedReportId: homeController
//                                                   .selectedReportId,
//                                               reportDescription: homeController
//                                                   .reportDescription,
//                                               onCancel: () {
//                                                 Get.back();
//                                               },
//                                               reportAction:
//                                                   (String report_type_id,
//                                                       String report_type,
//                                                       String page_id,
//                                                       String description) {
//                                                 homeController.reportAPost(
//                                                     report_type: report_type,
//                                                     description: description,
//                                                     post_id: model.id ?? '',
//                                                     report_type_id:
//                                                         report_type_id);
//                                               },
//                                             );
//                                   },
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(top: 10),
//                                     child: Row(
//                                       children: [
//                                         const Padding(
//                                           padding: EdgeInsets.only(left: 10.0),
//                                           child: Icon(Icons.report_outlined),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.only(left: 8),
//                                           child: GestureDetector(
//                                             onTap: () async {
//                                               ////////////////////report/////////////////////////////////////////////////
//                                               // await homeController.getReports();
//                                               // CustomReportBottomSheet
//                                               //     .showReportOptions(
//                                               //   pageReportList: homeController
//                                               //       .pageReportList.value,
//                                               //   selectedReportType: homeController
//                                               //       .selectedReportType,
//                                               //   selectedReportId: homeController
//                                               //       .selectedReportId,
//                                               //   reportDescription: homeController
//                                               //       .reportDescription,
//                                               //   onCancel: () {
//                                               //     Get.back();
//                                               //   },
//                                               //   reportAction:
//                                               //       (String report_type_id,
//                                               //           String report_type,
//                                               //           String page_id,
//                                               //           String description) {
//                                               //     homeController.reportAPost(
//                                               //         report_type: report_type,
//                                               //         description: description,
//                                               //         post_id: model.id ?? '',
//                                               //         report_type_id:
//                                               //             report_type_id);
//                                               //   },
//                                               // );
//                                               ////////////////report///////////////////////////////////////////////////
//                                             },
//                                             child: const Text(
//                                               'Report',
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 15,
//                                                   color: Colors.black),
//                                             ),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ));
//                         },
//                         icon: const Icon(Icons.more_vert)),

//             // IconButton(
//             //     onPressed: () {
//             //       Get.bottomSheet(Container(
//             //         height: 280,
//             //         color: Colors.white,
//             //         child: Column(
//             //           children: [
//             //             const SizedBox(
//             //               height: 15,
//             //             ),
//             //             const SizedBox(
//             //               height: 15,
//             //             ),
//             //             InkWell(
//             //               onTap: onTapHidePost ?? () {},
//             //               child: const Padding(
//             //                 padding: EdgeInsets.only(top: 10),
//             //                 child: Row(
//             //                   children: [
//             //                     Padding(
//             //                       padding: EdgeInsets.only(left: 8),
//             //                       child: Icon(
//             //                         Icons.hide_image,
//             //                         size: 20,
//             //                       ),
//             //                     ),
//             //                     Padding(
//             //                       padding: EdgeInsets.only(left: 8),
//             //                       child: Text(
//             //                         'Hide Post',
//             //                         style: TextStyle(
//             //                             fontWeight: FontWeight.bold,
//             //                             fontSize: 15),
//             //                       ),
//             //                     )
//             //                   ],
//             //                 ),
//             //               ),
//             //             ),
//             //             const SizedBox(
//             //               height: 15,
//             //             ),
//             //             InkWell(
//             //               onTap: onTapBookMarkPost ?? () {},
//             //               child: const Padding(
//             //                 padding: EdgeInsets.only(top: 10),
//             //                 child: Row(
//             //                   children: [
//             //                     Padding(
//             //                       padding: EdgeInsets.only(left: 8),
//             //                       child: Icon(
//             //                         Icons.bookmark,
//             //                         size: 20,
//             //                       ),
//             //                     ),
//             //                     Padding(
//             //                       padding: EdgeInsets.only(left: 8),
//             //                       child: Text(
//             //                         'Book Mark',
//             //                         style: TextStyle(
//             //                             fontWeight: FontWeight.bold,
//             //                             fontSize: 15),
//             //                       ),
//             //                     )
//             //                   ],
//             //                 ),
//             //               ),
//             //             ),
//             //             const SizedBox(
//             //               height: 15,
//             //             ),
//             //             const InkWell(
//             //               child: Padding(
//             //                 padding: EdgeInsets.only(top: 10),
//             //                 child: Row(
//             //                   children: [
//             //                     Padding(
//             //                       padding: EdgeInsets.only(left: 8),
//             //                       child: Icon(
//             //                         Icons.notification_add,
//             //                         size: 20,
//             //                       ),
//             //                     ),
//             //                     Padding(
//             //                       padding: EdgeInsets.only(left: 8),
//             //                       child: Text(
//             //                         'Turn off notification',
//             //                         style: TextStyle(
//             //                             fontWeight: FontWeight.bold,
//             //                             fontSize: 15),
//             //                       ),
//             //                     )
//             //                   ],
//             //                 ),
//             //               ),
//             //             ),
//             //             const SizedBox(
//             //               height: 15,
//             //             ),
//             //             InkWell(
//             //               onTap: onTapCopyPost ?? () {},
//             //               child: const Padding(
//             //                 padding: EdgeInsets.only(top: 10),
//             //                 child: Row(
//             //                   children: [
//             //                     Padding(
//             //                       padding: EdgeInsets.only(left: 8),
//             //                       child: Icon(
//             //                         Icons.link_off,
//             //                         size: 20,
//             //                       ),
//             //                     ),
//             //                     Padding(
//             //                       padding: EdgeInsets.only(left: 8),
//             //                       child: Text(
//             //                         'Copy link',
//             //                         style: TextStyle(
//             //                             fontWeight: FontWeight.bold,
//             //                             fontSize: 15),
//             //                       ),
//             //                     )
//             //                   ],
//             //                 ),
//             //               ),
//             //             ),
//             //             const SizedBox(
//             //               height: 15,
//             //             ),
//             //             Row(
//             //               children: [
//             //                 const Padding(
//             //                   padding: EdgeInsets.only(left: 8.0),
//             //                   child: Icon(Icons.report_outlined),
//             //                 ),
//             //                 Padding(
//             //                   padding: const EdgeInsets.only(left: 8),
//             //                   child: GestureDetector(
//             //                     onTap: () async {
//             //                       ////////////////////report/////////////////////////////////////////////////

//             //                       Get.bottomSheet(
//             //                         SizedBox(
//             //                           height: Get.height / 1.8,
//             //                           child: Column(
//             //                             children: [
//             //                               Container(
//             //                                 margin: const EdgeInsets.symmetric(
//             //                                     vertical: 10),
//             //                                 child: const Text(
//             //                                   'Report',
//             //                                   style: TextStyle(
//             //                                       fontSize: 16,
//             //                                       fontWeight: FontWeight.bold,
//             //                                       color: Colors.black),
//             //                                 ),
//             //                               ),
//             //                               Divider(
//             //                                 height: 1,
//             //                                 color: Colors.grey.shade300,
//             //                               ),
//             //                               Expanded(
//             //                                 child: ListView(
//             //                                   shrinkWrap: true,
//             //                                   physics: const ScrollPhysics(),
//             //                                   children: [
//             //                                     Obx(() => ListTile(
//             //                                           title: const Text('Spam'),
//             //                                           subtitle: const Text(
//             //                                               'It’s spam or violent'),
//             //                                           leading: Radio<String>(
//             //                                             value: 'spam',
//             //                                             groupValue:
//             //                                                 character.value,
//             //                                             onChanged:
//             //                                                 (String? value) {
//             //                                               character.value =
//             //                                                   value!;
//             //                                               // setState(() {
//             //                                               //   _character = value;
//             //                                               // });
//             //                                             },
//             //                                           ),
//             //                                         )),
//             //                                     Obx(() => ListTile(
//             //                                           title: const Text(
//             //                                               'False information'),
//             //                                           subtitle: const Text(
//             //                                               'If someone is in immediate danger'),
//             //                                           leading: Radio<String>(
//             //                                             value: 'false_info',
//             //                                             groupValue:
//             //                                                 character.value,
//             //                                             onChanged:
//             //                                                 (String? value) {
//             //                                               character.value =
//             //                                                   value!;
//             //                                               // setState(() {
//             //                                               //   _character = value;
//             //                                               // });
//             //                                             },
//             //                                           ),
//             //                                         )),
//             //                                     Obx(() => ListTile(
//             //                                           title:
//             //                                               const Text('Nudity'),
//             //                                           subtitle: const Text(
//             //                                               'It’s Sexual activity or nudity showing genitals'),
//             //                                           leading: Radio<String>(
//             //                                             value: 'nudity',
//             //                                             groupValue:
//             //                                                 character.value,
//             //                                             onChanged:
//             //                                                 (String? value) {
//             //                                               character.value =
//             //                                                   value!;
//             //                                               // setState(() {
//             //                                               //   _character = value;
//             //                                               // });
//             //                                             },
//             //                                           ),
//             //                                         )),
//             //                                     Obx(() => ListTile(
//             //                                           title: const Text(
//             //                                               'Something Else'),
//             //                                           subtitle: const Text(
//             //                                               'Fraud, scam, violence, hate speech etc. '),
//             //                                           leading: Radio<String>(
//             //                                             value: 'something_else',
//             //                                             groupValue:
//             //                                                 character.value,
//             //                                             onChanged:
//             //                                                 (String? value) {
//             //                                               character.value =
//             //                                                   value!;
//             //                                               // setState(() {
//             //                                               //   _character = value;
//             //                                               // });
//             //                                             },
//             //                                           ),
//             //                                         )),
//             //                                   ],
//             //                                 ),
//             //                               ),
//             //                               Row(
//             //                                 children: [
//             //                                   InkWell(
//             //                                     onTap: () {
//             //                                       Get.back();
//             //                                     },
//             //                                     child: Container(
//             //                                       alignment: Alignment.center,
//             //                                       height: 50,
//             //                                       width: Get.width / 2,
//             //                                       decoration: BoxDecoration(
//             //                                           border: Border.all(
//             //                                               color: Colors
//             //                                                   .grey.shade300,
//             //                                               width: 1)),
//             //                                       child: const Text(
//             //                                         'Cancel',
//             //                                         style: TextStyle(
//             //                                             fontSize: 16,
//             //                                             fontWeight:
//             //                                                 FontWeight.w500),
//             //                                       ),
//             //                                     ),
//             //                                   ),
//             //                                   InkWell(
//             //                                     onTap: () {
//             //                                       // Get.back();

//             //                                       Get.bottomSheet(
//             //                                         SizedBox(
//             //                                           height: Get.height / 1.8,
//             //                                           width: Get.width,
//             //                                           child: Column(
//             //                                             mainAxisAlignment:
//             //                                                 MainAxisAlignment
//             //                                                     .spaceBetween,
//             //                                             children: [
//             //                                               Container(
//             //                                                 margin:
//             //                                                     const EdgeInsets
//             //                                                         .symmetric(
//             //                                                         vertical:
//             //                                                             10),
//             //                                                 child: const Text(
//             //                                                   'Report',
//             //                                                   style: TextStyle(
//             //                                                       fontSize: 16,
//             //                                                       fontWeight:
//             //                                                           FontWeight
//             //                                                               .bold,
//             //                                                       color: Colors
//             //                                                           .black),
//             //                                                 ),
//             //                                               ),
//             //                                               Divider(
//             //                                                 height: 1,
//             //                                                 color: Colors
//             //                                                     .grey.shade300,
//             //                                               ),
//             //                                               Column(
//             //                                                 crossAxisAlignment:
//             //                                                     CrossAxisAlignment
//             //                                                         .start,
//             //                                                 children: [
//             //                                                   const Padding(
//             //                                                     padding: EdgeInsets
//             //                                                         .symmetric(
//             //                                                             horizontal:
//             //                                                                 8.0),
//             //                                                     child: Text(
//             //                                                       'Description',
//             //                                                       style: TextStyle(
//             //                                                           fontWeight:
//             //                                                               FontWeight
//             //                                                                   .w500,
//             //                                                           fontSize:
//             //                                                               14),
//             //                                                     ),
//             //                                                   ),
//             //                                                   Container(
//             //                                                     height:
//             //                                                         Get.height /
//             //                                                             2.9,
//             //                                                     padding:
//             //                                                         const EdgeInsets
//             //                                                             .all(8),
//             //                                                     margin: const EdgeInsets
//             //                                                         .symmetric(
//             //                                                         horizontal:
//             //                                                             20,
//             //                                                         vertical:
//             //                                                             10),
//             //                                                     decoration:
//             //                                                         BoxDecoration(
//             //                                                             border: Border.all(
//             //                                                                 color: Colors
//             //                                                                     .grey.shade300,
//             //                                                                 width:
//             //                                                                     1), //Colors.grey.withOpacity(0.1),width: 1),
//             //                                                             borderRadius:
//             //                                                                 BorderRadius.circular(10)),
//             //                                                     child:
//             //                                                         TextField(
//             //                                                       controller:
//             //                                                           reportDescription,
//             //                                                       maxLines: 8,
//             //                                                       decoration:
//             //                                                           const InputDecoration(
//             //                                                         border:
//             //                                                             InputBorder
//             //                                                                 .none,
//             //                                                         hintText:
//             //                                                             'Enter a description about your Report...',
//             //                                                       ),
//             //                                                     ),
//             //                                                   ),
//             //                                                 ],
//             //                                               ),
//             //                                               Row(
//             //                                                 children: [
//             //                                                   InkWell(
//             //                                                     onTap: () {
//             //                                                       Get.back();
//             //                                                     },
//             //                                                     child:
//             //                                                         Container(
//             //                                                       alignment:
//             //                                                           Alignment
//             //                                                               .center,
//             //                                                       height: 50,
//             //                                                       width:
//             //                                                           Get.width /
//             //                                                               2,
//             //                                                       decoration: BoxDecoration(
//             //                                                           border: Border.all(
//             //                                                               color: Colors
//             //                                                                   .grey
//             //                                                                   .shade300,
//             //                                                               width:
//             //                                                                   1)),
//             //                                                       child:
//             //                                                           const Text(
//             //                                                         'Back',
//             //                                                         style: TextStyle(
//             //                                                             fontSize:
//             //                                                                 16,
//             //                                                             fontWeight:
//             //                                                                 FontWeight.w500),
//             //                                                       ),
//             //                                                     ),
//             //                                                   ),
//             //                                                   InkWell(
//             //                                                     onTap: () {
//             //                                                       homeController.reportAPost(
//             //                                                           post_id:
//             //                                                               '${model.id}',
//             //                                                           report_type:
//             //                                                               character
//             //                                                                   .value,
//             //                                                           description:
//             //                                                               reportDescription
//             //                                                                   .text);
//             //                                                     },
//             //                                                     child:
//             //                                                         Container(
//             //                                                       alignment:
//             //                                                           Alignment
//             //                                                               .center,
//             //                                                       height: 50,
//             //                                                       width:
//             //                                                           Get.width /
//             //                                                               2,
//             //                                                       decoration: BoxDecoration(
//             //                                                           border: Border.all(
//             //                                                               color: Colors
//             //                                                                   .grey,
//             //                                                               width:
//             //                                                                   1),
//             //                                                           color:
//             //                                                               PRIMARY_COLOR
//             //                                                           //.withOpacity(0.7),
//             //                                                           ),
//             //                                                       child:
//             //                                                           const Text(
//             //                                                         'Report',
//             //                                                         style: TextStyle(
//             //                                                             fontSize:
//             //                                                                 16,
//             //                                                             fontWeight:
//             //                                                                 FontWeight
//             //                                                                     .w500,
//             //                                                             color: Colors
//             //                                                                 .white),
//             //                                                       ),
//             //                                                     ),
//             //                                                   ),
//             //                                                 ],
//             //                                               )
//             //                                             ],
//             //                                           ),
//             //                                         ),
//             //                                         backgroundColor:
//             //                                             Colors.white,
//             //                                         isScrollControlled: true,
//             //                                       );
//             //                                     },
//             //                                     child: Container(
//             //                                       alignment: Alignment.center,
//             //                                       height: 50,
//             //                                       decoration: BoxDecoration(
//             //                                         border: Border.all(
//             //                                             color: Colors
//             //                                                 .grey.shade300,
//             //                                             width: 0),
//             //                                         color: PRIMARY_COLOR,
//             //                                       ),
//             //                                       width: Get.width / 2,
//             //                                       child: const Text(
//             //                                         'Continue',
//             //                                         style: TextStyle(
//             //                                             fontSize: 16,
//             //                                             fontWeight:
//             //                                                 FontWeight.w500,
//             //                                             color: Colors.white),
//             //                                       ),
//             //                                     ),
//             //                                   ),
//             //                                 ],
//             //                               )
//             //                             ],
//             //                           ),
//             //                         ),
//             //                         backgroundColor: Colors.white,
//             //                         isScrollControlled: true,
//             //                       );

//             //                       ////////////////report///////////////////////////////////////////////////
//             //                     },
//             //                     child: const Text(
//             //                       'Report',
//             //                       style: TextStyle(
//             //                           fontWeight: FontWeight.bold,
//             //                           fontSize: 15,
//             //                           color: Colors.black),
//             //                     ),
//             //                   ),
//             //                 )
//             //               ],
//             //             )
//             //           ],
//             //         ),
//             //       ));
//             //     },
//             //     icon: const Icon(Icons.more_vert))
//           ],
//         ),
//       ),
//     );
//   }

//   getIconAsPrivacy(String postPrivacy) {
//     switch (postPrivacy) {
//       case 'public':
//         return Icons.public;
//       case 'only_me':
//         return Icons.lock;
//       case 'friends':
//         return Icons.group;
//       default:
//         return Icons.public;
//     }
//   }

//   String getTextAsPostType(String postType) {
//     switch (postType) {
//       case 'campaign':
//         return 'Sponsored ';

//       default:
//         return '';
//     }
//   }

//   String getHeaderTextAsPostType(PostModel postModel) {
//     switch (model.post_type) {
//       case 'timeline_post':
//         return '';
//       case 'page_post':
//         return '';
//       case 'profile_picture':
//         return 'updated a new profile picture';
//       case 'cover_picture':
//         return 'updated a new cover photo';
//       case 'event':
//         return '';
//       case 'shared_reels':
//         return '';
//       case 'birthday':
//         return '';
//       case 'campaign':
//         return '';
//       default:
//         return '';
//     }
//   }

//   String getFeelingText(PostModel postModel) {
//     return (model.feeling_id?.feelingName != null)
//         ? ' is feeling ${model.feeling_id?.feelingName}'
//         : '';
//   }

//   String getLocationText(PostModel postModel) {
//     return (postModel.locationName.toString().contains('null') ||
//             postModel.locationName.toString() == '')
//         ? ''
//         : ' at ${postModel.locationName}';
//   }

//   String getTagText(PostModel postModel) {
//     if (postModel.taggedUserList != null) {
//       if (postModel.taggedUserList!.length == 1) {
//         return ' with ${postModel.taggedUserList![0].user?.firstName ?? ''}';
//       } else if (postModel.taggedUserList!.length > 1) {
//         return ' with ${postModel.taggedUserList![0].user?.firstName ?? ''} and ${postModel.taggedUserList!.length - 1} others';
//       } else {
//         return '';
//       }
//     } else {
//       return '';
//     }
//   }

//   String getSharedHeaderTextAsPostType(PostModel postModel) {
//     switch (model.share_post_id!.post_type) {
//       case 'timeline_post':
//         return '';
//       case 'page_post':
//         return '';
//       case 'profile_picture':
//         return 'updated his profile picture';
//       case 'cover_picture':
//         return 'updated his cover photo';
//       case 'event':
//         return '';
//       case 'shared_reels':
//         return '';
//       case 'birthday':
//         return '';
//       case 'campaign':
//         return '';
//       default:
//         return '';
//     }
//   }

//   Widget ReactionIcon(String reactionPath) {
//     return Image(
//         height: 17, image: NetworkImage(getFormatedFeelingUrl(reactionPath)));
//   }

//   String getFormatedFeelingUrl(String path) {
//     return '${ApiConstant.SERVER_IP_PORT}/assets/logo/$path';
//   }
// }
