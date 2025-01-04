import 'package:carousel_slider/carousel_slider.dart' as slider;
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../config/app_assets.dart';
import '../../../models/media.dart';
import '../../../models/post.dart';
import '../../../models/share_post_id.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/color.dart';
import '../../../utils/color_func.dart';
import '../../../utils/date_time.dart';
import '../../../utils/file.dart';
import '../../../utils/image.dart';
import '../../../utils/post_utlis.dart';
import '../../../utils/url_launcher.dart';
import '../../image.dart';
import '../../single_image.dart';
import '../../video_player.dart';
import '../media_grid/media_grid.dart';

class PostBodyView extends StatelessWidget {
  const PostBodyView(
      {super.key,
      required this.model,
      this.adVideoLink,
      this.campaignWebUrl,
      this.actionButtonText,
      this.campaignName,
      this.campaignDescription,
      this.campaignCallToAction,
      required this.onTapBodyViewMoreMedia,
      this.onTapViewOtherProfile,
      required this.onSixSeconds,
      this.onTapShareViewOtherProfile});
  final PostModel model;
  final VoidCallback onTapBodyViewMoreMedia;
  final VoidCallback? onTapViewOtherProfile;
  final VoidCallback? onTapShareViewOtherProfile;
  final VoidCallback onSixSeconds;
  final String? adVideoLink;
  final String? campaignWebUrl;
  final String? campaignName;
  final String? actionButtonText;
  final String? campaignDescription;
  final VoidCallback? campaignCallToAction;

  @override
  Widget build(BuildContext context) {
    switch (model.fileType) {
      case 'text':
        return TimelinePost(
          campaignCallToAction: campaignCallToAction,
          campaignDescription: campaignDescription,
          campaignName: campaignName,
          campaignWebUrl: campaignWebUrl,
          actionButtonText: actionButtonText,
          onSixSeconds: onSixSeconds,
          adVideoLink: adVideoLink,
          postModel: model,
          onTapViewMoreMedia: onTapBodyViewMoreMedia,
          onTapViewOtherProfile: onTapViewOtherProfile ?? () {},
        );

      case 'photos':
        return ProfilePicturePost(postModel: model);

      default:
        return Container();
    }
  }
}

//=============================================================== TimeLine Post

class TimelinePost extends StatelessWidget {
  const TimelinePost(
      {super.key,
      required this.postModel,
      required this.onTapViewMoreMedia,
      required this.onSixSeconds,
      this.campaignWebUrl,
      this.campaignName,
      this.campaignDescription,
      this.campaignCallToAction,
      this.adVideoLink,
      this.actionButtonText,
      required this.onTapViewOtherProfile});

  final PostModel postModel;
  final VoidCallback onTapViewMoreMedia;
  final VoidCallback onTapViewOtherProfile;
  final VoidCallback onSixSeconds;
  final String? adVideoLink;
  final String? campaignWebUrl;
  final String? campaignName;
  final String? campaignDescription;
  final String? actionButtonText;
  final VoidCallback? campaignCallToAction;

  @override
  Widget build(BuildContext context) {
    List<String> imageUrls = [];

    // for (MediaModel media in postModel.media ?? []) {
    //   imageUrls.add(getFormatedPostUrl(media.media ?? ''));
    // }

    return ((postModel.files?.length ?? 0) > 0)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              (postModel.feedTxt?.isNotEmpty ?? true)
                  ? Padding(
                      padding: const EdgeInsets.only(left: 5, bottom: 10),
                      child: ExpandableText(
                        postModel.feedTxt ?? '',
                        expandText: 'See more',
                        maxLines: 5,
                        collapseText: 'see less',
                        style: const TextStyle(color: Colors.black),
                      ),
                    )
                  : const SizedBox(),
              ((postModel.files?.length ?? 0) > 1)
                  ? SizedBox(
                      height: 500,
                      child: MediaGridView(
                          mediaUrls: imageUrls,
                          onTapViewMoreMedia: onTapViewMoreMedia),
                    )
                  : isImageUrl(imageUrls[0])
                      ? InkWell(
                          onTap: onTapViewMoreMedia,
                          child: PrimaryNetworkImage(imageUrl: imageUrls[0]))
                      : SizedBox(
                          height: 250,
                          // child: CustomVideoPlayer(
                          //   postId: postModel.id ?? '',
                          //   videoLink: imageUrls[0],
                          //   adVideoLink: adVideoLink,
                          //   campaignCallToAction: campaignCallToAction,
                          //   campaignDescription: campaignDescription,
                          //   campaignName: campaignName,
                          //   campaignWebUrl: campaignWebUrl,
                          //   actionButtonText: actionButtonText,
                          // ),
                        ),
            ],
          )
        : ((postModel.files?.length ?? 0) == 0)
            ? Container(
                height:
                    (postModel.bgColor != null && postModel.bgColor!.isNotEmpty)
                        ? 280
                        : null, 
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: (postModel.bgColor != null &&
                          postModel.bgColor!.isNotEmpty)
                      ? parseBgColor(postModel.bgColor!) ??
                          Colors
                              .transparent 
                      : Colors
                          .transparent, 
                ),
                padding: const EdgeInsets.all(10),
                child:
                    (postModel.bgColor != null && postModel.bgColor!.isNotEmpty)
                        ? Center(
                            child: Text(
                              postModel.feedTxt ?? '',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 24),
                            ),
                          )
                        : ExpandableText(
                            postModel.feedTxt ?? '',
                            expandText: 'See more',
                            maxLines: 5,
                            collapseText: 'see less',
                            style: const TextStyle(color: Colors.black),
                          ),
              )
            : Column(
                //======================================================== Showing Link Post ========================================================//
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: RichText(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                            children:
                                getTextWithLink(postModel.feedTxt ?? ''))),
                  ),
                  GestureDetector(
                      onTap: () async {
                        String url = postModel.feedTxt.toString();
                        await launchUrl(Uri.parse(url));
                      },
                      child: PrimaryNetworkImage(
                          imageUrl: postModel.files?.first.fileLoc ?? '')),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.grey.shade300),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          postModel.title ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ExpandableText(
                          postModel.feedTxt ?? '',
                          expandText: 'See more',
                          maxLines: 5,
                          collapseText: 'see less',
                          style: const TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                  )
                ],
              );
  }
}

//======================== Shared Timeline Post Line ========================//

//=============================================================== Page Post

//=============================================================== Profile Picture Post

class ProfilePicturePost extends StatelessWidget {
  const ProfilePicturePost({
    super.key,
    required this.postModel,
  });

  final PostModel postModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => SingleImage(
            imgURL: getFormatedPostUrl(postModel.files?[0].fileLoc ?? '')));
      },
      child: NetworkCircleAvatar(
        radius: 128,
        imageUrl: getFormatedPostUrl(postModel.files?[0].fileLoc ?? ''),
      ),
    );
  }
}

String getDynamicFormatedTime(String time) {
  // print("time of date ........."+time);

  DateTime postDateTime;
  if (time.toString() == 'null' || time.isEmpty || time.toString() == '') {
    postDateTime = DateTime.now().toLocal();
  } else {
    postDateTime = DateTime.parse(time).toLocal();
  }
  return productDateTimeFormate.format(postDateTime);
}
