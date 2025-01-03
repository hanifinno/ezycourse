import 'package:flutter/material.dart';
import '../../../config/app_assets.dart';
import '../../../models/post.dart';
import 'bottom_action.dart';

class PostFooter extends StatelessWidget {
  const PostFooter({
    super.key,
    required this.model,
    required this.onSelectReaction,
    required this.onPressedComment,
    required this.onPressedShare,
    required this.onTapViewReactions,
  });

  final PostModel model;
  final Function(String reaction) onSelectReaction;
  final VoidCallback onPressedComment;
  final VoidCallback onPressedShare;
  final VoidCallback onTapViewReactions;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 5),
            InkWell(onTap: onTapViewReactions, child: PostReactionIcons(model)),
            Expanded(
              child: Row(
                children: [
                  (model.reactionCount ?? 0) > 0
                      ? Text(' ${model.reactionCount}')
                      : const Text(' No reaction'),
                ],
              ),
            ),
            InkWell(
                onTap: onPressedComment,
                child: Text('${model.totalComments} Comments ')),
          ],
        ),
        const Divider(),
        BottomAction(
          onSelectReaction: onSelectReaction,
          onPressedComment: onPressedComment,
          onPressedShare: onPressedShare,
          model: model,
        ),
        Container(
          height: 10,
          decoration: BoxDecoration(color: Colors.grey.shade300),
        )
      ],
    );
  }
}

//=============================================================== Post Reaction List

Widget PostReactionIcons(PostModel postModel) {
  Set<Image> postReactionIcons = {};
  if (postModel.reactionTypeCountsByPost != null) {
    for (ReactionModel reactionModel in postModel.reactionTypeCountsByPost!) {
      if (reactionModel.reaction_type == '') {}
      switch (reactionModel.reaction_type) {
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
              height: 24, width: 24, image: AssetImage(AppAssets.ANGRY_ICON)));
          break;
        case 'unlike':
          postReactionIcons.add(const Image(
              height: 24, width: 24, image: AssetImage(AppAssets.UNLIKE_ICON)));
          break;
        default:
          postReactionIcons.add(const Image(
              height: 24, width: 24, image: AssetImage(AppAssets.LIKE_ICON)));
          break;
      }
    }
  }

  List<Image> postReactionList = postReactionIcons.toList();
  if (postReactionList.length > 3) {
    return Row(children: postReactionList.getRange(0, 2).toList());
  } else {
    return Row(children: postReactionList);
  }
}

//=============================================================== Like, Comment, Share button

