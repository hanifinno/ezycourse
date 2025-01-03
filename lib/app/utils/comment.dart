import 'package:ezycourse/app/components/comment/comment_model.dart';
import 'package:ezycourse/app/components/reaction_button/comment_reaction_model.dart';
import 'package:flutter/material.dart';
import '../config/app_assets.dart';

Widget CommentReactionIcons(CommentModel commentModel) {
    Set<Image> postReactionIcons = {};
    if (commentModel.reactionTypes != null) {
      for (CommentReactionModel commentReaction in commentModel.reactionTypes!) {
        if (commentReaction.reaction_type == '') {}
        switch (commentReaction.reaction_type?.toLowerCase()) {
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

Widget ReplayReactionIcons(CommentModel commentReplay) {
    List<Image> postReactionIcons = [];
    if (commentReplay.reactionTypes != null) {
      for (CommentReactionModel repliesCommentReaction
          in commentReplay.reactionTypes!) {
        if (repliesCommentReaction.reaction_type == '') {}
        switch (repliesCommentReaction.reaction_type?.toLowerCase()) {
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
