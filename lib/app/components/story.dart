import 'package:flutter/material.dart';
import '../models/merge_story.dart';
import '../models/story.dart';
import '../utils/date_time.dart';
import '../utils/image.dart';
import 'image.dart';

class MyDayCard extends StatelessWidget {
  const MyDayCard({
    super.key,
    required this.storyMergeModel,
    required this.onTapStoryCard,
  });

  final StoryMergeModel storyMergeModel;
  final VoidCallback onTapStoryCard;

  @override
  Widget build(BuildContext context) {
    // UserModelId userModelId = storyMergeModel.!;
    return InkWell(
      onTap: onTapStoryCard,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: RoundCornerNetworkImage(
                height: 120,
                width: 80,
                imageUrl: getFormatedStoryUrl(
                    storyMergeModel.stories?[0].media ?? '')),
          ),
          Positioned(
            left: 35,
            top: 95,
            child: CircleAvatar(
              radius: 19,
              backgroundColor: const Color.fromARGB(255, 45, 185, 185),
              child: CircleAvatar(
                radius: 17,
                backgroundImage: NetworkImage(
                    getFormatedProfileUrl(storyMergeModel.profile_pic ?? '')),
              ),
            ),
          ),
          Positioned(
            top: 130,
            left: 0,
            right: 0,
            child: Text(
              storyMergeModel.first_name ?? '',
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }

  String storyTimeText(StoryModel storyModel) {
    DateTime postDateTime =
        DateTime.parse(storyModel.createdAt ?? '').toLocal();
    DateTime currentDatetime = DateTime.now();
    // Calculate the difference in milliseconds
    int millisecondsDifference = currentDatetime.millisecondsSinceEpoch -
        postDateTime.millisecondsSinceEpoch;
    // Convert to minutes (ignoring milliseconds)
    int minutesDifference =
        (millisecondsDifference / Duration.millisecondsPerMinute).truncate();

    if (minutesDifference < 1) {
      return 'a few seconds ago';
    } else if (minutesDifference < 30) {
      return '$minutesDifference minutes ago';
    } else if (DateUtils.isSameDay(postDateTime, currentDatetime)) {
      return 'Today at ${postTimeFormate.format(postDateTime)}';
    } else {
      return postDateTimeFormate.format(postDateTime);
    }
  }
}
