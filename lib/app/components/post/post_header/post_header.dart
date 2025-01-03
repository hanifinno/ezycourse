import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/api_constant.dart';
import '../../../config/app_assets.dart';
import '../../../data/login_creadential.dart';
import '../../../models/post.dart';

import '../../../modules/home/controllers/home_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/image.dart';
import '../../../utils/post_utlis.dart';
import '../../image.dart';
import '../../post_tag_list.dart';

class PostHeader extends StatelessWidget {
  final PostModel model;
  final VoidCallback onTapEditPost;
  final VoidCallback? onTapHidePost;
  final VoidCallback? onTapBookMarkPost;
  final VoidCallback? onTapRemoveBookMarkPost;
  final VoidCallback? onTapCopyPost;
  final VoidCallback? onTapViewPostHistory;
  final VoidCallback? onTapPinPost;
  final String? viewType;

  PostHeader(
      {super.key,
      required this.model,
      required this.onTapEditPost,
      this.onTapHidePost,
      this.onTapBookMarkPost,
      this.onTapCopyPost,
      this.onTapViewPostHistory,
      this.viewType,
      this.onTapPinPost,
      this.onTapRemoveBookMarkPost});

  RxString character = 'spam'.obs;

  TextEditingController reportDescription = TextEditingController();

  HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    UserModel userModel = model.user!;
    // UserModel currentUserModel = LoginCredential().getUserData();
    return model.fileType == 'text'
        ? Container(
            padding: const EdgeInsets.only(top: 10),
            child: InkWell(
              onTap: () {
              
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 10),
                  RoundCornerNetworkImage(
                    imageUrl: 
                      model.user?.profilePic ?? '',
                    
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                            text:
                                '${model.user?.fullName}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                         
                        ])),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                                '${getDynamicFormatedTime(model.createdAt ?? '')} '),
                          
                            Icon(
                              getIconAsPrivacy(
                                  model.feedPrivacy ?? ''),
                              size: 17,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
         : Container(
                padding: const EdgeInsets.only(top: 10),
                child: InkWell(
                  onTap: () {
              
                  },
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(width: 10),
                          RoundCornerNetworkImage(
                            imageUrl: 
                              userModel.profilePic ?? '',
                            
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                    text:
                                        '${userModel.fullName}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                   ])),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                        '${getDynamicFormatedTime(model.createdAt ?? '')} '),
                                   
                                    Icon(
                                      getIconAsPrivacy(
                                          model.feedPrivacy ?? ''),
                                      size: 17,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // =========================================================== Three Dot Icon ===========================================================

                          model.isPinned == true
                              ? const Padding(
                                  padding: EdgeInsets.only(top: 12.0),
                                  child: Icon(
                                    Icons.bookmark,
                                  ),
                                )
                              : Container(),

                               IconButton(
                                  onPressed: () {
                                    Get.bottomSheet(Container(
                                      height: 250,
                                      color: Colors.white,
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          InkWell(
                                            onTap: onTapHidePost ?? () {},
                                            child: const Padding(
                                              padding: EdgeInsets.only(top: 10),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8),
                                                    child: Icon(
                                                      Icons.hide_image,
                                                      size: 20,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8),
                                                    child: Text(
                                                      'Hide Post',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          model.isPinned == false
                                              ? InkWell(
                                                  onTap: onTapBookMarkPost ??
                                                      () {},
                                                  child: const Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 10),
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 8),
                                                          child: Icon(
                                                            Icons.bookmark,
                                                            size: 20,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 8),
                                                          child: Text(
                                                            'Book Mark',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : InkWell(
                                                  onTap:
                                                      onTapRemoveBookMarkPost ??
                                                          () {},
                                                  child: const Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 10),
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 8),
                                                          child: Icon(
                                                            Icons.bookmark,
                                                            size: 20,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 8),
                                                          child: Text(
                                                            'Remove Book Mark',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          const InkWell(
                                            child: Padding(
                                              padding: EdgeInsets.only(top: 10),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8),
                                                    child: Icon(
                                                      Icons.notification_add,
                                                      size: 20,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8),
                                                    child: Text(
                                                      'Turn off notification',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          InkWell(
                                            onTap: onTapCopyPost,
                                            child: const Padding(
                                              padding: EdgeInsets.only(top: 10),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8),
                                                    child: Icon(
                                                      Icons.link_off,
                                                      size: 20,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8),
                                                    child: Text(
                                                      'Copy link',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              // await homeController.getReports();
                                              // CustomReportBottomSheet
                                              //     .showReportOptions(
                                              //   pageReportList: homeController
                                              //       .pageReportList.value,
                                              //   selectedReportType:
                                              //       homeController
                                              //           .selectedReportType,
                                              //   selectedReportId: homeController
                                              //       .selectedReportId,
                                              //   reportDescription:
                                              //       homeController
                                              //           .reportDescription,
                                              //   onCancel: () {
                                              //     Get.back();
                                              //   },
                                              //   reportAction:
                                              //       (String report_type_id,
                                              //           String report_type,
                                              //           String page_id,
                                              //           String description) {
                                              //     homeController.reportAPost(
                                              //         report_type: report_type,
                                              //         description: description,
                                              //         post_id: model.id ?? '',
                                              //         report_type_id:
                                              //             report_type_id);
                                              //   },
                                              // );
                                           
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Row(
                                                children: [
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10.0),
                                                    child: Icon(
                                                        Icons.report_outlined),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8),
                                                    child: GestureDetector(
                                                      onTap: () async {
                                                        ////////////////////report/////////////////////////////////////////////////
                                                        // await homeController
                                                        //     .getReports();
                                                        // CustomReportBottomSheet
                                                        //     .showReportOptions(
                                                        //   pageReportList:
                                                        //       homeController
                                                        //           .pageReportList
                                                        //           .value,
                                                        //   selectedReportType:
                                                        //       homeController
                                                        //           .selectedReportType,
                                                        //   selectedReportId:
                                                        //       homeController
                                                        //           .selectedReportId,
                                                        //   reportDescription:
                                                        //       homeController
                                                        //           .reportDescription,
                                                        //   onCancel: () {
                                                        //     Get.back();
                                                        //   },
                                                        //   reportAction: (String
                                                        //           report_type_id,
                                                        //       String report_type,
                                                        //       String page_id,
                                                        //       String
                                                        //           description) {
                                                        //     homeController.reportAPost(
                                                        //         report_type:
                                                        //             report_type,
                                                        //         description:
                                                        //             description,
                                                        //         post_id:
                                                        //             model.id ??
                                                        //                 '',
                                                        //         report_type_id:
                                                        //             report_type_id);
                                                        //   },
                                                        // );
                                                        ////////////////report///////////////////////////////////////////////////
                                                      },
                                                      child: const Text(
                                                        'Report',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ));
                                  },
                                  icon: const Icon(Icons.more_vert)),
                        ],
                      ),
                    ],
                  ),
                ),
              );
  }

  getIconAsPrivacy(String postPrivacy) {
    switch (postPrivacy) {
      case 'Public':
        return Icons.public;
      case 'only_me':
        return Icons.lock;
      case 'friends':
        return Icons.people;
      default:
        return Icons.public;
    }
  }

  String getTextAsPostType(String postType) {
    switch (postType) {
      case 'campaign':
        return 'Sponsored ';
      default:
        return '';
    }
  }

  String getHeaderTextAsPostType(PostModel postModel) {
    switch (model.fileType) {
      case 'text':
        return '';
     
      case 'photos':
        return 'updated his profile picture';
      
      default:
        return '';
    }
  }



  

  Widget ReactionIcon(String reactionPath) {
    return Image(
        height: 17, image: NetworkImage(getFormatedFeelingUrl(reactionPath)));
  }

  String getFormatedFeelingUrl(String path) {
    return '${ApiConstant.SERVER_IP_PORT_2}/assets/logo/$path';
  }
}
