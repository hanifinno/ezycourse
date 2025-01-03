import 'package:flutter/material.dart';
import '../../models/comment_model.dart';
import 'package:reaction_button/reaction_button.dart';

import '../../config/app_assets.dart';

const double selectedViewImagewidth = 24;
const double width = 32;

const selectedViewTextStyle = TextStyle(fontSize: 16);
const SelectedViewGap = SizedBox(width: 5);

final commentReactions = [
  ReactionModel(
    value: 'like',
    initialView: const Image(
      width: width,
      image: AssetImage(AppAssets.LIKE_ICON),
    ),
    selectedView: const Row(
      children: [
        Image(
          width: selectedViewImagewidth,
          image: AssetImage(AppAssets.LIKE_ICON),
        ),
        SelectedViewGap,
        Text('Like', style: selectedViewTextStyle),
      ],
    ),
  ),
  ReactionModel(
    value: 'love',
    initialView: const Image(
      width: width,
      image: AssetImage(AppAssets.LOVE_ICON),
    ),
    selectedView: const Row(
      children: [
        Image(
          width: selectedViewImagewidth,
          image: AssetImage(AppAssets.LOVE_ICON),
        ),
        SelectedViewGap,
        Text('Love', style: selectedViewTextStyle),
      ],
    ),
  ),
  ReactionModel(
    value: 'haha',
    initialView: const Image(
      width: width,
      image: AssetImage(AppAssets.HAHA_ICON),
    ),
    selectedView: const Row(
      children: [
        Image(
          width: selectedViewImagewidth,
          image: AssetImage(AppAssets.HAHA_ICON),
        ),
        SelectedViewGap,
        Text('Haha', style: selectedViewTextStyle),
      ],
    ),
  ),
  ReactionModel(
    value: 'wow',
    initialView: const Image(
      width: width,
      image: AssetImage(AppAssets.WOW_ICON),
    ),
    selectedView: const Row(
      children: [
        Image(
          width: selectedViewImagewidth,
          image: AssetImage(AppAssets.WOW_ICON),
        ),
        SelectedViewGap,
        Text('Wow', style: selectedViewTextStyle),
      ],
    ),
  ),
  ReactionModel(
    value: 'sad',
    initialView: const Image(
      width: width,
      image: AssetImage(AppAssets.SAD_ICON),
    ),
    selectedView: const Row(
      children: [
        Image(
          width: selectedViewImagewidth,
          image: AssetImage(AppAssets.SAD_ICON),
        ),
        SelectedViewGap,
        Text('Sad', style: selectedViewTextStyle),
      ],
    ),
  ),
  ReactionModel(
    value: 'angry',
    initialView: const Image(
      width: width,
      image: AssetImage(AppAssets.ANGRY_ICON),
    ),
    selectedView: const Row(
      children: [
        Image(
          width: selectedViewImagewidth,
          image: AssetImage(AppAssets.ANGRY_ICON),
        ),
        SelectedViewGap,
        Text('Angry', style: selectedViewTextStyle),
      ],
    ),
  ),
  ReactionModel(
    value: 'unlike',
    initialView: const Image(
      width: width,
      image: AssetImage(AppAssets.UNLIKE_ICON),
    ),
    selectedView: const Row(
      children: [
        Image(
          width: selectedViewImagewidth,
          image: AssetImage(AppAssets.UNLIKE_ICON),
        ),
        SelectedViewGap,
        Text('Unlike', style: selectedViewTextStyle),
      ],
    ),
  ),
];

class CommentReactionButton extends StatelessWidget {
  final ReactionModel? selectedReaction;
  final Function(ReactionModel reaction) onChangedReaction;

  const CommentReactionButton({
    super.key,
    required this.onChangedReaction,
    this.selectedReaction,
  });

  @override
  Widget build(BuildContext context) {
    return ReactionButton(
      placeHolder: ReactionModel(
        value: 'like',
        initialView: const Row(
          children: [
            Text(
              'Like',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        selectedView: const Row(
          children: [
            Image(
              width: 32,
              image: AssetImage(AppAssets.LIKE_ICON),
            ),
            Text('Like'),
          ],
        ),
      ),
      selectedReaction: selectedReaction,
      reactions: commentReactions,
      onChangedReaction: onChangedReaction,
    );
  }
}

ReactionModel? getSelectedCommentReaction(
  CommentModel commentModel,
  String userId,
) {
  List<CommentReaction> commentReactions =
      commentModel.comment_reactions ?? [];
  CommentReaction commentReaction = commentReactions.firstWhere(
      (commentReaction) => commentReaction.user_id == userId,
      orElse: () => CommentReaction(v: -1));

  if ((commentReaction.v ?? 0) != -1) {
    return getReactionModelAsType(commentReaction.reaction_type ?? '');
  }

  return null;
}

ReactionModel? getSelectedCommentReplayReaction(
  CommentReplay commentReplay,
  String userId,
) {
  List<RepliesCommentReaction> commentReplayReactions =
      commentReplay.replies_comment_reactions ?? [];
  RepliesCommentReaction commentReplayReaction =
      commentReplayReactions.firstWhere(
          (commentReplayReaction) => commentReplayReaction.user_id == userId,
          orElse: () => RepliesCommentReaction(v: -1));

  if ((commentReplayReaction.v ?? 0) != -1) {
    return getReactionModelAsType(commentReplayReaction.reaction_type ?? '');
  }

  return null;
}

ReactionModel? getReactionModelAsType(String type) {
  for (ReactionModel reactionModel in commentReactions) {
    if (reactionModel.value == type) {
      return reactionModel;
    }
  }
  return null;
}
