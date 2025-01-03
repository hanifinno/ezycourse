import 'package:flutter/material.dart';

import '../../models/post.dart';
import 'post_body/post_body.dart';
import 'post_footer/post_footer.dart';
import 'post_header/post_header.dart';

class PostCard extends StatelessWidget {
  const PostCard(
      {super.key,
      required this.model,
      required this.onSelectReaction,
      required this.onPressedComment,
      required this.onPressedShare,
      required this.onTapBodyViewMoreMedia,
      this.onTapEditPost,
      this.onTapCopyPost,
      this.onTapBookMardPost,
      this.onTapRemoveBookMardPost,
      this.onTapHidePost,
      this.onTapViewOtherProfile,
      this.onTapShareViewOtherProfile,
      this.viewType,
      this.onTapPinPost,
      this.adVideoLink,
      this.onTapViewPostHistory,
      required this.onTapViewReactions,
      required this.onSixSeconds,
      this.campaignWebUrl,
      this.campaignName,
      this.actionButtonText,
      this.campaignDescription,
      this.campaignCallToAction,
      this.index});

  final PostModel model;
  final Function(String reaction) onSelectReaction;
  final VoidCallback onPressedComment;
  final VoidCallback onPressedShare;
  final VoidCallback onTapBodyViewMoreMedia;
  final VoidCallback onTapViewReactions;
  final VoidCallback? onTapEditPost;
  final VoidCallback? onTapHidePost;
  final VoidCallback? onTapBookMardPost;
  final VoidCallback? onTapRemoveBookMardPost;
  final VoidCallback? onTapViewOtherProfile;
  final VoidCallback? onTapShareViewOtherProfile;
  final VoidCallback? onTapCopyPost;
  final VoidCallback? onTapViewPostHistory;
  final VoidCallback? onTapPinPost;
  final VoidCallback onSixSeconds;
  final String? viewType;
  final String? adVideoLink;
  final String? campaignWebUrl;
  final String? actionButtonText;
  final String? campaignName;
  final String? campaignDescription;
  final VoidCallback? campaignCallToAction;

  final index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
                  children: [
                   PostHeader(
                                model: model,
                                onTapEditPost: onTapEditPost ?? () {},
                                onTapHidePost: onTapHidePost ?? () {},
                                onTapBookMarkPost: onTapBookMardPost ?? () {},
                                onTapCopyPost: onTapCopyPost ?? () {},
                                onTapViewPostHistory:
                                    onTapViewPostHistory ?? () {},
                                onTapPinPost: onTapPinPost ?? () {},
                                onTapRemoveBookMarkPost:
                                    onTapRemoveBookMardPost ?? () {},
                                viewType: viewType ?? '',
                              ),
                    const SizedBox(height: 10),
                    PostBodyView(
                      adVideoLink: adVideoLink,
                      actionButtonText: actionButtonText,
                      campaignWebUrl: campaignWebUrl,
                      campaignName: campaignName,
                      campaignDescription: campaignDescription,
                      campaignCallToAction: campaignCallToAction,
                      onSixSeconds: onSixSeconds,
                      model: model,
                      onTapBodyViewMoreMedia: onTapBodyViewMoreMedia,
                      onTapViewOtherProfile: onTapViewOtherProfile ?? () {},
                    ),
                    const SizedBox(height: 10),
                    PostFooter(
                      model: model,
                      onSelectReaction: onSelectReaction,
                      onPressedComment: onPressedComment,
                      onPressedShare: onPressedShare,
                      onTapViewReactions: onTapViewReactions,
                    ),
                  ],
                ),
    );
  }

  Widget ReactionIcon(String assetName) {
    return Image(height: 32, image: AssetImage(assetName));
  }
}
