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
                  (model.likeType?.length ?? 0) > 0
                      ? Text(' ${model.likeCount}')
                      : const Text(' No reaction'),
                ],
              ),
            ),
            InkWell(
                onTap: onPressedComment,
                child: Text('${model.commentCount} Comments ')),
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
  if (postModel.likeCount != null) {
    for (LikeTypeModel reactionModel in postModel.likeType!) {
      if (reactionModel.reactionType == '') {}
      switch (reactionModel.reactionType) {
        case 'LIKE':
          postReactionIcons.add(const Image(
              height: 24, width: 24, image: AssetImage(AppAssets.LIKE_ICON)));
          break;
        case 'LOVE':
          postReactionIcons.add(const Image(
              height: 24, width: 24, image: AssetImage(AppAssets.LOVE_ICON)));
          break;
        case 'HAHA':
          postReactionIcons.add(const Image(
              height: 24, width: 24, image: AssetImage(AppAssets.HAHA_ICON)));
          break;
        case 'WOW':
          postReactionIcons.add(const Image(
              height: 24, width: 24, image: AssetImage(AppAssets.WOW_ICON)));
          break;
        case 'SAD':
          postReactionIcons.add(const Image(
              height: 24, width: 24, image: AssetImage(AppAssets.SAD_ICON)));
          break;
        case 'ANGRY':
          postReactionIcons.add(const Image(
              height: 24, width: 24, image: AssetImage(AppAssets.ANGRY_ICON)));
          break;
        case 'UNLIKE':
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

