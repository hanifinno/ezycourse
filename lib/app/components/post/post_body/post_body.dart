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
    switch (model.post_type) {
      case 'timeline_post':
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
      case 'page_post':
        return PagePost(
          postModel: model,
          onTapViewMoreMedia: onTapBodyViewMoreMedia,
        );
      case 'profile_picture':
        return ProfilePicturePost(postModel: model);
      case 'cover_picture':
        return CoverPicturePost(postModel: model);
      case 'event':
        return EventPost(postModel: model);
      case 'shared_reels':
        return SharedReelsPost(postModel: model);
      case 'birthday':
        return BirthdayPost(postModel: model);
      case 'campaign':
        return CampaignPost(postModel: model);
      case 'group_file':
        return GroupFilePost(postModel: model);
      case 'Shared':
        return SharedPost(
          postModel: model,
          onTapViewMoreMedia: onTapBodyViewMoreMedia,
          onTapShareViewOtherProfile: onTapShareViewOtherProfile ?? () {},
        );
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

    for (MediaModel media in postModel.media ?? []) {
      imageUrls.add(getFormatedPostUrl(media.media ?? ''));
    }

    return (postModel.event_type?.isNotEmpty ?? false)
        ?
        //======================================================== Showing Event Post ========================================================//
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [getEventIcon(postModel)],
              ),
              postModel.event_type == 'travel'
                  ? Padding(
                      padding: const EdgeInsets.only(
                          top: 5.0, left: 8.0, right: 8.0),
                      child: ExpandableText(
                        postModel.lifeEventId?.title ?? '',
                        expandText: 'See more',
                        maxLines: 5,
                        collapseText: 'see less',
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ))
                  : Container(),
              postModel.event_type == 'customevent'
                  ? Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        textAlign: TextAlign.center,
                        getCustomEventText(postModel),
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    )
                  : postModel.event_type == 'milestonesandachievements'
                      ? Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            textAlign: TextAlign.center,
                            getMilestonEventText(postModel),
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        )
                      : postModel.event_type == 'travel'
                          ? Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Text(
                                textAlign: TextAlign.center,
                                getTravelEventText(postModel),
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            )
                          : postModel.event_type == 'relationship'
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: InkWell(
                                    onTap: onTapViewOtherProfile,
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      getRelationEventText(postModel),
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              : postModel.event_type == 'education'
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        getEducationEventText(postModel),
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Text(
                                          textAlign: TextAlign.center,
                                          getWorkEventText(postModel),
                                          style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold)),
                                    ),
              const SizedBox(
                height: 3,
              ),
              postModel.event_type == 'customevent'
                  ? Text(
                      getDynamicFormatedTime(
                          postModel.lifeEventId?.date.toString() ?? ''),
                      style: TextStyle(
                        fontSize: Get.height * 0.015,
                      ),
                    )
                  : postModel.event_type == 'milestonesandachievements'
                      ? Text(
                          getDynamicFormatedTime(
                              postModel.lifeEventId?.date.toString() ?? ''),
                          style: TextStyle(
                            fontSize: Get.height * 0.015,
                          ),
                        )
                      : postModel.event_type == 'travel'
                          ? Text(
                              getDynamicFormatedTime(
                                  postModel.lifeEventId?.date.toString() ?? ''),
                              style: TextStyle(
                                fontSize: Get.height * 0.015,
                              ),
                            )
                          : postModel.event_type == 'relationship'
                              ? Text(
                                  getDynamicFormatedTime(
                                      postModel.lifeEventId?.date.toString() ??
                                          ''),
                                  style: TextStyle(
                                    fontSize: Get.height * 0.015,
                                  ),
                                )
                              : postModel.event_type == 'education'
                                  ? Text(
                                      postModel.event_sub_type!
                                              .contains('New School')
                                          ? getDynamicFormatedTime(postModel
                                                  .institute_id?.startDate ??
                                              '')
                                          : postModel.event_sub_type!
                                                  .contains('Graduate')
                                              ? getDynamicFormatedTime(postModel
                                                      .institute_id?.endDate ??
                                                  '')
                                              : getDynamicFormatedTime(postModel
                                                      .institute_id?.endDate ??
                                                  ''),
                                      style: TextStyle(
                                        fontSize: Get.height * 0.015,
                                      ),
                                    )
                                  : Text(
                                      postModel.event_sub_type!
                                              .contains('New Job')
                                          ? getDynamicFormatedTime(postModel
                                                  .workplace_id?.fromDate ??
                                              '')
                                          : postModel.event_sub_type!
                                                  .contains('Promotion')
                                              ? getDynamicFormatedTime(postModel
                                                      .workplace_id?.fromDate ??
                                                  '')
                                              : postModel.event_sub_type!
                                                      .contains('Left Job')
                                                  ? getDynamicFormatedTime(
                                                      postModel.workplace_id
                                                              ?.toDate ??
                                                          '')
                                                  : getDynamicFormatedTime(
                                                      postModel.workplace_id
                                                              ?.toDate ??
                                                          ''),
                                      style: TextStyle(
                                        fontSize: Get.height * 0.015,
                                      )),
              postModel.event_type == 'relationship' ||
                      postModel.event_type == 'travel' ||
                      postModel.event_type == 'milestonesandachievements' ||
                      postModel.event_type == 'customevent'
                  ? Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Stack(
                        children: [
                          const Divider(
                            height: 50,
                            color: Colors.grey,
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 0,
                            bottom: 0,
                            child: Align(
                                alignment: Alignment.center,
                                child: getEventIcon(postModel,
                                    height: 32, width: 32)),
                          )
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Stack(
                        children: [
                          const Divider(
                            height: 50,
                            color: Colors.grey,
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 0,
                            bottom: 0,
                            child: Align(
                                alignment: Alignment.center,
                                child: getEventIcon(postModel,
                                    height: 32, width: 32)),
                          )
                        ],
                      ),
                    ),
              postModel.event_type == 'relationship' ||
                      postModel.event_type == 'travel' ||
                      postModel.event_type == 'milestonesandachievements' ||
                      postModel.event_type == 'customevent'
                  ? Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: ExpandableText(
                        postModel.lifeEventId?.description ?? '',
                        expandText: 'See more',
                        maxLines: 5,
                        collapseText: 'see less',
                        style: const TextStyle(color: Colors.black),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: ExpandableText(
                        postModel.description ?? '',
                        expandText: 'See more',
                        maxLines: 5,
                        collapseText: 'see less',
                        style: const TextStyle(color: Colors.black),
                      ),
                    )
            ],
          )
        : postModel.link_image == null || postModel.link_image == ''
            //======================================================== Showing Video with Description Post ========================================================//

            ? ((postModel.media?.length ?? 0) > 0)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      (postModel.description?.isNotEmpty ?? true)
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(left: 5, bottom: 10),
                              child: ExpandableText(
                                postModel.description ?? '',
                                expandText: 'See more',
                                maxLines: 5,
                                collapseText: 'see less',
                                style: const TextStyle(color: Colors.black),
                              ),
                            )
                          : const SizedBox(),
                      ((postModel.media?.length ?? 0) > 1)
                          ? SizedBox(
                              height: 500,
                              child: MediaGridView(
                                  mediaUrls: imageUrls,
                                  onTapViewMoreMedia: onTapViewMoreMedia),
                            )
                          : isImageUrl(imageUrls[0])
                              ? InkWell(
                                  onTap: onTapViewMoreMedia,
                                  child: PrimaryNetworkImage(
                                      imageUrl: imageUrls[0]))
                              : SizedBox(
                                  height: 250,
                                  child: CustomVideoPlayer(
                                    postId: postModel.id ?? '',
                                    videoLink: imageUrls[0],
                                    adVideoLink: adVideoLink,
                                    campaignCallToAction: campaignCallToAction,
                                    campaignDescription: campaignDescription,
                                    campaignName: campaignName,
                                    campaignWebUrl: campaignWebUrl,
                                    actionButtonText: actionButtonText,
                                  ),
                                ),
                    ],
                  )
                : ((postModel.media?.length ?? 0) == 0)
                    ? Container(
                        // =================================================== No Media Post ===================================================
                        height: (postModel.post_background_color != null &&
                                postModel.post_background_color!.isNotEmpty &&
                                postModel.post_background_color! != '')
                            ? 280
                            : null, // not having background color will make height dynamic
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            color: (postModel.post_background_color != null &&
                                    postModel.post_background_color!.isNotEmpty)
                                ? Color(int.parse(
                                    '0xff${postModel.post_background_color}'))
                                : null),
                        padding: const EdgeInsets.all(10),
                        child: (postModel.post_background_color != null &&
                                postModel.post_background_color != '')
                            ? Center(
                                child: Text(
                                  postModel.description ?? '',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 24),
                                ),
                              )
                            : ExpandableText(
                                postModel.description ?? '',
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
                                    children: getTextWithLink(
                                        postModel.description ?? ''))),
                          ),
                          GestureDetector(
                              onTap: () async {
                                String url = postModel.link.toString();
                                await launchUrl(Uri.parse(url));
                              },
                              child: PrimaryNetworkImage(
                                  imageUrl: postModel.link_image!)),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration:
                                BoxDecoration(color: Colors.grey.shade300),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  postModel.link_title ?? '',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                ExpandableText(
                                  postModel.link_description ?? '',
                                  expandText: 'See more',
                                  maxLines: 5,
                                  collapseText: 'see less',
                                  style: const TextStyle(color: Colors.black),
                                )
                              ],
                            ),
                          )
                        ],
                      )
            : Column(
                //======================================================== Showing Link Post ========================================================//
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: LinkText(text: postModel.description ?? '')),
                  GestureDetector(
                      onTap: () async {
                        String url = postModel.link.toString();
                        await launchUrl(Uri.parse(url),
                            mode: LaunchMode.externalApplication);
                      },
                      child: PrimaryNetworkImage(
                          imageUrl: postModel.link_image ?? '')),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.grey.shade300),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          postModel.link_title ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(postModel.link_description ?? ''),
                      ],
                    ),
                  )
                ],
              );
  }
}

//======================== Shared Timeline Post Line ========================//
class SharedTimelinePost extends StatelessWidget {
  const SharedTimelinePost(
      {super.key,
      required this.postModel,
      required this.sharedPostModel,
      this.campaignWebUrl,
      this.campaignName,
      this.campaignDescription,
      this.campaignCallToAction,
      this.adVideoLink,
      this.actionButtonText,
      required this.onTapViewMoreMedia,
      required this.onTapViewOtherProfile});

  final PostModel postModel;
  final SharePostIdModel sharedPostModel;
  final VoidCallback onTapViewMoreMedia;
  final VoidCallback onTapViewOtherProfile;
  final String? adVideoLink;
  final String? campaignWebUrl;
  final String? campaignName;
  final String? campaignDescription;
  final String? actionButtonText;
  final VoidCallback? campaignCallToAction;

  @override
  Widget build(BuildContext context) {
    List<String> imageUrls = [];

    for (MediaModel media in postModel.shareMedia ?? []) {
      imageUrls.add(getFormatedPostUrl(media.media ?? ''));
    }

    return (sharedPostModel.event_type?.isNotEmpty ?? false)
        ?
        //======================================================== Showing Event Post ========================================================//
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [getEventIcon(postModel)],
              ),
              sharedPostModel.event_type == 'travel'
                  ? Padding(
                      padding: const EdgeInsets.only(
                          top: 5.0, left: 8.0, right: 8.0),
                      child: ExpandableText(
                        sharedPostModel.lifeEventId?.title ?? '',
                        expandText: 'See more',
                        maxLines: 5,
                        collapseText: 'see less',
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ))
                  : Container(),
              sharedPostModel.event_type == 'customevent'
                  ? Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        textAlign: TextAlign.center,
                        getCustomEventText(postModel),
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    )
                  : sharedPostModel.event_type == 'milestonesandachievements'
                      ? Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            textAlign: TextAlign.center,
                            getMilestonEventText(postModel),
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        )
                      : sharedPostModel.event_type == 'travel'
                          ? Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Text(
                                textAlign: TextAlign.center,
                                getTravelEventText(postModel),
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            )
                          : sharedPostModel.event_type == 'relationship'
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: InkWell(
                                    onTap: () {
                                      Get.toNamed(Routes.OTHERS_PROFILE,
                                          arguments: {
                                            'username': sharedPostModel
                                                .lifeEventId
                                                ?.toUserId
                                                ?.username,
                                            'isFromReels': 'false'
                                          });
                                    },
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      getRelationEventText(postModel),
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              : sharedPostModel.event_type == 'education'
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        getEducationEventText(postModel),
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Text(
                                          textAlign: TextAlign.center,
                                          getWorkEventText(postModel),
                                          style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold)),
                                    ),
              const SizedBox(
                height: 3,
              ),
              sharedPostModel.event_type == 'customevent'
                  ? Text(
                      getDynamicFormatedTime(
                          sharedPostModel.lifeEventId?.date.toString() ?? ''),
                      style: TextStyle(
                        fontSize: Get.height * 0.015,
                      ),
                    )
                  : sharedPostModel.event_type == 'milestonesandachievements'
                      ? Text(
                          getDynamicFormatedTime(
                              sharedPostModel.lifeEventId?.date.toString() ??
                                  ''),
                          style: TextStyle(
                            fontSize: Get.height * 0.015,
                          ),
                        )
                      : sharedPostModel.event_type == 'travel'
                          ? Text(
                              getDynamicFormatedTime(sharedPostModel
                                      .lifeEventId?.date
                                      .toString() ??
                                  ''),
                              style: TextStyle(
                                fontSize: Get.height * 0.015,
                              ),
                            )
                          : sharedPostModel.event_type == 'relationship'
                              ? Text(
                                  getDynamicFormatedTime(sharedPostModel
                                          .lifeEventId?.date
                                          .toString() ??
                                      ''),
                                  style: TextStyle(
                                    fontSize: Get.height * 0.015,
                                  ),
                                )
                              : sharedPostModel.event_type == 'education'
                                  ? Text(
                                      sharedPostModel.event_sub_type!
                                              .contains('New School')
                                          ? getDynamicFormatedTime(postModel
                                                  .institute_id?.startDate ??
                                              '')
                                          : sharedPostModel.event_sub_type!
                                                  .contains('Graduate')
                                              ? getDynamicFormatedTime(postModel
                                                      .institute_id?.endDate ??
                                                  '')
                                              : getDynamicFormatedTime(postModel
                                                      .institute_id?.endDate ??
                                                  ''),
                                      style: TextStyle(
                                        fontSize: Get.height * 0.015,
                                      ),
                                    )
                                  : Text(
                                      sharedPostModel.event_sub_type!
                                              .contains('New Job')
                                          ? getDynamicFormatedTime(postModel
                                                  .workplace_id?.fromDate ??
                                              '')
                                          : sharedPostModel.event_sub_type!
                                                  .contains('Promotion')
                                              ? getDynamicFormatedTime(postModel
                                                      .workplace_id?.fromDate ??
                                                  '')
                                              : sharedPostModel.event_sub_type!
                                                      .contains('Left Job')
                                                  ? getDynamicFormatedTime(
                                                      postModel.workplace_id
                                                              ?.toDate ??
                                                          '')
                                                  : getDynamicFormatedTime(
                                                      postModel.workplace_id
                                                              ?.toDate ??
                                                          ''),
                                      style: TextStyle(
                                        fontSize: Get.height * 0.015,
                                      )),
              sharedPostModel.event_type == 'relationship' ||
                      sharedPostModel.event_type == 'travel' ||
                      sharedPostModel.event_type ==
                          'milestonesandachievements' ||
                      sharedPostModel.event_type == 'customevent'
                  ? Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Stack(
                        children: [
                          const Divider(
                            height: 50,
                            color: Colors.grey,
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 0,
                            bottom: 0,
                            child: Align(
                                alignment: Alignment.center,
                                child: getEventIcon(postModel,
                                    height: 32, width: 32)),
                          )
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Stack(
                        children: [
                          const Divider(
                            height: 50,
                            color: Colors.grey,
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 0,
                            bottom: 0,
                            child: Align(
                                alignment: Alignment.center,
                                child: getEventIcon(postModel,
                                    height: 32, width: 32)),
                          )
                        ],
                      ),
                    ),
              sharedPostModel.event_type == 'relationship' ||
                      sharedPostModel.event_type == 'travel' ||
                      sharedPostModel.event_type ==
                          'milestonesandachievements' ||
                      sharedPostModel.event_type == 'customevent'
                  ? Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: ExpandableText(
                        sharedPostModel.lifeEventId?.description ?? '',
                        expandText: 'See more',
                        maxLines: 5,
                        collapseText: 'see less',
                        style: const TextStyle(color: Colors.black),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: ExpandableText(
                        sharedPostModel.description ?? '',
                        expandText: 'See more',
                        maxLines: 5,
                        collapseText: 'see less',
                        style: const TextStyle(color: Colors.black),
                      ),
                    )
            ],
          )
        : sharedPostModel.link_image == null || sharedPostModel.link_image == ''
            //======================================================== Showing Image with Description Post ========================================================//

            ? ((postModel.shareMedia?.length ?? 0) > 0)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      (sharedPostModel.description?.isNotEmpty ?? true)
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(left: 5, bottom: 10),
                              child: ExpandableText(
                                sharedPostModel.description ?? '',
                                expandText: 'See more',
                                maxLines: 5,
                                collapseText: 'see less',
                                style: const TextStyle(color: Colors.black),
                              ),
                            )
                          : const SizedBox(),
                      ((postModel.shareMedia?.length ?? 0) > 1)
                          ? SizedBox(
                              height: 500,
                              child: MediaGridView(
                                  mediaUrls: imageUrls,
                                  onTapViewMoreMedia: () {
                                    Get.to(() =>
                                        SingleImage(imgURL: imageUrls[0]));
                                  }),
                            )
                          : InkWell(
                              onTap: () {
                                Get.to(() => SingleImage(imgURL: imageUrls[0]));
                              },
                              child: isImageUrl(imageUrls[0])
                                  ? PrimaryNetworkImage(imageUrl: imageUrls[0])
                                  : SizedBox(
                                      height: 250,
                                      child: CustomVideoPlayer(
                                        postId: postModel.id ?? '',
                                        actionButtonText: actionButtonText,
                                        videoLink: imageUrls[0],
                                        adVideoLink: adVideoLink,
                                        campaignCallToAction:
                                            campaignCallToAction,
                                        campaignDescription:
                                            campaignDescription,
                                        campaignName: campaignName,
                                        campaignWebUrl: campaignWebUrl,
                                        // onSixSeconds: onSixSeconds
                                      ),
                                    )),
                    ],
                  )
                : ((postModel.shareMedia?.length ?? 0) == 0)
                    ? Container(
                        // =================================================== No Meida Post ===================================================
                        height: (sharedPostModel.post_background_color !=
                                    null &&
                                sharedPostModel
                                    .post_background_color!.isNotEmpty &&
                                sharedPostModel.post_background_color! != '')
                            ? 256
                            : null, // not having background color will make height dynamic
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            color: (sharedPostModel.post_background_color !=
                                        null &&
                                    sharedPostModel
                                        .post_background_color!.isNotEmpty)
                                ? Color(int.parse(
                                    '0xff${sharedPostModel.post_background_color}'))
                                : null),
                        padding: const EdgeInsets.all(10),
                        child: (sharedPostModel.post_background_color != null &&
                                sharedPostModel.post_background_color != '')
                            ? Center(
                                child: Text(
                                  sharedPostModel.description ?? '',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              )
                            : ExpandableText(
                                sharedPostModel.description ?? '',
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
                                text: TextSpan(
                                    children: getTextWithLink(
                                        sharedPostModel.description ?? ''))),
                          ),
                          GestureDetector(
                              onTap: () async {
                                String url = sharedPostModel.link.toString();
                                await launchUrl(Uri.parse(url));
                              },
                              child: PrimaryNetworkImage(
                                  imageUrl: sharedPostModel.link_image!)),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration:
                                BoxDecoration(color: Colors.grey.shade300),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  sharedPostModel.link_title ?? '',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                ExpandableText(
                                  sharedPostModel.link_description ?? '',
                                  expandText: 'See more',
                                  maxLines: 5,
                                  collapseText: 'see less',
                                  style: const TextStyle(color: Colors.black),
                                )
                              ],
                            ),
                          )
                        ],
                      )
            : Column(
                //======================================================== Showing Link Post ========================================================//
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: LinkText(text: sharedPostModel.description ?? '')),
                  GestureDetector(
                      onTap: () async {
                        String url = sharedPostModel.link.toString();
                        await launchUrl(Uri.parse(url),
                            mode: LaunchMode.externalApplication);
                      },
                      child: PrimaryNetworkImage(
                          imageUrl: sharedPostModel.link_image!)),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.grey.shade300),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          sharedPostModel.link_title ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(sharedPostModel.link_description ?? ''),
                      ],
                    ),
                  )
                ],
              );
  }
}

//=============================================================== Page Post

class PagePost extends StatelessWidget {
  const PagePost({
    super.key,
    required this.postModel,
    required this.onTapViewMoreMedia,
  });

  final PostModel postModel;
  final VoidCallback onTapViewMoreMedia;

  @override
  Widget build(BuildContext context) {
    List<String> imageUrls = [];

    for (MediaModel media in postModel.media ?? []) {
      imageUrls.add(getFormatedPostUrl(media.media ?? ''));
    }

    return postModel.link_image == null || postModel.link_image == ''
        //======================================================== Showing Image with Description Post ========================================================//

        ? ((postModel.media?.length ?? 0) > 0)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  (postModel.description?.isNotEmpty ?? true)
                      ? Padding(
                          padding: const EdgeInsets.only(left: 5, bottom: 10),
                          child: Text(postModel.description ?? ''),
                        )
                      : const SizedBox(),
                  ((postModel.media?.length ?? 0) > 0)
                      ? SizedBox(
                          height: 500,
                          child: MediaGridView(
                              mediaUrls: imageUrls,
                              onTapViewMoreMedia: onTapViewMoreMedia),
                        )
                      : PrimaryNetworkImage(imageUrl: imageUrls[0]),
                ],
              )
            : ((postModel.media?.length ?? 0) == 0)
                ? Container(
                    // =================================================== No Meida Post ===================================================
                    height: (postModel.post_background_color != null &&
                            postModel.post_background_color!.isNotEmpty &&
                            postModel.post_background_color! != '')
                        ? 256
                        : null, // not having background color will make height dynamic
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: (postModel.post_background_color != null &&
                                postModel.post_background_color!.isNotEmpty)
                            ? Color(int.parse(
                                '0xff${postModel.post_background_color}'))
                            : null),
                    padding: const EdgeInsets.all(10),
                    child: (postModel.post_background_color != null &&
                            postModel.post_background_color != '')
                        ? Center(
                            child: Text(
                              postModel.description ?? '',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                          )
                        : ExpandableText(
                            postModel.description ?? '',
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
                            text: TextSpan(
                                children: getTextWithLink(
                                    postModel.description ?? ''))),
                      ),
                      GestureDetector(
                          onTap: () async {
                            String url = postModel.link.toString();
                            await launchUrl(Uri.parse(url));
                          },
                          child: PrimaryNetworkImage(
                              imageUrl: postModel.link_image!)),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: Colors.grey.shade300),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              postModel.link_title ?? '',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(postModel.link_description ?? ''),
                          ],
                        ),
                      )
                    ],
                  )
        : Column(
            //======================================================== Showing Link Post ========================================================//
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: LinkText(text: postModel.description ?? '')),
              GestureDetector(
                  onTap: () async {
                    String url = postModel.link.toString();
                    await launchUrl(Uri.parse(url),
                        mode: LaunchMode.externalApplication);
                  },
                  child: PrimaryNetworkImage(imageUrl: postModel.link_image!)),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: Colors.grey.shade300),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      postModel.link_title ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(postModel.link_description ?? ''),
                  ],
                ),
              )
            ],
          );
  }
}

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
            imgURL: getFormatedPostUrl(postModel.media?[0].media ?? '')));
      },
      child: NetworkCircleAvatar(
        radius: 128,
        imageUrl: getFormatedPostUrl(postModel.media?[0].media ?? ''),
      ),
    );
  }
}

//=============================================================== Group File Post

class GroupFilePost extends StatelessWidget {
  const GroupFilePost({
    super.key,
    required this.postModel,
  });

  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    List<String> docFilesList = [];

    for (var i = 0; i < (postModel.media?.length ?? 0); i++) {
      docFilesList.add((postModel.media?[i].media ?? ''));
    }

    return GestureDetector(
      onTap: () {
        debugPrint('Download Your File');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(width: 20),
              Text(postModel.description ?? ''),
            ],
          ),
          const SizedBox(height: 10),
          for (var i = 0; i < docFilesList.length; i++)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              height: 50,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 221, 241, 240),
                  border: Border.all(style: BorderStyle.none),
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  Image.asset(
                    getFileIconAsset(postModel.media?[i].media),
                    height: 30,
                    width: 30,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 10),
                  // Expanded(
                  //   child: DownloadableTextDoc(
                  //     docFileName: docFilesList[i],
                  //     fileUrl: getFormatedPostUrl(docFilesList[i]),
                  //   ),
                  //   // Text(
                  //   //   docFilesList[i],
                  //   //   overflow: TextOverflow.ellipsis,
                  //   //   maxLines: 2,
                  //   //   softWrap: false,
                  //   //   style: TextStyle(fontWeight: FontWeight.bold),
                  //   // ),
                  // ),
                ],
              ),
            ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

//=============================================================== Cover Photo Post

class CoverPicturePost extends StatelessWidget {
  const CoverPicturePost({
    super.key,
    required this.postModel,
  });

  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => SingleImage(
            imgURL: getFormatedPostUrl(postModel.media?[0].media ?? '')));
      },
      child: PrimaryNetworkImage(
        imageUrl: getFormatedPostUrl(postModel.media?[0].media ?? ''),
      ),
    );
  }
}

//=============================================================== Shared Post

class SharedPost extends StatelessWidget {
  const SharedPost(
      {super.key,
      required this.postModel,
      required this.onTapViewMoreMedia,
      required this.onTapShareViewOtherProfile});

  final PostModel postModel;
  final VoidCallback onTapViewMoreMedia;
  final VoidCallback onTapShareViewOtherProfile;

  @override
  Widget build(BuildContext context) {
    List<String> imageUrls = [];

    for (MediaModel media in postModel.shareMedia ?? []) {
      imageUrls.add(getFormatedPostUrl(media.media ?? ''));
    }
    List<String> docFilesList = [];

    for (MediaModel media in postModel.shareMedia ?? []) {
      docFilesList.add((media.media ?? ''));
    }
//======================== event type shared post================================//
    return postModel.share_post_id!.event_type != null &&
            postModel.share_post_id!.event_type != ''
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [getSharedEventIcon(postModel)],
              ),
              postModel.share_post_id?.event_type == 'travel'
                  ? Padding(
                      padding: const EdgeInsets.only(
                          top: 5.0, left: 8.0, right: 8.0),
                      child: ExpandableText(
                        postModel.share_post_id?.lifeEventId?.title ?? '',
                        expandText: 'See more',
                        maxLines: 5,
                        collapseText: 'see less',
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ))
                  : Container(),
              postModel.share_post_id?.event_type == 'customevent'
                  ? Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        textAlign: TextAlign.center,
                        getSharedCustomEventText(postModel),
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    )
                  : postModel.share_post_id?.event_type ==
                          'milestonesandachievements'
                      ? Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            textAlign: TextAlign.center,
                            getSharedMilestonEventText(postModel),
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        )
                      : postModel.share_post_id?.event_type == 'travel'
                          ? Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Text(
                                textAlign: TextAlign.center,
                                getSharedTravelEventText(postModel),
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            )
                          : postModel.share_post_id?.event_type ==
                                  'relationship'
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: InkWell(
                                    onTap: onTapShareViewOtherProfile,
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      getSharedRelationEventText(postModel),
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              : postModel.share_post_id?.event_type ==
                                      'education'
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        getSharedEducationEventText(postModel),
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(top: 5.0),
                                      child: Text(
                                          textAlign: TextAlign.center,
                                          getSharedWorkEventText(postModel),
                                          style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold)),
                                    ),
              const SizedBox(
                height: 3,
              ),
              postModel.share_post_id?.event_type == 'customevent'
                  ? Text(
                      getDynamicFormatedTime(postModel
                              .share_post_id?.lifeEventId?.date
                              .toString() ??
                          ''),
                      style: TextStyle(
                        fontSize: Get.height * 0.015,
                      ),
                    )
                  : postModel.share_post_id?.event_type ==
                          'milestonesandachievements'
                      ? Text(
                          getDynamicFormatedTime(postModel
                                  .share_post_id?.lifeEventId?.date
                                  .toString() ??
                              ''),
                          style: TextStyle(
                            fontSize: Get.height * 0.015,
                          ),
                        )
                      : postModel.event_type == 'travel'
                          ? Text(
                              getDynamicFormatedTime(postModel
                                      .share_post_id?.lifeEventId?.date
                                      .toString() ??
                                  ''),
                              style: TextStyle(
                                fontSize: Get.height * 0.015,
                              ),
                            )
                          : postModel.share_post_id?.event_type ==
                                  'relationship'
                              ? Text(
                                  getDynamicFormatedTime(postModel
                                          .share_post_id?.lifeEventId?.date
                                          .toString() ??
                                      ''),
                                  style: TextStyle(
                                    fontSize: Get.height * 0.015,
                                  ),
                                )
                              : postModel.share_post_id?.event_type ==
                                      'education'
                                  ? Text(
                                      postModel.share_post_id!.event_sub_type!
                                              .contains('New School')
                                          ? getDynamicFormatedTime(postModel
                                                  .share_post_id!
                                                  .institute_id
                                                  ?.startDate
                                                  .toString() ??
                                              '')
                                          : postModel.share_post_id!
                                                  .event_sub_type!
                                                  .contains('Graduate')
                                              ? getDynamicFormatedTime(postModel
                                                      .share_post_id!
                                                      .institute_id
                                                      ?.endDate ??
                                                  '')
                                              : getDynamicFormatedTime(postModel
                                                      .share_post_id!
                                                      .institute_id
                                                      ?.endDate ??
                                                  ''),
                                      style: TextStyle(
                                        fontSize: Get.height * 0.015,
                                      ),
                                    )
                                  : Text(
                                      postModel.share_post_id!.event_sub_type!
                                              .contains('New Job')
                                          ? getDynamicFormatedTime(postModel
                                                  .share_post_id!
                                                  .workplace_id
                                                  ?.fromDate ??
                                              '')
                                          : postModel.share_post_id!.event_sub_type!
                                                  .contains('Promotion')
                                              ? getDynamicFormatedTime(postModel
                                                      .share_post_id!
                                                      .workplace_id
                                                      ?.fromDate ??
                                                  '')
                                              : postModel.share_post_id!.event_sub_type!
                                                      .contains('Left Job')
                                                  ? getDynamicFormatedTime(postModel
                                                          .share_post_id!
                                                          .workplace_id
                                                          ?.toDate ??
                                                      '')
                                                  : getDynamicFormatedTime(
                                                      postModel.share_post_id!.workplace_id?.toDate ?? ''),
                                      style: TextStyle(
                                        fontSize: Get.height * 0.015,
                                      )),
              postModel.share_post_id?.event_type == 'relationship' ||
                      postModel.share_post_id?.event_type == 'travel' ||
                      postModel.share_post_id?.event_type ==
                          'milestonesandachievements' ||
                      postModel.share_post_id?.event_type == 'customevent'
                  ? Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Stack(
                        children: [
                          const Divider(
                            height: 50,
                            color: Colors.grey,
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 0,
                            bottom: 0,
                            child: Align(
                                alignment: Alignment.center,
                                child: getSharedEventIcon(postModel,
                                    height: 32, width: 32)),
                          )
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Stack(
                        children: [
                          const Divider(
                            height: 50,
                            color: Colors.grey,
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 0,
                            bottom: 0,
                            child: Align(
                                alignment: Alignment.center,
                                child: getSharedEventIcon(postModel,
                                    height: 32, width: 32)),
                          )
                        ],
                      ),
                    ),
              postModel.share_post_id?.event_type == 'relationship' ||
                      postModel.share_post_id?.event_type == 'travel' ||
                      postModel.share_post_id?.event_type ==
                          'milestonesandachievements' ||
                      postModel.share_post_id?.event_type == 'customevent'
                  ? Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: ExpandableText(
                        postModel.share_post_id!.lifeEventId?.description ?? '',
                        expandText: 'See more',
                        maxLines: 5,
                        collapseText: 'see less',
                        style: const TextStyle(color: Colors.black),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: ExpandableText(
                        postModel.share_post_id?.description ?? '',
                        expandText: 'See more',
                        maxLines: 5,
                        collapseText: 'see less',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
              const SizedBox(
                height: 5,
              ),
            ],
          )
        //====================================  Group File Type Shared Post =======================================//
        : postModel.share_post_id?.post_type == 'group_file'
            ? GestureDetector(
                onTap: () {
                  debugPrint('Download Your File');
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        Text(postModel.share_post_id?.description ?? ''),
                      ],
                    ),
                    const SizedBox(height: 20),
                    for (var i = 0; i < docFilesList.length; i++)
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        height: 50,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 221, 241, 240),
                            border: Border.all(style: BorderStyle.none),
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          children: [
                            Image.asset(
                              getFileIconAsset(postModel.shareMedia?[i].media),
                              height: 30,
                              width: 30,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                docFilesList[i],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                softWrap: false,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 10),
                  ],
                ),
              )
            : postModel.share_post_id?.post_type == 'timeline_post'
                ? SharedTimelinePost(
                    postModel: postModel,
                    sharedPostModel: postModel.share_post_id!,
                    onTapViewMoreMedia: () {},
                    onTapViewOtherProfile: () {},
                  )
                :
                // ==================== Shared Campaign Start==========================//
                postModel.share_post_id?.post_type == 'campaign'
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          postModel.share_post_id?.adProduct?.media?.length == 1
                              ? PrimaryNetworkImage(
                                  imageUrl: getFormatedAdsUrl(
                                      '${postModel.share_post_id?.adProduct?.media?[0]}'),
                                )
                              : postModel.share_post_id?.adProduct?.media !=
                                      null
                                  ? slider.CarouselSlider(
                                      options: slider.CarouselOptions(
                                        aspectRatio: 6 / 3,
                                        autoPlay: true,
                                        viewportFraction: 0.8,
                                        scrollPhysics:
                                            const BouncingScrollPhysics(),
                                      ),
                                      items: (postModel.share_post_id?.adProduct
                                                  ?.media ??
                                              [])
                                          .map(
                                            (item) => InkWell(
                                              onTap: () {
                                                // launchMyURL(postModel.adProduct?. ?? '');
                                              },
                                              child: Container(
                                                  height: 256,
                                                  width: double.maxFinite,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.white),
                                                    color: Colors.white,
                                                  ),
                                                  child: Image(
                                                    fit: BoxFit.fitWidth,
                                                    image: NetworkImage(
                                                        getFormatedProductUrlLive(
                                                            item)),
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return Image.asset(
                                                          AppAssets
                                                              .DEFAULT_IMAGE);
                                                    },
                                                  )),
                                            ),
                                          )
                                          .toList(),
                                    )
                                  : slider.CarouselSlider(
                                      options: slider.CarouselOptions(
                                        aspectRatio: 6 / 3,
                                        autoPlay: true,
                                        viewportFraction: 0.8,
                                        scrollPhysics:
                                            const BouncingScrollPhysics(),
                                      ),
                                      items: (postModel.campaign_id
                                                  ?.campaign_cover_pic ??
                                              [])
                                          .map(
                                            (item) => InkWell(
                                              onTap: () {
                                                launchMyURL(postModel
                                                        .campaign_id
                                                        ?.website_url ??
                                                    '');
                                              },
                                              child: Container(
                                                  height: 256,
                                                  width: double.maxFinite,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.white),
                                                    color: Colors.white,
                                                  ),
                                                  child: Image(
                                                      fit: BoxFit.fitWidth,
                                                      image: NetworkImage(
                                                          getFormatedPostUrl(
                                                              item)))),
                                            ),
                                          )
                                          .toList(),
                                    ),
                          postModel.share_post_id?.adProduct?.id != null
                              ? InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.PRODUCT_DETAILS,
                                        arguments: postModel
                                            .share_post_id?.adProduct?.id);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade400),
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Text(
                                                '${postModel.share_post_id?.adProduct?.productName?.capitalizeFirst}',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    '\$${postModel.share_post_id?.adProduct?.baseMainPrice?.toStringAsFixed(2)}',
                                                    style: const TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      decorationThickness: 3,
                                                      decorationColor:
                                                          Color.fromARGB(
                                                              255, 196, 20, 7),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    '\$${postModel.share_post_id?.adProduct?.baseSellingPrice?.toStringAsFixed(2)}',
                                                    style: const TextStyle(
                                                      color: PRIMARY_COLOR,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                PRIMARY_COLOR, // Background color
                                            foregroundColor:
                                                Colors.white, // Text color
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 10, // Vertical padding
                                              horizontal:
                                                  20, // Horizontal padding
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      8), // Rounded corners
                                            ),
                                          ),
                                          onPressed: () {
                                            Get.toNamed(Routes.PRODUCT_DETAILS,
                                                arguments: postModel
                                                    .share_post_id
                                                    ?.adProduct
                                                    ?.id);
                                          },
                                          child: Text(
                                            '${postModel.share_post_id?.link_title}',
                                            style: const TextStyle(
                                              fontSize:
                                                  16, // Adjust font size if needed
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    launchMyURL(
                                        postModel.campaign_id?.website_url ??
                                            '');
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade400),
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Text(
                                                '${postModel.campaign_id?.website_url}',
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                '${postModel.campaign_id?.headline}',
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: PRIMARY_COLOR,
                                            foregroundColor: Colors.white,
                                            side: const BorderSide(
                                                color: Colors.green, width: 2),
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: 20,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            elevation: 0,
                                          ),
                                          onPressed: () {
                                            launchMyURL(postModel
                                                    .campaign_id?.website_url ??
                                                '');
                                          },
                                          child: Text(
                                            '${postModel.campaign_id?.call_to_action}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                        ],
                      )
                    //================Shared Campaign Ends========================//
                    //====================================  Link Image Type Shared Post =======================================//

                    : postModel.share_post_id?.link_image == null ||
                            postModel.share_post_id?.link_image == ''
                        ? ((postModel.shareMedia?.length ?? 0) > 0)
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  (postModel.description?.isNotEmpty ?? true)
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              left: 5, bottom: 10),
                                          child: Text(postModel
                                                  .share_post_id?.description ??
                                              ''),
                                        )
                                      : const SizedBox(),
                                  ((postModel.shareMedia?.length ?? 0) > 1)
                                      ? SizedBox(
                                          height: 500,
                                          child: MediaGridView(
                                              mediaUrls: imageUrls,
                                              onTapViewMoreMedia:
                                                  onTapViewMoreMedia),
                                        )
                                      : PrimaryNetworkImage(
                                          imageUrl: imageUrls[0]),
                                ],
                              )
                            : ((postModel.shareMedia?.length ?? 0) == 0)
                                ? Container(
                                    // =================================================== No Meida Post ===================================================
                                    height:
                                        (postModel.share_post_id
                                                        ?.post_background_color !=
                                                    null &&
                                                postModel
                                                    .share_post_id!
                                                    .post_background_color!
                                                    .isNotEmpty &&
                                                postModel.share_post_id!
                                                        .post_background_color! !=
                                                    '')
                                            ? 256
                                            : null, // not having background color will make height dynamic
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                        color: (postModel.share_post_id
                                                        ?.post_background_color !=
                                                    null &&
                                                postModel
                                                    .share_post_id!
                                                    .post_background_color!
                                                    .isNotEmpty)
                                            ? Color(int.parse(
                                                '0xff${postModel.share_post_id!.post_background_color}'))
                                            : null),
                                    padding: const EdgeInsets.all(10),
                                    child: (postModel.share_post_id
                                                    ?.post_background_color !=
                                                null &&
                                            postModel.share_post_id
                                                    ?.post_background_color !=
                                                '')
                                        ? Center(
                                            child: Text(
                                              postModel.share_post_id
                                                      ?.description ??
                                                  '',
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                          )
                                        : ExpandableText(
                                            postModel.share_post_id
                                                    ?.description ??
                                                '',
                                            expandText: 'See more',
                                            maxLines: 5,
                                            collapseText: 'See less',
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                  )
                                //====================================  Text Link Shared Post =======================================//

                                : Column(
                                    // Link post design
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: RichText(
                                            text: TextSpan(
                                                children: getTextWithLink(
                                                    postModel.share_post_id
                                                            ?.description ??
                                                        ''))),
                                      ),
                                      GestureDetector(
                                          onTap: () async {
                                            String url =
                                                postModel.share_post_id?.link ??
                                                    '';
                                            await launchUrl(Uri.parse(url));
                                          },
                                          child: PrimaryNetworkImage(
                                              imageUrl: postModel.share_post_id
                                                      ?.link_image ??
                                                  '')),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade300),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Text(
                                              postModel.share_post_id
                                                      ?.link_title ??
                                                  '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(postModel.share_post_id
                                                    ?.link_description ??
                                                ''),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                        : Column(
                            // Link post design
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: RichText(
                                    text: TextSpan(
                                        children: getTextWithLink(postModel
                                                .share_post_id?.description ??
                                            ''))),
                              ),
                              GestureDetector(
                                  onTap: () async {
                                    String url =
                                        postModel.share_post_id?.link ?? '';
                                    await launchUrl(Uri.parse(url),
                                        mode: LaunchMode.externalApplication);
                                  },
                                  child: PrimaryNetworkImage(
                                      imageUrl:
                                          postModel.share_post_id?.link_image ??
                                              '')),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration:
                                    BoxDecoration(color: Colors.grey.shade300),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      postModel.share_post_id?.link_title ?? '',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(postModel
                                            .share_post_id?.link_description ??
                                        ''),
                                  ],
                                ),
                              )
                            ],
                          );
  }
}

//=============================================================== Event Post

class EventPost extends StatelessWidget {
  const EventPost({
    super.key,
    required this.postModel,
  });

  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

//=============================================================== Shared Reels Post

class SharedReelsPost extends StatelessWidget {
  const SharedReelsPost({
    super.key,
    required this.postModel,
    this.adVideoLink,
    this.campaignWebUrl,
    this.campaignName,
    this.actionButtonText,
    this.campaignDescription,
    this.campaignCallToAction,
  });

  final PostModel postModel;
  final String? adVideoLink;
  final String? campaignWebUrl;
  final String? campaignName;
  final String? campaignDescription;
  final String? actionButtonText;
  final VoidCallback? campaignCallToAction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 300,
        child: VideoPlay(
          videoLink:
              getFormatedReelUrl(postModel.share_reels_id!.video.toString()),
          adVideoLink: adVideoLink,
          campaignWebUrl: campaignWebUrl,
          campaignName: campaignName,
          campaignDescription: campaignDescription,
          campaignCallToAction: campaignCallToAction,
          actionButtonText: actionButtonText,
        ));
  }
}

//=============================================================== Birthday Post

class BirthdayPost extends StatelessWidget {
  const BirthdayPost({
    super.key,
    required this.postModel,
  });

  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

//=============================================================== Campain Post

class CampaignPost extends StatelessWidget {
  const CampaignPost({
    super.key,
    required this.postModel,
  });

  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        postModel.campaign_id?.campaign_cover_pic?.length == 1
            ? PrimaryNetworkImage(
                imageUrl: getFormatedAdsUrl(
                    '${postModel.campaign_id?.campaign_cover_pic?[0]}'),
              )
            : (isVideo(('${postModel.campaign_id?.campaign_cover_pic?[0]}')))
                ? SizedBox(
                    height: 250,
                    child: VideoPlay(
                      //  campaignCallToAction: campaignCallToAction,
                      videoLink: getFormatedAdsUrl(
                          '${postModel.campaign_id?.campaign_cover_pic?[0]}'),
                    ),
                  )
                : postModel.adProduct?.media != null
                    ?slider. CarouselSlider(
                        options:slider. CarouselOptions(
                          aspectRatio: 6 / 3,
                          autoPlay: true,
                          viewportFraction: 0.8,
                          scrollPhysics: const BouncingScrollPhysics(),
                        ),
                        items: (postModel.adProduct?.media ?? [])
                            .map(
                              (item) => InkWell(
                                onTap: () {
                                  // launchMyURL(postModel.adProduct?. ?? '');
                                },
                                child: Container(
                                  height: 256,
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    color: Colors.white,
                                  ),
                                  child: Image(
                                    fit: BoxFit.fitWidth,
                                    image: NetworkImage(
                                        getFormatedProductUrlLive(item)),
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                          AppAssets.DEFAULT_IMAGE);
                                    },
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      )
                    :slider. CarouselSlider(
                       options: slider. CarouselOptions(
                          aspectRatio: 6 / 3,
                          autoPlay: true,
                          viewportFraction: 1,
                          scrollPhysics: const BouncingScrollPhysics(),
                        ),
                        items: (postModel.campaign_id?.campaign_cover_pic ?? [])
                            .map(
                              (item) => InkWell(
                                onTap: () {
                                  launchMyURL(
                                      postModel.campaign_id?.website_url ?? '');
                                },
                                child: Container(
                                    height: 256,
                                    width: double.maxFinite,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white),
                                      color: Colors.white,
                                    ),
                                    child: Image(
                                      fit: BoxFit.fitWidth,
                                      image: NetworkImage(
                                          getFormatedAdsUrl(item)),
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          AppAssets.DEFAULT_IMAGE,
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    )),
                              ),
                            )
                            .toList(),
                      ),
        postModel.adProduct?.id != null
            ? InkWell(
                onTap: () {
                  Get.toNamed(Routes.PRODUCT_DETAILS,
                      arguments: postModel.adProduct?.id);
                },
                child: Container(
                  decoration: BoxDecoration(color: Colors.grey.shade400),
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              '${postModel.adProduct?.productName?.capitalizeFirst}',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: [
                                Text(
                                  '\$${postModel.adProduct?.baseMainPrice?.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.lineThrough,
                                    decorationThickness: 3,
                                    decorationColor:
                                        Color.fromARGB(255, 196, 20, 7),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '\$${postModel.adProduct?.baseSellingPrice?.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    color: PRIMARY_COLOR,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: PRIMARY_COLOR,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Get.toNamed(Routes.PRODUCT_DETAILS,
                              arguments: postModel.adProduct?.id);
                        },
                        child: Text(
                          '${postModel.campaign_id?.call_to_action}',
                          style: const TextStyle(
                            fontSize: 16, // Adjust font size if needed
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : InkWell(
                onTap: () {
                  launchMyURL(postModel.campaign_id?.website_url ?? '');
                },
                child: Container(
                  decoration: BoxDecoration(color: Colors.grey.shade400),
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              '${postModel.campaign_id?.website_url}',
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '${postModel.campaign_id?.headline}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: PRIMARY_COLOR,
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.green, width: 2),
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () {
                          launchMyURL(postModel.campaign_id?.website_url ?? '');
                        },
                        child: Text(
                          '${postModel.campaign_id?.call_to_action}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
      ],
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

String getSharedEducationEventText(PostModel postModel) {
  return postModel.share_post_id!.event_sub_type!.contains('New School')
      ? 'Started School at ${postModel.share_post_id?.institute_id?.instituteName}'
      : postModel.share_post_id!.event_sub_type!.contains('Graduate')
          ? 'Graduated from ${postModel.share_post_id?.institute_id?.instituteName}'
          : 'Left School from ${postModel.share_post_id?.institute_id?.instituteName}';
}

String getEducationEventText(PostModel postModel) {
  return postModel.event_sub_type!.contains('New School')
      ? 'Started School at ${postModel.institute_id?.instituteName}'
      : postModel.event_sub_type!.contains('Graduate')
          ? 'Graduated from ${postModel.institute_id?.instituteName}'
          : 'Left School from ${postModel.institute_id?.instituteName}';
}

String getRelationEventText(PostModel postModel) {
  return postModel.event_sub_type!.contains('New Relationship')
      ? 'In a relationship with ${postModel.lifeEventId?.toUserId?.firstName} ${postModel.lifeEventId?.toUserId?.lastName}'
      : postModel.event_sub_type!.contains('Engagement')
          ? 'Engaged to ${postModel.lifeEventId?.toUserId?.firstName} ${postModel.lifeEventId?.toUserId?.lastName}'
          : postModel.event_sub_type!.contains('Marriage')
              ? 'Married to ${postModel.lifeEventId?.toUserId?.firstName} ${postModel.lifeEventId?.toUserId?.lastName}'
              : 'First Meet ${postModel.lifeEventId?.toUserId?.firstName} ${postModel.lifeEventId?.toUserId?.lastName} ';
}

String getSharedRelationEventText(PostModel postModel) {
  return postModel.share_post_id!.event_sub_type!.contains('New Relationship')
      ? 'In a relationship with ${postModel.share_post_id?.lifeEventId?.toUserId?.firstName} ${postModel.share_post_id?.lifeEventId?.toUserId?.lastName}'
      : postModel.share_post_id!.event_sub_type!.contains('Engagement')
          ? 'Engaged to ${postModel.share_post_id?.lifeEventId?.toUserId?.firstName} ${postModel.share_post_id?.lifeEventId?.toUserId?.lastName}'
          : postModel.share_post_id!.event_sub_type!.contains('Marriage')
              ? 'Married to ${postModel.share_post_id?.lifeEventId?.toUserId?.firstName} ${postModel.share_post_id?.lifeEventId?.toUserId?.lastName}'
              : 'First Meet ${postModel.share_post_id?.lifeEventId?.toUserId?.firstName} ${postModel.share_post_id?.lifeEventId?.toUserId?.lastName} ';
}

String getTravelEventText(PostModel postModel) {
  return 'Travel to ${postModel.lifeEventId?.locationName}';
}

String getSharedTravelEventText(PostModel postModel) {
  return 'Travel to ${postModel.share_post_id?.lifeEventId?.locationName}';
}

String getMilestonEventText(PostModel postModel) {
  return '${postModel.lifeEventId?.title}';
}

String getSharedMilestonEventText(PostModel postModel) {
  return '${postModel.share_post_id?.lifeEventId?.title}';
}

String getCustomEventText(PostModel postModel) {
  return '${postModel.lifeEventId?.title}';
}

String getSharedCustomEventText(PostModel postModel) {
  return '${postModel.share_post_id?.lifeEventId?.title}';
}

String getWorkEventText(PostModel postModel) {
  return postModel.event_sub_type!.contains('New Job')
      ? 'Started New Job at ${postModel.workplace_id?.orgName} as ${postModel.workplace_id?.designation}'
      : postModel.event_sub_type!.contains('Promotion')
          ? 'Promoted Job at ${postModel.workplace_id?.orgName} as ${postModel.workplace_id?.designation}'
          : postModel.event_sub_type!.contains('Left Job')
              ? 'Left Job from ${postModel.workplace_id?.orgName} as ${postModel.workplace_id?.designation}'
              : 'Retirement from ${postModel.workplace_id?.orgName} as ${postModel.workplace_id?.designation}';
}

String getSharedWorkEventText(PostModel postModel) {
  return postModel.share_post_id!.event_sub_type!.contains('New Job')
      ? 'Started New Job at ${postModel.share_post_id?.workplace_id?.orgName} as ${postModel.share_post_id?.workplace_id?.designation}'
      : postModel.share_post_id!.event_sub_type!.contains('Promotion')
          ? 'Promoted Job at ${postModel.share_post_id?.workplace_id?.orgName} as ${postModel.share_post_id?.workplace_id?.designation}'
          : postModel.share_post_id!.event_sub_type!.contains('Left Job')
              ? 'Left Job from ${postModel.share_post_id!.workplace_id?.orgName} as ${postModel.share_post_id?.workplace_id?.designation}'
              : 'Retirement from ${postModel.share_post_id?.workplace_id?.orgName} as ${postModel.share_post_id?.workplace_id?.designation}';
}

String getCustomLifeEventIconName(String iconName) {
  return 'assets/icon/live_event/$iconName${'.png'}';
}

Widget getEventIcon(
  PostModel model, {
  double height = 60,
  double width = 60,
}) {
  switch (model.event_type) {
    case 'education':
      return Image.asset(
        'assets/icon/live_event/education_event_icon.png',
        width: width,
        height: height,
      );
    case 'work':
      return Image.asset(
        'assets/icon/live_event/work_event_icon.png',
        width: width,
        height: height,
      );
    case 'travel':
      return Image.asset(
        'assets/icon/live_event/travel_icon.png',
        width: width,
        height: height,
      );
    case 'customevent':
      return Image.asset(
        getCustomLifeEventIconName(model.lifeEventId?.iconName ?? ''),
        width: width,
        height: height,
      );
    case 'milestonesandachievements':
      return Image.asset(
        'assets/icon/live_event/mileston_icon.png',
        width: width,
        height: height,
      );
    case 'relationship':
      return model.event_sub_type == 'New Relationship'
          ? Image.asset(
              'assets/icon/live_event/in_relation_icon.png',
              width: width,
              height: height,
            )
          : model.event_sub_type == 'Engagement'
              ? Image.asset(
                  'assets/icon/live_event/engaged_icon.png',
                  width: width,
                  height: height,
                )
              : model.event_sub_type == 'Marriage'
                  ? Image.asset(
                      'assets/icon/live_event/marraid_icon.png',
                      width: width,
                      height: height,
                    )
                  : Image.asset(
                      'assets/icon/live_event/first_meet_icon.png',
                      width: width,
                      height: height,
                    );
    default:
      return Image.asset(
        'assets/icon/live_event/education_event_icon.png',
        width: width,
        height: height,
      );
  }
}

Widget getSharedEventIcon(
  PostModel model, {
  double height = 60,
  double width = 60,
}) {
  switch (model.share_post_id?.event_type) {
    case 'education':
      return Image.asset(
        'assets/icon/live_event/education_event_icon.png',
        width: width,
        height: height,
      );
    case 'work':
      return Image.asset(
        'assets/icon/live_event/work_event_icon.png',
        width: width,
        height: height,
      );
    case 'travel':
      return Image.asset(
        'assets/icon/live_event/travel_icon.png',
        width: width,
        height: height,
      );
    case 'customevent':
      return Image.asset(
        getCustomLifeEventIconName(
            model.share_post_id?.lifeEventId?.iconName ?? ''),
        width: width,
        height: height,
      );
    case 'milestonesandachievements':
      return Image.asset(
        'assets/icon/live_event/mileston_icon.png',
        width: width,
        height: height,
      );
    case 'relationship':
      return model.share_post_id?.event_sub_type == 'New Relationship'
          ? Image.asset(
              'assets/icon/live_event/in_relation_icon.png',
              width: width,
              height: height,
            )
          : model.share_post_id?.event_sub_type == 'Engagement'
              ? Image.asset(
                  'assets/icon/live_event/engaged_icon.png',
                  width: width,
                  height: height,
                )
              : model.share_post_id?.event_sub_type == 'Marriage'
                  ? Image.asset(
                      'assets/icon/live_event/marraid_icon.png',
                      width: width,
                      height: height,
                    )
                  : Image.asset(
                      'assets/icon/live_event/first_meet_icon.png',
                      width: width,
                      height: height,
                    );
    default:
      return Image.asset(
        'assets/icon/live_event/education_event_icon.png',
        width: width,
        height: height,
      );
  }
}
