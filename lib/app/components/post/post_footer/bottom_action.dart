import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../reaction_button/post_reaction_button.dart';
import '../../../data/login_creadential.dart';

import '../../../config/app_assets.dart';
import '../../../models/post.dart';
import '../../button.dart';

class BottomAction extends StatelessWidget {
  const BottomAction({
    super.key,
    required this.onSelectReaction,
    required this.onPressedComment,
    required this.onPressedShare,
    required this.model,
  });
  final Function(String reaction) onSelectReaction;
  final VoidCallback onPressedComment;
  final VoidCallback onPressedShare;
  final PostModel model;

  @override
  Widget build(BuildContext context) {
    final LoginCredential loginCredential = LoginCredential();

    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              PostReactionButton(
                selectedReaction: getSelectedPostReaction(
                    model, loginCredential.getUserData().id ?? ''),
                onChangedReaction: (reaction) {
                  onSelectReaction(reaction.value);
                },
              ),
            ],
          ),
        ),
        PostActionButton(
          assetName: AppAssets.COMMENT_ACTION_ICON,
          text: 'Comment',
          onPressed: onPressedComment,
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              (model.post_privacy == 'friends' &&
                      (loginCredential.getUserData().id != model.user_id?.id))
                  ? PostActionButton(
                      assetName: AppAssets.COPY_ACTION_ICON,
                      text: 'Copy Link',
                      onPressed: () async {
                        await Clipboard.setData(ClipboardData(
                            text:
                                'https://quantumpossibilities.eu/notification/${model.id}'));
                      },
                    )
                  : PostActionButton(
                      assetName: AppAssets.SHARE_ACTION_ICON,
                      text: 'Share',
                      onPressed: onPressedShare,
                    ),
            ],
          ),
        )
      ],
    );
  }

  Widget ReactionIcon(String assetName) {
    return Image(height: 24, image: AssetImage(assetName));
  }
}
