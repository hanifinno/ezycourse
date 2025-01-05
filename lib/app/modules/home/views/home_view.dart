import 'package:ezycourse/app/modules/home/components/custom_bottom_navbar/custom_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/comment/comment_component.dart';
import '../../../components/image.dart';
import '../../../components/post/post.dart';
import '../../../components/post/post_shimer_loader.dart';
import '../../../global_components/custom_app_bar.dart';
import '../../../models/post.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/color.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: const CustomAppBar(
        title: 'Python Community',
        subtitle: '#General',
      ),
      body: RefreshIndicator(
          onRefresh: () async {
            controller.postList.value.clear();
            controller.postList.refresh();
            controller.pageNo = 1;
            controller.totalPageCount = 0;
            controller.fetchCommunityPosts();
          },
          child: SingleChildScrollView(
            controller: controller.postScrollController,
            child: Column(
              children: [
                //================================================== Do Post Section ==================================================//
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: controller.onTapCreatePost,
                      child: Container(
                        height: 80,
                        width: Get.width - 40,
                        padding: const EdgeInsets.all(5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            RoundCornerNetworkImage(
                              imageUrl: (controller.userModel.profilePic ?? ''),
                            ),
                            const Text(
                              maxLines: 5,
                              "Write something here....",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              // style: TextStyle(
                              //   fontSize: 16,
                              // ),
                            ),
                            Container(
                          height: 40,
                          width: Get.width * 0.24,
                          decoration: BoxDecoration(
                              color: PRIMARY_COLOR,
                              borderRadius: BorderRadius.circular(5)),
                          child: TextButton(
                            onPressed: () {
                              controller.onTapCreatePost();
                            },
                            child: const Text(
                              'Post',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
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
                              itemCount: controller.postList.value.length,
                              itemBuilder: (context, postIndex) {
                                int actualPostIndex = postIndex;
                                if (controller.postList.value.length != 0) {
                                  // debugPrint('Video Screen triggered:::::::::::: ${controller.videoAdList.value.first.campaignCoverPic?[0]}');
                                  PostModel postModel = controller
                                      .postList.value[actualPostIndex];
                                  return PostCard(
                                    model: postModel,
                                    onSelectReaction: (reaction) {
                                      controller.reactOnPost(
                                          postModel: postModel,
                                          reaction: reaction,
                                          index: actualPostIndex,
                                          action: 'Create');
                                      debugPrint(reaction);
                                    },
                                    onPressedComment: () {
                                      controller.fetchPostComments(
                                          postModel.id ?? 1, actualPostIndex);
                                      Get.bottomSheet(
                                        Obx(
                                          () => CommentComponent(
                                            onCommentEdit:
                                                (commentModel) async {
                                              // await Get.toNamed(
                                              //     Routes.EDIT_POST_COMMENT,
                                              //     arguments: {
                                              //       'post_comment':
                                              //           commentModel
                                              //               .commentText,
                                              //       'post_id':
                                              //           commentModel.post_id,
                                              //       'comment_id':
                                              //           commentModel.id,
                                              //       'comment_type':
                                              //           commentModel
                                              //               .comment_type,
                                              //       'image_video':
                                              //           commentModel
                                              //               .image_or_video
                                              //     });
                                              // controller.updatePostList(
                                              //     commentModel.post_id ?? '',
                                              //     actualPostIndex);
                                            },
                                            onCommentReplayEdit:
                                                (commentReplayModel) async {
                                              // await Get.toNamed(
                                              //     Routes
                                              //         .EDIT_REPLY_POST_COMMENT,
                                              //     arguments: {
                                              //       'reply_comment':
                                              //           commentReplayModel
                                              //               .replies_comment_name,
                                              //       'replay_post_id':
                                              //           commentReplayModel
                                              //               .post_id,
                                              //       'comment_replay_id':
                                              //           commentReplayModel.id,
                                              //       'comment_type':
                                              //           commentReplayModel
                                              //               .comment_type,
                                              //       'image_video':
                                              //           commentReplayModel
                                              //               .image_or_video
                                              //     });
                                              // controller.updatePostList(
                                              //     commentReplayModel
                                              //             .post_id ??
                                              //         '',
                                              //     actualPostIndex);
                                            },
                                            onCommentDelete: (commentModel) {
                                              // controller.commentDelete(
                                              //     commentModel.id ?? '',
                                              //     commentModel.post_id ?? '',
                                              //     actualPostIndex);
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
                                              controller.createPostComments(
                                                  postModel.id ?? 1,
                                                  actualPostIndex);
                                            },
                                            onTapReplayComment: ({
                                              required commentReplay,
                                              required comment_id,
                                            }) {
                                              controller
                                                  .createPostReplyComments(
                                                      postModel.id ?? 0,
                                                      actualPostIndex,
                                                      comment_id);
                                              // controller.commentReply(
                                              //   comment_id: comment_id,
                                              //   replies_comment_name:
                                              //       commentReplay,
                                              //   post_id:
                                              //       postModel.id.toString() ??
                                              //           '',
                                              //   postIndex: actualPostIndex,
                                              // );
                                            },
                                            onSelectCommentReaction: (
                                              reaction,
                                              commentId,
                                            ) {
                                              controller.commentReaction(
                                                postIndex: actualPostIndex,
                                                reaction_type: reaction,
                                                post_id:
                                                    postModel.id.toString() ??
                                                        '',
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
                                                  postModel.id.toString() ?? '',
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
                                          postModel.feedPrivacy.toString(),
                                          actualPostIndex);
                                    },
                                    onTapRemoveBookMardPost: () {
                                      // controller.removeBookmarkPost(
                                      //     postModel.id.toString() ?? '',
                                      //     postModel.bookmark?.id ?? '',
                                      //     actualPostIndex);
                                    },
                                    onTapCopyPost: () async {
                                      // await Clipboard.setData(ClipboardData(
                                      //     text: '$baseUrl${postModel.id}'));
                                      // Get.back();
                                      // showSuccessSnackkbar(
                                      //     message:
                                      //         'Your link copied to clipboard');
                                    },
                                    onTapViewOtherProfile:
                                        // postModel.event_type == 'relationship'
                                        //     ?
                                        () {
                                      // Get.toNamed(
                                      //     Routes.OTHERS_PROFILE,
                                      //     arguments: {
                                      //       'username': postModel
                                      //           .lifeEventId
                                      //           ?.toUserId
                                      //           ?.username,
                                      //       'isFromReels': false
                                      //     });
                                    },
                                    // : null,
                                    onTapShareViewOtherProfile: () {},

                                    /* ============Share Post BottoSheet ==========*/
                                    onPressedShare: () {},
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
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }

//
}
