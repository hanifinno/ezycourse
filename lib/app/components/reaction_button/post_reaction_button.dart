import 'package:ezycourse/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:reaction_button/reaction_button.dart';

import '../../config/app_assets.dart';
import '../../models/post.dart' as post;

const double width = 32;

const selectedViewTextStyle = TextStyle(fontSize: 15);
const SelectedViewGap = SizedBox(width: 5);

final postReactions = [
  ReactionModel(
    value: 'LIKE',
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
    value: 'LOVE',
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
    value: 'HAHA',
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
    value: 'WOW',
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
    value: 'SAD',
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
    value: 'ANGRY',
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
  for (post.LikeTypeModel reactionModel
      in postModel.likeType ?? []) {
    // if (reactionModel.user_id == userId) {
      return getReactionModelAsType(reactionModel.reactionType?.toLowerCase()?? '');
    // }
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
