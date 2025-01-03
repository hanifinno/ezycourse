import 'package:flutter/material.dart';
import 'package:reaction_button/reaction_button.dart';

import '../../config/app_assets.dart';
import '../../models/post.dart' as post;

const double width = 32;

const selectedViewTextStyle = TextStyle(fontSize: 15);
const SelectedViewGap = SizedBox(width: 5);

final postReactions = [
  ReactionModel(
    value: 'like',
    initialView: const Image(
      width: width,
      image: AssetImage(AppAssets.LIKE_ICON),
    ),
    selectedView: const Row(
      children: [
        Image(
          width: width,
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
          width: width,
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
          width: width,
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
          width: width,
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
          width: width,
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
          width: width,
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
          width: width,
          image: AssetImage(AppAssets.UNLIKE_ICON),
        ),
        SelectedViewGap,
        Text('Unlike', style: selectedViewTextStyle),
      ],
    ),
  ),
];

class PostReactionButton extends StatelessWidget {
  final ReactionModel? selectedReaction;
  final Function(ReactionModel reaction) onChangedReaction;

  const PostReactionButton({
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
            Image(
              width: 25,
              image: AssetImage(AppAssets.LIKE_ACTION_ICON),
            ),
            SizedBox(width: 10),
            Text(
              'Like',
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
        selectedView: const Row(
          children: [
            Image(
              width: 25,
              image: AssetImage(AppAssets.LIKE_ICON),
            ),
            Text(
              'Like',
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
      selectedReaction: selectedReaction,
      reactions: postReactions,
      onChangedReaction: onChangedReaction,
    );
  }
}

ReactionModel? getSelectedPostReaction(
    post.PostModel postModel, String userId) {
  for (post.ReactionModel reactionModel
      in postModel.reactionTypeCountsByPost ?? []) {
    if (reactionModel.user_id == userId) {
      return getReactionModelAsType(reactionModel.reaction_type ?? '');
    }
  }

  return null;
}

ReactionModel? getReactionModelAsType(String type) {
  for (ReactionModel reactionModel in postReactions) {
    if (reactionModel.value == type) {
      return reactionModel;
    }
  }
  return null;
}
