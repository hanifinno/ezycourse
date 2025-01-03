import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/api_constant.dart';
import '../../config/app_assets.dart';
import '../../models/comment_model.dart';
import '../../models/user.dart';
import '../../models/user_id.dart';
import '../../modules/home/controllers/home_controller.dart';
import '../../routes/app_pages.dart';
import '../../utils/comment.dart';
import '../../utils/image.dart';
import '../../utils/post_utlis.dart';
import '../image.dart';
import '../reaction_button/comment_reaction_button.dart';

class CommentTile extends StatelessWidget {
  final int commentIndex;
  final CommentModel commentModel;
  final FocusNode inputNodes;
  final TextEditingController textEditingController;
  final Function(String reaction) onSelectCommentReaction;
  final Function(CommentModel commentModel) onCommentEdit;
  final Function(CommentModel commentModel) onCommentDelete;
  final Function(CommentReplay commentReplayModel)? onCommentReplayEdit;

  final Function(String replyId, String postId) onCommentReplayDelete;
  final Function(
    String reaction,
    String commentReplayId,
  ) onSelectCommentReplayReaction;

  HomeController controller = Get.find();

  CommentTile({
    super.key,
    required this.commentModel,
    required this.inputNodes,
    required this.textEditingController,
    required this.onSelectCommentReaction,
    required this.onSelectCommentReplayReaction,
    required this.commentIndex,
    required this.onCommentEdit,
    required this.onCommentDelete,
    this.onCommentReplayEdit,
    required this.onCommentReplayDelete,
  });

  @override
  Widget build(BuildContext context) {
    UserIdModel? commentedUserIdModel =
        commentModel.user_id; // User who did this comment
    UserModel currentUserModel = controller.userModel;
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          //============================================================== Main Comment Section ==============================================================
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //========================================Profile Picture
              const SizedBox(width: 10),
              RoundCornerNetworkImage(
                imageUrl: getFormatedProfileUrl(
                  commentedUserIdModel?.profile_pic ?? '',
                ),
              ),
              const SizedBox(width: 10),
              // ======================================== Comment with user Name + Action Section
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 221, 221, 221),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // ============= On click Name of commenter ===================
                          InkWell(
                            onTap: () {
                              if (commentedUserIdModel?.username ==
                                  currentUserModel.username) {
                                Get.toNamed(Routes.PROFILE);
                              } else {
                                Get.toNamed(Routes.OTHERS_PROFILE,
                                    arguments: {
                                      'username': commentedUserIdModel?.username,
                                      'isFromReels': 'false'
                                    });
                              }
                            },
                            child: Text(
                              '${commentedUserIdModel?.first_name} ${commentedUserIdModel?.last_name}',
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(height: 4),
                          //================================= Text Comment=========================//
                          (commentModel.comment_name?.isNotEmpty ?? false)
                              ? LinkText(text: commentModel.comment_name!)
                              : const SizedBox(),
                          //================================ Link Image============================//
                          (commentModel.link_image?.isNotEmpty ?? false)
                              ? InkWell(
                                  onTap: () async {
                                    await launchUrl(
                                        Uri.parse(commentModel.link ?? ''),
                                        mode: LaunchMode.externalApplication);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: PrimaryNetworkImage(
                                        imageUrl: commentModel.link_image!),
                                  ),
                                )
                              : const SizedBox(),
                          //================================= Image Comment=========================//
                          commentModel.image_or_video != null
                              ? Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: FadeInImage(
                                      height: 100,
                                      width: 100,
                                      // here `bytes` is a Uint8List containing the bytes for the in-memory image
                                      placeholder: const AssetImage(
                                          'assets/image/default_image.png'),
                                      image: NetworkImage(
                                          '${ApiConstant.SERVER_IP_PORT}/${commentModel.image_or_video}'),
                                    ),
                                  ),
                                )
                              : const SizedBox(
                                  height: 0,
                                  width: 0,
                                ),
                        ],
                      ),
                    ),

                    // ========================================= Main comments Action Section =========================================
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Text(
                            maxLines: 1,
                            getDynamicFormatedCommentTime(
                                '${commentModel.createdAt}'),
                          ),
                          const SizedBox(width: 10),
                          // ======================================== Do Comment Reaction ==================================
                          CommentReactionButton(
                            selectedReaction: getSelectedCommentReaction(
                                commentModel, currentUserModel.id ?? ''),
                            onChangedReaction: (reaction) {
                              onSelectCommentReaction(reaction.value);
                            },
                          ),
                          const SizedBox(width: 10),
                          // ======================================== Do Comment Replay ==================================
                          InkWell(
                            onTap: () {
                              controller.commentsID.value =
                                  '${commentModel.id}';
                              controller.postID.value =
                                  '${commentModel.post_id}';

                              FocusScope.of(context).requestFocus(inputNodes);

                              controller.isReply.value = true;
                            },
                            child: const Text('Reply'),
                          ),
                          const Expanded(child: SizedBox()),

                          InkWell(
                            onTap: () {
                              Get.toNamed(Routes.COMMENT_REACTIONS,
                                  arguments: commentModel);
                            },
                            child: CommentReactionIcons(commentModel),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //======================================== More Action Icon

              currentUserModel.id == commentModel.user_id?.id
                  ? PopupMenuButton(
                      color: Colors.white,
                      offset: const Offset(-50, 00),
                      iconColor: Colors.grey,
                      icon: const Icon(
                        Icons.more_horiz,
                        color: Colors.grey,
                      ),
                      itemBuilder: (context) {
                        List<PopupMenuEntry<int>> menuItems = [];
                        //====================================================== Edit Comment =======================================//

                        if (commentModel.image_or_video == null ||
                            commentModel.comment_name != '') {
                          menuItems.add(
                            PopupMenuItem(
                              onTap: () {
                                onCommentEdit(commentModel);
                              },
                              value: 1,
                              child: const Text(
                                'Edit',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          );
                        }

                        //====================================================== Delete Comment =======================================//

                        menuItems.add(
                          PopupMenuItem(
                            onTap: () {
                              onCommentDelete(commentModel);
                            },
                            value: 2,
                            child: const Text(
                              'Delete',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        );

                        return menuItems;
                      },
                    )
                  : const SizedBox(
                      height: 0,
                      width: 50,
                    ),
            ],
          ),

          //===================================================================== Comment Replay List =========================================//

          Container(
            margin: const EdgeInsets.only(left: 65),
            child: ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: commentModel.replies?.length ?? 0,
                itemBuilder: (context, index) {
                  CommentReplay? commentReplay = commentModel.replies?[index];
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //============================================== Comment Replay User Image
                      RoundCornerNetworkImage(
                        imageUrl: getFormatedProfileUrl(
                          commentModel.replies?[index].replies_user_id
                                  ?.profile_pic ??
                              '',
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      /////////////////////////////
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromARGB(255, 221, 221, 221),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    child: Row(
                                      children: [
                                        //============================================== Comment Replay User Name
                                        Text(
                                          '${commentModel.replies?[index].replies_user_id?.first_name} ${commentModel.replies![index].replies_user_id?.last_name}',
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                  (commentModel
                                              .replies?[index]
                                              .replies_comment_name
                                              ?.isNotEmpty ??
                                          false)
                                      ? LinkText(
                                          text:
                                              '${commentModel.replies![index].replies_comment_name}')
                                      : const SizedBox(height: 5),

                                  //================================ Link Image============================//
                                  (commentModel.replies![index].link_image
                                              ?.isNotEmpty ??
                                          false)
                                      ? InkWell(
                                          onTap: () async {
                                            await launchUrl(
                                                Uri.parse(commentModel
                                                        .replies![index].link ??
                                                    ''),
                                                mode: LaunchMode
                                                    .externalApplication);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: PrimaryNetworkImage(
                                                imageUrl: commentModel
                                                    .replies![index]
                                                    .link_image!),
                                          ),
                                        )
                                      : const SizedBox(),
                                  commentModel.replies?[index].image_or_video !=
                                          null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: FadeInImage(
                                            placeholder: const AssetImage(
                                              AppAssets.DEFAULT_IMAGE,
                                            ),
                                            image: NetworkImage(
                                                '${ApiConstant.SERVER_IP_PORT}/${commentModel.replies?[index].image_or_video}'),
                                          ),
                                        )
                                      : const SizedBox(
                                          height: 0,
                                          width: 0,
                                        ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    maxLines: 1,
                                    getDynamicFormatedCommentTime(
                                        '${commentModel.replies![index].createdAt}'),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  //=============================================================== Comment Replay Reaction===============================================================
                                  CommentReactionButton(
                                    selectedReaction:
                                        getSelectedCommentReplayReaction(
                                            commentModel.replies![index],
                                            currentUserModel.id ?? ''),
                                    onChangedReaction: (reaction) {
                                      onSelectCommentReplayReaction(
                                          reaction.value,
                                          '${commentModel.replies?[index].id}');
                                    },
                                  ),
                                  //===============================================================Do Comment Replay ===============================================================

                                  InkWell(
                                    onTap: () {
                                      controller.commentsID.value =
                                          '${commentModel.id}';
                                      controller.postID.value =
                                          '${commentModel.post_id}';

                                      FocusScope.of(context)
                                          .requestFocus(inputNodes);
                                      controller.isReply.value = true;
                                    },
                                    child: const Text('Reply'),
                                  ),
                                  const Expanded(child: SizedBox()),
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed(
                                          Routes.COMMENT_REPLAY_REACTIONS,
                                          arguments:
                                              commentModel.replies?[index]);
                                    },
                                    child: ReplayReactionIcons(
                                        commentReplay ?? CommentReplay()),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      currentUserModel.id ==
                              commentModel.replies?[index].replies_user_id?.id
                          ? PopupMenuButton(
                              color: Colors.white,
                              offset: const Offset(140, 40),
                              iconColor: Colors.grey,
                              icon: const Icon(
                                Icons.more_horiz,
                                color: Colors.grey,
                              ),
                              itemBuilder: (context) {
                                List<PopupMenuEntry<int>> items = [];
                                //       //====================================================== Edit Reply Comment =======================================//

                                if (commentReplay?.image_or_video == null ||
                                    commentReplay?.replies_comment_name != '') {
                                  items.add(
                                    PopupMenuItem(
                                      onTap: () {
                                        onCommentReplayEdit!(
                                          commentReplay ?? CommentReplay(),
                                        );
                                      },
                                      value: 1,
                                      child: const Text(
                                        'Edit',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  );
                                }

                                //       //====================================================== Delete Reply Comment =======================================//

                                items.add(
                                  PopupMenuItem(
                                    onTap: () {
                                      onCommentReplayDelete(
                                          '${commentModel.replies?[index].id}',
                                          '${commentModel.replies?[index].post_id}');
                                    },
                                    value: 2,
                                    child: const Text(
                                      'Delete',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                );

                                return items;
                              },
                            )
                          : const SizedBox(
                              height: 0,
                              width: 50,
                            ),
                    ],
                  );
                }),
          )

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        ],
      ),
    );
  }

  Widget ReactionIcon(String assetName) {
    return Image(height: 24, image: AssetImage(assetName));
  }

  Widget ReactionIcons(String reactionType) {
    switch (reactionType) {
      case 'like':
        return const Image(
            height: 24, width: 24, image: AssetImage(AppAssets.LIKE_ICON));
      case 'love':
        return const Image(
            height: 24, width: 24, image: AssetImage(AppAssets.LOVE_ICON));
      case 'haha':
        return const Image(
            height: 24, width: 24, image: AssetImage(AppAssets.HAHA_ICON));
      case 'wow':
        return const Image(
            height: 24, width: 24, image: AssetImage(AppAssets.WOW_ICON));
      case 'sad':
        return const Image(
            height: 24, width: 24, image: AssetImage(AppAssets.SAD_ICON));
      case 'angry':
        return const Image(
            height: 24, width: 24, image: AssetImage(AppAssets.ANGRY_ICON));
      case 'unlike':
        return const Image(
            height: 24, width: 24, image: AssetImage(AppAssets.UNLIKE_ICON));
      default:
        return const Image(
            height: 24, width: 24, image: AssetImage(AppAssets.LIKE_ICON));
    }
  }
}
