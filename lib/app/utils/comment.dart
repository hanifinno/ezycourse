import 'package:flutter/material.dart';
import '../config/app_assets.dart';
import '../models/comment_model.dart';

Widget CommentReactionIcons(CommentModel commentModel) {
    Set<Image> postReactionIcons = {};
    if (commentModel.comment_reactions != null) {
      for (CommentReaction commentReaction in commentModel.comment_reactions!) {
        if (commentReaction.reaction_type == '') {}
        switch (commentReaction.reaction_type) {
          case 'like':
            postReactionIcons.add(const Image(
                height: 24, width: 24, image: AssetImage(AppAssets.LIKE_ICON)));
            break;
          case 'love':
            postReactionIcons.add(const Image(
                height: 24, width: 24, image: AssetImage(AppAssets.LOVE_ICON)));
            break;
          case 'haha':
            postReactionIcons.add(const Image(
                height: 24, width: 24, image: AssetImage(AppAssets.HAHA_ICON)));
            break;
          case 'wow':
            postReactionIcons.add(const Image(
                height: 24, width: 24, image: AssetImage(AppAssets.WOW_ICON)));
            break;
          case 'sad':
            postReactionIcons.add(const Image(
                height: 24, width: 24, image: AssetImage(AppAssets.SAD_ICON)));
            break;
          case 'angry':
            postReactionIcons.add(const Image(
                height: 24,
                width: 24,
                image: AssetImage(AppAssets.ANGRY_ICON)));
            break;
          case 'unlike':
            postReactionIcons.add(const Image(
                height: 24,
                width: 24,
                image: AssetImage(AppAssets.UNLIKE_ICON)));
            break;
          default:
            postReactionIcons.add(const Image(
                height: 24, width: 24, image: AssetImage(AppAssets.LIKE_ICON)));
            break;
        }
      }
    }

    List<Image> reactionImageList = postReactionIcons.toList();

    if (reactionImageList.length > 3) {
      return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: reactionImageList.getRange(1, 3).toList());
    } else {
      return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: reactionImageList);
    }
  }

Widget ReplayReactionIcons(CommentReplay commentReplay) {
    List<Image> postReactionIcons = [];
    if (commentReplay.replies_comment_reactions != null) {
      for (RepliesCommentReaction repliesCommentReaction
          in commentReplay.replies_comment_reactions!) {
        if (repliesCommentReaction.reaction_type == '') {}
        switch (repliesCommentReaction.reaction_type) {
          case 'like':
            postReactionIcons.add(const Image(
                height: 24, width: 24, image: AssetImage(AppAssets.LIKE_ICON)));
            break;
          case 'love':
            postReactionIcons.add(const Image(
                height: 24, width: 24, image: AssetImage(AppAssets.LOVE_ICON)));
            break;
          case 'haha':
            postReactionIcons.add(const Image(
                height: 24, width: 24, image: AssetImage(AppAssets.HAHA_ICON)));
            break;
          case 'wow':
            postReactionIcons.add(const Image(
                height: 24, width: 24, image: AssetImage(AppAssets.WOW_ICON)));
            break;
          case 'sad':
            postReactionIcons.add(const Image(
                height: 24, width: 24, image: AssetImage(AppAssets.SAD_ICON)));
            break;
          case 'angry':
            postReactionIcons.add(const Image(
                height: 24,
                width: 24,
                image: AssetImage(AppAssets.ANGRY_ICON)));
            break;
          case 'unlike':
            postReactionIcons.add(const Image(
                height: 24,
                width: 24,
                image: AssetImage(AppAssets.UNLIKE_ICON)));
            break;
          default:
            postReactionIcons.add(const Image(
                height: 24, width: 24, image: AssetImage(AppAssets.LIKE_ICON)));
            break;
        }
      }
    }

    List<Image> reactionImageList = postReactionIcons.toList();

    if (reactionImageList.length > 3) {
      return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: reactionImageList.getRange(1, 3).toList());
    } else {
      return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: reactionImageList);
    }
  }
