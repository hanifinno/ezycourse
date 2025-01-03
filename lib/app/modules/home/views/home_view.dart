import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../components/comment/comment_component.dart';
import '../../../components/image.dart';
import '../../../components/post/post.dart';
import '../../../components/post/post_shimer_loader.dart';
import '../../../config/app_assets.dart';
import '../../../data/login_creadential.dart';
import '../../../data/post.dart';
import '../../../models/post.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/color.dart';
import '../../../utils/image.dart';
import '../../../utils/snackbar.dart';
import '../controllers/home_controller.dart';


class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey shareButtonKey = GlobalKey();
    const String baseUrl = 'https://quantumpossibilities.eu/notification/';

    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
          onRefresh: () async {
            controller.postList.value.clear();
            controller.postList.refresh();
            // controller.pageNo =1;
            // controller.totalPageCount =0;
            // Future.wait([
            controller.getPosts();
            controller.generateRandomIndicesForPosts();
            // ]);
            // controller.peopleMayYouKnowList.value.clear();
            // await Future.wait([
            //   controller.getPeopleMayYouKnow(),
            // ]);
          },
          child: SingleChildScrollView(
            controller: controller.postScrollController,
            child: Column(
              children: [
                //================================================== Do Post Section ==================================================//
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RoundCornerNetworkImage(
                      imageUrl: getFormatedProfileUrl(
                          controller.userModel.profile_pic ?? ''),
                    ),
                    InkWell(
                      onTap: controller.onTapCreatePost,
                      child: Container(
                        height: 40,
                        width: Get.width - 140,
                        padding: const EdgeInsets.all(5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          maxLines: 1,
                          "What's on your mind, ${controller.userModel.first_name}?",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          // style: TextStyle(
                          //   fontSize: 16,
                          // ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.withOpacity(0.1),
                      ),
                      child: IconButton(
                          onPressed: () {
                            controller.pickMediaFiles();
                          },
                          icon: const Image(
                              height: 25,
                              image: AssetImage(AppAssets.Gallery_ICON))),
                    )
                  ],
                ),

               
                // ================================================================= Post =================================================================//
                Obx(
                  () => Column(
                    children: [
                      controller.postList.value.isEmpty
                          ? const PostShimerLoader()
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.postList.value.length +
                                  controller.randomIndices.length,
                              itemBuilder: (context, postIndex) {
                          
                                  int actualPostIndex = postIndex -
                                      controller.randomIndices
                                          .where((i) => i < postIndex)
                                          .length;
                                  if (actualPostIndex >= 0 &&
                                      actualPostIndex <
                                          controller.postList.value.length) {
                                    // debugPrint('Video Screen triggered:::::::::::: ${controller.videoAdList.value.first.campaignCoverPic?[0]}');
                                    PostModel postModel = controller
                                        .postList.value[actualPostIndex];
                                    return PostCard(
                                      
                                      onSixSeconds: () {
                                        debugPrint(
                                            'Video Screen triggered:::::::::::: ${controller.videoAdList.value.first.campaignCoverPic?.first ?? ''}');
                                        // Get.to(()=> VideoAdScreen(videoLink: controller.videoAdList.value.first.campaignCoverPic?.first??''));
                                      },
                                      adVideoLink: getFormatedAdsUrl(controller
                                              .videoAdList
                                              .value[controller
                                                  .currentAdIndex.value]
                                              .campaignCoverPic?[0] ??
                                          ''),
                                      campaignWebUrl: (controller
                                              .videoAdList
                                              .value[controller
                                                  .currentAdIndex.value]
                                              .websiteUrl ??
                                          ''),
                                      campaignName: (controller
                                              .videoAdList
                                              .value[controller
                                                  .currentAdIndex.value]
                                              .campaignName
                                              ?.capitalizeFirst ??
                                          ''),
                                      campaignDescription: (controller
                                              .videoAdList
                                              .value[controller
                                                  .currentAdIndex.value]
                                              .description ??
                                          ''),
                                      campaignCallToAction: () async{
                                        debugPrint(
                                            'Campaign Name::::::${(controller.videoAdList.value[controller.currentAdIndex.value].campaignName?.capitalizeFirst ?? '')}');
                                     
                                       await launchUrl(
                                        Uri.parse (controller
                                              .videoAdList
                                              .value[controller
                                                  .currentAdIndex.value]
                                              .websiteUrl ??
                                          ''),
                                        mode: LaunchMode.externalApplication);
                                      },
                                      model: postModel,
                                      onSelectReaction: (reaction) {
                                        controller.reactOnPost(
                                          postModel: postModel,
                                          reaction: reaction,
                                          index: actualPostIndex,
                                        );
                                        debugPrint(reaction);
                                      },
                                      onPressedComment: () {
                                        Get.bottomSheet(
                                          Obx(
                                            () => CommentComponent(
                                              onCommentEdit:
                                                  (commentModel) async {
                                                await Get.toNamed(
                                                    Routes.EDIT_POST_COMMENT,
                                                    arguments: {
                                                      'post_comment':
                                                          commentModel
                                                              .comment_name,
                                                      'post_id':
                                                          commentModel.post_id,
                                                      'comment_id':
                                                          commentModel.id,
                                                      'comment_type':
                                                          commentModel
                                                              .comment_type,
                                                      'image_video':
                                                          commentModel
                                                              .image_or_video
                                                    });
                                                controller.updatePostList(
                                                    commentModel.post_id ?? '',
                                                    actualPostIndex);
                                              },
                                              onCommentReplayEdit:
                                                  (commentReplayModel) async {
                                                await Get.toNamed(
                                                    Routes
                                                        .EDIT_REPLY_POST_COMMENT,
                                                    arguments: {
                                                      'reply_comment':
                                                          commentReplayModel
                                                              .replies_comment_name,
                                                      'replay_post_id':
                                                          commentReplayModel
                                                              .post_id,
                                                      'comment_replay_id':
                                                          commentReplayModel.id,
                                                      'comment_type':
                                                          commentReplayModel
                                                              .comment_type,
                                                      'image_video':
                                                          commentReplayModel
                                                              .image_or_video
                                                    });
                                                controller.updatePostList(
                                                    commentReplayModel
                                                            .post_id ??
                                                        '',
                                                    actualPostIndex);
                                              },
                                              onCommentDelete: (commentModel) {
                                                controller.commentDelete(
                                                    commentModel.id ?? '',
                                                    commentModel.post_id ?? '',
                                                    actualPostIndex);
                                              },
                                              onCommentReplayDelete:
                                                  (replyId, postId) {
                                                controller.replyDelete(replyId,
                                                    postId, actualPostIndex);
                                              },
                                              commentController:
                                                  controller.commentController,
                                              postModel: controller.postList
                                                  .value[actualPostIndex],
                                              userModel: controller.userModel,
                                              onTapSendComment: () {
                                                controller.commentOnPost(
                                                    actualPostIndex, postModel);
                                              },
                                              onTapReplayComment: ({
                                                required commentReplay,
                                                required comment_id,
                                              }) {
                                                controller.commentReply(
                                                  comment_id: comment_id,
                                                  replies_comment_name:
                                                      commentReplay,
                                                  post_id: postModel.id ?? '',
                                                  postIndex: actualPostIndex,
                                                );
                                              },
                                              onSelectCommentReaction: (
                                                reaction,
                                                commentId,
                                              ) {
                                                controller.commentReaction(
                                                  postIndex: actualPostIndex,
                                                  reaction_type: reaction,
                                                  post_id: postModel.id ?? '',
                                                  comment_id: commentId,
                                                );
                                              },
                                              onSelectCommentReplayReaction: (
                                                reaction,
                                                commentId,
                                                commentRepliesId,
                                              ) {
                                                controller.commentReplyReaction(
                                                    actualPostIndex,
                                                    reaction,
                                                    postModel.id ?? '',
                                                    commentId,
                                                    commentRepliesId);
                                              },
                                              onTapViewReactions: () {
                                                Get.toNamed(Routes.REACTIONS,
                                                    arguments: postModel.id);
                                              },
                                            ),
                                          ),
                                          backgroundColor: Colors.white,
                                          isScrollControlled: true,
                                        );
                                      },
                                      onTapBodyViewMoreMedia: () {
                                        // Get.to(MultipleImageView(
                                        //     postModel: postModel));
                                      },
                                      onTapViewReactions: () {
                                        Get.toNamed(Routes.REACTIONS,
                                            arguments: postModel.id);
                                      },
                                      onTapViewPostHistory: () {
                                        Get.back();
                                        Get.toNamed(Routes.EDIT_HISTORY,
                                            arguments: postModel.id);
                                      },
                                      onTapEditPost: () {
                                        Get.back();
                                        controller.onTapEditPost(postModel);
                                      },
                                      onTapHidePost: () {
                                        controller.hidePost(
                                            1,
                                            postModel.id.toString(),
                                            actualPostIndex);
                                      },
                                      onTapBookMardPost: () {
                                        controller.bookmarkPost(
                                            postModel.id.toString(),
                                            postModel.post_privacy.toString(),
                                            actualPostIndex);
                                      },
                                      onTapRemoveBookMardPost: () {
                                        controller.removeBookmarkPost(
                                            postModel.id ?? '',
                                            postModel.bookmark?.id ?? '',
                                            actualPostIndex);
                                      },
                                      onTapCopyPost: () async {
                                        await Clipboard.setData(ClipboardData(
                                            text: '$baseUrl${postModel.id}'));
                                        Get.back();
                                        showSuccessSnackkbar(
                                            message:
                                                'Your link copied to clipboard');
                                      },
                                      onTapViewOtherProfile:
                                          postModel.event_type == 'relationship'
                                              ? () {
                                                  Get.toNamed(
                                                      Routes.OTHERS_PROFILE,
                                                      arguments: {
                                                        'username': postModel
                                                            .lifeEventId
                                                            ?.toUserId
                                                            ?.username,
                                                        'isFromReels': false
                                                      });
                                                }
                                              : null,
                                      onTapShareViewOtherProfile:
                                          postModel.post_type == 'Shared'
                                              ? () {
                                                  if (LoginCredential()
                                                          .getUserData()
                                                          .username !=
                                                      postModel
                                                          .user_id?.username) {
                                                    Get.toNamed(
                                                        Routes.OTHERS_PROFILE,
                                                        arguments: postModel
                                                                .share_post_id
                                                                ?.lifeEventId
                                                                ?.toUserId
                                                                ?.username ??
                                                            '');
                                                  }
                                                }
                                              : null,

                                      /* ============Share Post BottoSheet ==========*/
                                      onPressedShare:
                                          controller
                                                      .postList
                                                      .value[actualPostIndex]
                                                      .post_privacy ==
                                                  'public'
                                              ? () {
                                                  Get.bottomSheet(
                                                    SingleChildScrollView(
                                                      child: Column(
                                                        children: [
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        10,
                                                                    horizontal:
                                                                        10),
                                                            child: Row(
                                                              children: [
                                                                NetworkCircleAvatar(
                                                                    imageUrl: getFormatedProfileUrl(LoginCredential()
                                                                            .getUserData()
                                                                            .profile_pic ??
                                                                        '')),
                                                                const SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      '${LoginCredential().getUserData().first_name} ${LoginCredential().getUserData().last_name}',
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    Container(
                                                                      height:
                                                                          25,
                                                                      width:
                                                                          Get.width /
                                                                              4,
                                                                      decoration: BoxDecoration(
                                                                          border: Border.all(
                                                                              color:
                                                                                  PRIMARY_COLOR,
                                                                              width:
                                                                                  1),
                                                                          borderRadius:
                                                                              BorderRadius.circular(5)),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        children: [
                                                                          Obx(
                                                                            () => controller.dropdownValue.value == 'Public'
                                                                                ? const Icon(
                                                                                    Icons.public,
                                                                                    color: PRIMARY_COLOR,
                                                                                    size: 15,
                                                                                  )
                                                                                : controller.dropdownValue.value == 'Friends'
                                                                                    ? const Icon(
                                                                                        Icons.group,
                                                                                        color: PRIMARY_COLOR,
                                                                                        size: 15,
                                                                                      )
                                                                                    : const Icon(
                                                                                        Icons.lock,
                                                                                        color: PRIMARY_COLOR,
                                                                                        size: 15,
                                                                                      ),
                                                                          ),
                                                                          Obx(() =>
                                                                              DropdownButton<String>(
                                                                                value: controller.dropdownValue.value,
                                                                                icon: const Icon(
                                                                                  Icons.arrow_drop_down,
                                                                                  color: PRIMARY_COLOR,
                                                                                ),
                                                                                elevation: 16,
                                                                                style: const TextStyle(color: PRIMARY_COLOR),
                                                                                underline: Container(
                                                                                  height: 2,
                                                                                  color: Colors.transparent,
                                                                                ),
                                                                                onChanged: (String? value) {
                                                                                  controller.dropdownValue.value = value!;
                                                                                  controller.postPrivacy.value = value;
                                                                                },
                                                                                items: privacyList.map<DropdownMenuItem<String>>((String value) {
                                                                                  return DropdownMenuItem<String>(
                                                                                    value: value,
                                                                                    child: Text(
                                                                                      value,
                                                                                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                                                                                    ),
                                                                                  );
                                                                                }).toList(),
                                                                              )),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 200,
                                                            child: TextField(
                                                              controller: controller
                                                                  .descriptionController,
                                                              maxLines: 10,
                                                              decoration:
                                                                  InputDecoration(
                                                                fillColor:
                                                                    Colors
                                                                        .white,
                                                                filled: true,
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                hintText:
                                                                    'What’s on your mind ${controller.userModel.first_name}?',
                                                              ),
                                                              onChanged:
                                                                  (value) {
                                                                debugPrint(
                                                                    'Update model status code on chage.............${controller.descriptionController.text}');
                                                              },
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Obx(
                                                                () => Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              15),
                                                                  child:
                                                                      ElevatedButton(
                                                                    key:
                                                                        shareButtonKey,
                                                                    onPressed:
                                                                        () async {
                                                                      Get.back();
                                                                      // PostModel model =
                                                                      //     controller
                                                                      //             .postList
                                                                      //             .value[
                                                                      //         postIndex];
                                                                      controller.postList.value[actualPostIndex].post_type ==
                                                                              'Shared'
                                                                          ? await controller.shareUserPost(controller.postList.value[actualPostIndex].share_post_id?.id ??
                                                                              '')
                                                                          : await controller.shareUserPost(controller
                                                                              .postList
                                                                              .value[actualPostIndex]
                                                                              .id
                                                                              .toString());
                                                                    },
                                                                    // Disable the button if the condition is not met
                                                                    style: ElevatedButton
                                                                        .styleFrom(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          15),
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5.0),
                                                                      ),
                                                                      backgroundColor: controller.dropdownValue.value ==
                                                                              'Public'
                                                                          ? PRIMARY_COLOR
                                                                          : Colors
                                                                              .grey, // Change color if disabled
                                                                      textStyle:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            30,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        const Text(
                                                                      'Share Now',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          const Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            15.0),
                                                                child: Text(
                                                                  'Share to',
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          20),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              /*=========================== ============= Facebook  =========================== =========================================*/
                                                              InkWell(
                                                                onTap: () {
                                                                  controller
                                                                          .descriptionController
                                                                          .text
                                                                          .isNotEmpty
                                                                      ? controller
                                                                          .launchURL(
                                                                              'https://www.facebook.com/sharer/sharer.php?u=${Uri.encodeComponent('${controller.descriptionController.text}\n$baseUrl${controller.postList.value[actualPostIndex].id ?? ''}')}')
                                                                      : controller
                                                                          .launchURL(
                                                                              'https://www.facebook.com/sharer/sharer.php?u=$baseUrl${Uri.encodeComponent(controller.postList.value[actualPostIndex].id ?? '')}');
                                                                },
                                                                child:
                                                                    const Image(
                                                                  height: 30,
                                                                  image: AssetImage(
                                                                      'assets/image/facebook-logo.png'),
                                                                ),
                                                              ),
                                                              /*=========================== ============= Messanger  =========================== =========================================*/
                                                              InkWell(
                                                                onTap: () {
                                                                  controller
                                                                          .descriptionController
                                                                          .text
                                                                          .isNotEmpty
                                                                      ? Share.share(
                                                                          'fb-messenger://share?link=${Uri.encodeComponent('${controller.descriptionController.text}\n$baseUrl${controller.postList.value[actualPostIndex].id ?? ''}')}')
                                                                      : Share.share(
                                                                          'fb-messenger://share?link=$baseUrl${Uri.encodeComponent(controller.postList.value[actualPostIndex].id ?? '')}');
                                                                },
                                                                child:
                                                                    const Image(
                                                                  height: 30,
                                                                  image: AssetImage(
                                                                      'assets/image/messenger-logo.png'),
                                                                ),
                                                              ),
                                                              /*=========================== ============= Twitter/X  =========================== =========================================*/
                                                              InkWell(
                                                                onTap: () {
                                                                  controller
                                                                          .descriptionController
                                                                          .text
                                                                          .isNotEmpty
                                                                      ? controller
                                                                          .launchURL(
                                                                              'https://twitter.com/intent/tweet?text=${Uri.encodeComponent('${controller.descriptionController.text}\n$baseUrl${controller.postList.value[actualPostIndex].id ?? ''}')}')
                                                                      : controller
                                                                          .launchURL(
                                                                              'https://twitter.com/intent/tweet?text=$baseUrl${Uri.encodeComponent(controller.postList.value[actualPostIndex].id ?? '')}');
                                                                },
                                                                child:
                                                                    const Image(
                                                                  height: 30,
                                                                  image: AssetImage(
                                                                      'assets/image/x_logo.jpg'),
                                                                ),
                                                              ),
                                                              /*=========================== ============= WhatsApp  =========================== =========================================*/
                                                              InkWell(
                                                                onTap: () {
                                                                  controller
                                                                          .descriptionController
                                                                          .text
                                                                          .isNotEmpty
                                                                      ? controller
                                                                          .launchURL(
                                                                              'https://wa.me/?text=${Uri.encodeComponent('${controller.descriptionController.text}\n$baseUrl${controller.postList.value[actualPostIndex].id ?? ''}')}')
                                                                      : controller
                                                                          .launchURL(
                                                                              'https://wa.me/?text=$baseUrl${Uri.encodeComponent(controller.postList.value[actualPostIndex].id ?? '')}');
                                                                },
                                                                child:
                                                                    const Image(
                                                                  height: 30,
                                                                  image: AssetImage(
                                                                      'assets/image/whatsapp-logo.png'),
                                                                ),
                                                              ),
                                                              /*=========================== ============= Instagram =========================== =========================================*/
                                                              // InkWell(
                                                              //   onTap: () {
                                                              //     controller
                                                              //             .descriptionController
                                                              //             .text
                                                              //             .isNotEmpty
                                                              //         ? controller
                                                              //             .launchURL(
                                                              //                 'https://twitter.com/intent/tweet?text=${Uri.encodeComponent('${controller.descriptionController.text}\n$baseUrl${controller.postList.value[actualPostIndex].id ?? ''}')}')
                                                              //         : controller
                                                              //             .launchURL(
                                                              //                 'https://twitter.com/intent/tweet?text=$baseUrl${Uri.encodeComponent(controller.postList.value[actualPostIndex].id ?? '')}');
                                                              //   },
                                                              //   child:
                                                              //       const Image(
                                                              //     height: 30,
                                                              //     image: AssetImage(
                                                              //         'assets/image/instagram_logo.png'),
                                                              //   ),
                                                              // ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 50,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    backgroundColor:
                                                        Colors.white,
                                                  ).whenComplete(() {
                                                    controller
                                                        .descriptionController
                                                        .clear();
                                                  });
                                                }
                                              : () {},
                                    );
                                  } else {
                                    debugPrint(
                                        'Invalid actualPostIndex: $actualPostIndex, postIndex: $actualPostIndex');
                                    return Container(); // Or return an empty widget or error widget
                                  }
                                

                                // }
                                // PostModel postModel =
                                //     controller.postList.value[postIndex];
                              },
                            ),
                    ],
                  ),
                ),
                Obx(() => controller.isLoadingNewsFeed.value
                    ? const PostShimerLoader()
                    : const SizedBox())
              ],
            ),
          )),
    );
  }

//
}
