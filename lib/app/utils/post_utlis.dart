import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';



import '../config/app_assets.dart';

import 'date_time.dart';

String getReactionIconPath(String reactionType) {
  switch (reactionType) {
    case 'like':
      return AppAssets.LIKE_ICON;
    case 'love':
      return AppAssets.LOVE_ICON;
    case 'haha':
      return AppAssets.HAHA_ICON;
    case 'wow':
      return AppAssets.WOW_ICON;
    case 'sad':
      return AppAssets.SAD_ICON;
    case 'angry':
      return AppAssets.ANGRY_ICON;
    case 'unlike':
      return AppAssets.UNLIKE_ICON;
    default:
      return AppAssets.LIKE_ICON;
  }
}

String getDynamicFormatedTime(String time) {
  DateTime postDateTime = DateTime.parse(time).toLocal();
  DateTime currentDatetime = DateTime.now();
  // Calculate the difference in milliseconds
  int millisecondsDifference = currentDatetime.millisecondsSinceEpoch -
      postDateTime.millisecondsSinceEpoch;
  // Convert to minutes (ignoring milliseconds)
  int minutesDifference =
      (millisecondsDifference / Duration.millisecondsPerMinute).truncate();

  if (minutesDifference < 1) {
    return 'Just now';
  } else if (minutesDifference < 30) {
    return '$minutesDifference minutes ago';
  } else if (DateUtils.isSameDay(postDateTime, currentDatetime)) {
    return 'Today at ${postTimeFormate.format(postDateTime)}';
  } else {
    return postDateTimeFormate.format(postDateTime);
  }
}

String getDynamicFormatedCommentTime(String time) {
  DateTime postDateTime = DateTime.parse(time).toLocal();
  DateTime currentDatetime = DateTime.now();
  // Calculate the difference in milliseconds
  int millisecondsDifference = currentDatetime.millisecondsSinceEpoch -
      postDateTime.millisecondsSinceEpoch;
  // Convert to minutes (ignoring milliseconds)
  int minutesDifference =
      (millisecondsDifference / Duration.millisecondsPerMinute).truncate();

  if (minutesDifference <= 1) {
    return 'Just now';
  } else if (minutesDifference <= 30) {
    return '$minutesDifference min';
  } else if (minutesDifference <= 1440 && minutesDifference > 30) {
    return '${(minutesDifference / 60).floor()} h';
  } else if (minutesDifference <= 2879 && minutesDifference > 1440) {
    return '${(minutesDifference / 1440).floor()} day ago';
  } else if (minutesDifference <= 43200 && minutesDifference > 1440) {
    return '${(minutesDifference / 1440).floor()} days ago';
  }
  // else if (DateUtils.isSameDay(postDateTime, currentDatetime)) {
  //   return '${postTimeFormate.format(postDateTime)}';
  // }

  else {
    return postDateTimeFormate.format(postDateTime);
  }
}

List<TextSpan> getTextWithLink(String text) {
  List<String> textList = text.split(' ');
  List<TextSpan> textWithLink = [];
  for (String splitText in textList) {
    if (splitText.startsWith('http')) {
      textWithLink.add(
        TextSpan(
          text: splitText,
          style: const TextStyle(
            color: Colors.blue,
          ),
        ),
      );
    } else {
      textWithLink.add(
        TextSpan(
          text: splitText,
          style: const TextStyle(
            color: Colors.blue,
          ),
        ),
      );
    }
  }
  return textWithLink;
}


// Reaction<String>? getSelectedReaction(PostModel postModel) {
//   LoginCredential credential = LoginCredential();
//   UserModel userModel = credential.getUserData();
  
//   if (postModel.reactionTypeCountsByPost != null) {
//     for (ReactionModel reactionModel in postModel.reactionTypeCountsByPost!) {
//       if (reactionModel.user_id == userModel.id) {
//         return Reaction<String>(
//           value: reactionModel.reaction_type,
//           icon: Row(
//             children: [
//               ReactionIcon(
//                   getReactionIconPath(reactionModel.reaction_type ?? '')),
//               const SizedBox(width: 10),
//               Text(reactionModel.reaction_type?.capitalizeFirst ?? '',
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.grey.shade700,
//                   ))
//             ],
//           ),
//         );
//       }
//     }
//   }
//   return Reaction<String>(
//     value: 'like',
//     icon: Row(
//       children: [
//         ReactionIcon(AppAssets.LIKE_ACTION_ICON),
//         const SizedBox(width: 10),
//         Text('Like',
//             style: TextStyle(
//               fontSize: 18,
//               color: Colors.grey.shade700,
//             ))
//       ],
//     ),
//   );
// }

Widget ReactionIcon(String assetName, {double? height = 32}) {
  return Image(height: height ?? 32, image: AssetImage(assetName));
}

String getPostPrivacyValue(String titile) {
  switch (titile) {
    case 'Public':
      return 'public';
    case 'Friends':
      return 'friends';
    case 'Only Me':
      return 'only_me';
    default:
      return 'public';
  }
}
String getReelsPostPrivacyValue(String titile) {
  switch (titile) {
    case 'Public':
      return 'public';
    case 'Friends':
      return 'friends';
    case 'Only Me':
      return 'only_me';
    default:
      return 'public';
  }
}