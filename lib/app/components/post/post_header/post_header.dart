import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/api_constant.dart';
import '../../../config/app_assets.dart';
import '../../../data/login_creadential.dart';
import '../../../models/post.dart';
import '../../../models/user.dart';
import '../../../models/user_id.dart';

import '../../../modules/home/controllers/home_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/image.dart';
import '../../../utils/post_utlis.dart';
import '../../image.dart';
import '../../post_tag_list.dart';

class PostHeader extends StatelessWidget {
  final PostModel model;
  final VoidCallback onTapEditPost;
  final VoidCallback? onTapHidePost;
  final VoidCallback? onTapBookMarkPost;
  final VoidCallback? onTapRemoveBookMarkPost;
  final VoidCallback? onTapCopyPost;
  final VoidCallback? onTapViewPostHistory;
  final VoidCallback? onTapPinPost;
  final String? viewType;

  PostHeader(
      {super.key,
      required this.model,
      required this.onTapEditPost,
      this.onTapHidePost,
      this.onTapBookMarkPost,
      this.onTapCopyPost,
      this.onTapViewPostHistory,
      this.viewType,
      this.onTapPinPost,
      this.onTapRemoveBookMarkPost});

  RxString character = 'spam'.obs;

  TextEditingController reportDescription = TextEditingController();

  HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    UserIdModel userModel = model.user_id!;
    UserModel currentUserModel = LoginCredential().getUserData();
    return model.post_type == 'Shared'
        ? Container(
            padding: const EdgeInsets.only(top: 10),
            child: InkWell(
              onTap: () {
                if (LoginCredential().getUserData().username !=
                    model.share_post_id?.user_id?.username) {
                  Get.toNamed(Routes.OTHERS_PROFILE, arguments: {
                    'username': model.share_post_id?.user_id?.username,
                    'isFromReels': 'false'
                  });
                } else {
                  Get.toNamed(Routes.PROFILE);
                }
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 10),
                  RoundCornerNetworkImage(
                    imageUrl: getFormatedProfileUrl(
                      model.share_post_id!.user_id!.profile_pic ?? '',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                            text:
                                '${model.share_post_id!.user_id!.first_name} ${model.share_post_id!.user_id!.last_name}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(children: [
                            model.share_post_id?.feeling_id != null
                                ? TextSpan(children: [
                                    TextSpan(
                                        children: [
                                          const TextSpan(
                                              text: ' is feeling',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16)),
                                          WidgetSpan(
                                              child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 3.0),
                                            child: ReactionIcon(model
                                                    .feeling_id?.logo
                                                    .toString() ??
                                                ''),
                                          )),
                                          TextSpan(
                                              text:
                                                  ' ${model.feeling_id?.feelingName}',
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                              )),
                                        ],
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 16)),
                                  ])
                                : TextSpan(
                                    text: '',
                                    style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 16)),
                            TextSpan(
                                text: getSharedLocationText(model),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16)),
                            TextSpan(
                                text: getTagText(model),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.to(() => PostTagList(
                                          postModel: model,
                                        ));
                                  },
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16))
                          ]),
                        ])),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                                '${getDynamicFormatedTime(model.share_post_id!.createdAt ?? '')} '),
                            Text(
                              getTextAsPostType(
                                  model.share_post_id!.post_type ?? ''),
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Icon(
                              getIconAsPrivacy(
                                  model.share_post_id!.post_privacy ?? ''),
                              size: 17,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : (model.post_type == 'campaign')
            ? Container(
                padding: const EdgeInsets.only(top: 10),
                child: InkWell(
                  onTap: () {
                    Get.toNamed(Routes.PAGE_PROFILE,
                        arguments: model.campaign_id?.id);
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: 10),
                      RoundCornerNetworkImage(
                        imageUrl: getFormatedPageProfileUrl(
                          model.adProduct?.pageInfo?.profilePic ?? '',
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                text: '${model.adProduct?.pageInfo?.pageName}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              const TextSpan(children: []),
                            ])),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // Text(
                                //     '${getDynamicFormatedTime(model.share_post_id?.createdAt ?? '')} '),
                                Text(
                                  getTextAsPostType(model.post_type ?? ''),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                ),
                                Icon(
                                  getIconAsPrivacy(model.post_privacy ?? ''),
                                  size: 17,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container(
                padding: const EdgeInsets.only(top: 10),
                child: InkWell(
                  onTap: () {
                    if (LoginCredential().getUserData().username !=
                        userModel.username) {
                      Get.toNamed(Routes.OTHERS_PROFILE, arguments: {
                        'username': userModel.username,
                        'isFromReels': 'false'
                      });
                    } else {
                      Get.toNamed(Routes.PROFILE);
                    }

                    // Get.toNamed(Routes.OTHERS_PROFILE,
                    //     arguments: userModel.username);
                  },
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(width: 10),
                          RoundCornerNetworkImage(
                            imageUrl: getFormatedProfileUrl(
                              userModel.profile_pic ?? '',
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                    text:
                                        '${userModel.first_name} ${userModel.last_name}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(children: [
                                    model.feeling_id != null
                                        ? TextSpan(children: [
                                            TextSpan(
                                                children: [
                                                  const TextSpan(
                                                      text: ' is feeling',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 16)),
                                                  WidgetSpan(
                                                      child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 3.0),
                                                    child: ReactionIcon(model
                                                        .feeling_id!.logo
                                                        .toString()),
                                                  )),
                                                  TextSpan(
                                                      text:
                                                          ' ${model.feeling_id!.feelingName}',
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16,
                                                      )),
                                                ],
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16)),
                                          ])
                                        : TextSpan(
                                            text: '',
                                            style: TextStyle(
                                                color: Colors.grey.shade700,
                                                fontSize: 16)),
                                    TextSpan(
                                        text: getLocationText(model),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16)),
                                    TextSpan(
                                        text: getTagText(model),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Get.to(() => PostTagList(
                                                  postModel: model,
                                                ));
                                          },
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16))
                                  ]),
                                ])),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                        '${getDynamicFormatedTime(model.createdAt ?? '')} '),
                                    Text(
                                      getTextAsPostType(model.post_type ?? ''),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Icon(
                                      getIconAsPrivacy(
                                          model.post_privacy ?? ''),
                                      size: 17,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // =========================================================== Three Dot Icon ===========================================================

                          model.isBookMarked == true
                              ? const Padding(
                                  padding: EdgeInsets.only(top: 12.0),
                                  child: Icon(
                                    Icons.bookmark,
                                  ),
                                )
                              : Container(),

                          model.user_id?.id == currentUserModel.id
                              ? IconButton(
                                  onPressed: () {
                                    Get.bottomSheet(Container(
                                      height: viewType == 'profile'
                                          ? 375
                                          : viewType == 'bookmark'
                                              ? 340
                                              : 355,
                                      color: Colors.white,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          viewType == 'profile'
                                              ? InkWell(
                                                  onTap: onTapPinPost,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    child: Row(
                                                      children: [
                                                        const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 14),
                                                          child: Icon(
                                                            Icons.push_pin,
                                                            size: 20,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 8),
                                                          child:
                                                              model.pinPost ==
                                                                      false
                                                                  ? const Text(
                                                                      'Pin Post',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15),
                                                                    )
                                                                  : const Text(
                                                                      'UnPin Post',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox(),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          InkWell(
                                            onTap: onTapEditPost,
                                            child: const Padding(
                                              padding: EdgeInsets.only(top: 10),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 14),
                                                    child: Icon(
                                                      Icons.edit,
                                                      size: 20,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8),
                                                    child: Text(
                                                      'Edit Post',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          InkWell(
                                            onTap: onTapHidePost ?? () {},
                                            child: const Padding(
                                              padding: EdgeInsets.only(top: 10),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8),
                                                    child: Icon(
                                                      Icons.hide_image,
                                                      size: 20,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8),
                                                    child: Text(
                                                      'Hide Post',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          model.isBookMarked == false
                                              ? InkWell(
                                                  onTap: onTapBookMarkPost ??
                                                      () {},
                                                  child: const Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 10),
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 8),
                                                          child: Icon(
                                                            Icons.bookmark,
                                                            size: 20,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 8),
                                                          child: Text(
                                                            'Book Mark',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : InkWell(
                                                  onTap:
                                                      onTapRemoveBookMarkPost ??
                                                          () {},
                                                  child: const Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 10),
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 8),
                                                          child: Icon(
                                                            Icons.bookmark,
                                                            size: 20,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 8),
                                                          child: Text(
                                                            'Remove Book Mark',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          InkWell(
                                            onTap:
                                                onTapViewPostHistory ?? () {},
                                            child: const Padding(
                                              padding: EdgeInsets.only(top: 10),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8),
                                                    child: Icon(
                                                      Icons.edit_note,
                                                      size: 20,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8),
                                                    child: Text(
                                                      'Edit History',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          const InkWell(
                                            child: Padding(
                                              padding: EdgeInsets.only(top: 10),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8),
                                                    child: Icon(
                                                      Icons.notification_add,
                                                      size: 20,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8),
                                                    child: Text(
                                                      'Turn off notification',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          InkWell(
                                            onTap: onTapCopyPost,
                                            child: const Padding(
                                              padding: EdgeInsets.only(top: 10),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8),
                                                    child: Icon(
                                                      Icons.link_off,
                                                      size: 20,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8),
                                                    child: Text(
                                                      'Copy link',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              await showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                  content: SizedBox(
                                                    height: 220,
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        const Image(
                                                          height: 50,
                                                          width: 50,
                                                          fit: BoxFit.cover,
                                                          image: AssetImage(
                                                              AppAssets
                                                                  .DELETE__ICON),
                                                        ),
                                                        const Text(
                                                          'Delete Post',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                              fontSize: 20),
                                                        ),
                                                        const Text(
                                                            'Are you sure you want to delete this post ?'),
                                                        const Text(
                                                            'This action cannot be undone.'),
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            ElevatedButton(
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                backgroundColor:
                                                                    Colors
                                                                        .white,
                                                                side: const BorderSide(
                                                                    color: Colors
                                                                        .grey,
                                                                    width: 1),
                                                                // shadowColor: Colors.greenAccent,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                    10,
                                                                  ),
                                                                ),
                                                                minimumSize:
                                                                    const Size(
                                                                        100,
                                                                        40), //////// HERE
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(false);
                                                                Get.back();
                                                              },
                                                              child: const Text(
                                                                'Cancel',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ),
                                                            ElevatedButton(
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                backgroundColor:
                                                                    Colors.red,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                    10,
                                                                  ),
                                                                ),
                                                                minimumSize:
                                                                    const Size(
                                                                        100,
                                                                        40), //////// HERE
                                                              ),
                                                              onPressed: () {
                                                                // ProfileController
                                                                //     controller =
                                                                //     Get.put(
                                                                //         ProfileController());
                                                                // HomeController
                                                                //     homeController =
                                                                //     Get.put(
                                                                //         HomeController());
                                                                // controller
                                                                //     .deletePost(
                                                                //         model.id
                                                                //             .toString());
                                                                // Get.back();
                                                                // Navigator.of(
                                                                //         context)
                                                                //     .pop(false);
                                                                // controller
                                                                //     .postList
                                                                //     .value
                                                                //     .removeWhere((element) =>
                                                                //         element
                                                                //             .id ==
                                                                //         model.id
                                                                //             .toString());
                                                                // homeController
                                                                //     .postList
                                                                //     .value
                                                                //     .removeWhere((element) =>
                                                                //         element
                                                                //             .id ==
                                                                //         model.id
                                                                //             .toString());
                                                                // controller
                                                                //     .postList
                                                                //     .refresh();
                                                                // homeController
                                                                //     .postList
                                                                //     .refresh();
                                                              },
                                                              child: const Text(
                                                                'Delete',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            child: const Padding(
                                              padding: EdgeInsets.only(top: 10),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8),
                                                    child: Icon(
                                                      Icons.delete,
                                                      size: 20,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8),
                                                    child: Text(
                                                      'Delete',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ));
                                  },
                                  icon: const Icon(Icons.more_vert))
                              : IconButton(
                                  onPressed: () {
                                    Get.bottomSheet(Container(
                                      height: 250,
                                      color: Colors.white,
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          InkWell(
                                            onTap: onTapHidePost ?? () {},
                                            child: const Padding(
                                              padding: EdgeInsets.only(top: 10),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8),
                                                    child: Icon(
                                                      Icons.hide_image,
                                                      size: 20,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8),
                                                    child: Text(
                                                      'Hide Post',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          model.isBookMarked == false
                                              ? InkWell(
                                                  onTap: onTapBookMarkPost ??
                                                      () {},
                                                  child: const Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 10),
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 8),
                                                          child: Icon(
                                                            Icons.bookmark,
                                                            size: 20,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 8),
                                                          child: Text(
                                                            'Book Mark',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : InkWell(
                                                  onTap:
                                                      onTapRemoveBookMarkPost ??
                                                          () {},
                                                  child: const Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 10),
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 8),
                                                          child: Icon(
                                                            Icons.bookmark,
                                                            size: 20,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 8),
                                                          child: Text(
                                                            'Remove Book Mark',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          const InkWell(
                                            child: Padding(
                                              padding: EdgeInsets.only(top: 10),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8),
                                                    child: Icon(
                                                      Icons.notification_add,
                                                      size: 20,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8),
                                                    child: Text(
                                                      'Turn off notification',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          InkWell(
                                            onTap: onTapCopyPost,
                                            child: const Padding(
                                              padding: EdgeInsets.only(top: 10),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8),
                                                    child: Icon(
                                                      Icons.link_off,
                                                      size: 20,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8),
                                                    child: Text(
                                                      'Copy link',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              // await homeController.getReports();
                                              // CustomReportBottomSheet
                                              //     .showReportOptions(
                                              //   pageReportList: homeController
                                              //       .pageReportList.value,
                                              //   selectedReportType:
                                              //       homeController
                                              //           .selectedReportType,
                                              //   selectedReportId: homeController
                                              //       .selectedReportId,
                                              //   reportDescription:
                                              //       homeController
                                              //           .reportDescription,
                                              //   onCancel: () {
                                              //     Get.back();
                                              //   },
                                              //   reportAction:
                                              //       (String report_type_id,
                                              //           String report_type,
                                              //           String page_id,
                                              //           String description) {
                                              //     homeController.reportAPost(
                                              //         report_type: report_type,
                                              //         description: description,
                                              //         post_id: model.id ?? '',
                                              //         report_type_id:
                                              //             report_type_id);
                                              //   },
                                              // );
                                           
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Row(
                                                children: [
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10.0),
                                                    child: Icon(
                                                        Icons.report_outlined),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8),
                                                    child: GestureDetector(
                                                      onTap: () async {
                                                        ////////////////////report/////////////////////////////////////////////////
                                                        // await homeController
                                                        //     .getReports();
                                                        // CustomReportBottomSheet
                                                        //     .showReportOptions(
                                                        //   pageReportList:
                                                        //       homeController
                                                        //           .pageReportList
                                                        //           .value,
                                                        //   selectedReportType:
                                                        //       homeController
                                                        //           .selectedReportType,
                                                        //   selectedReportId:
                                                        //       homeController
                                                        //           .selectedReportId,
                                                        //   reportDescription:
                                                        //       homeController
                                                        //           .reportDescription,
                                                        //   onCancel: () {
                                                        //     Get.back();
                                                        //   },
                                                        //   reportAction: (String
                                                        //           report_type_id,
                                                        //       String report_type,
                                                        //       String page_id,
                                                        //       String
                                                        //           description) {
                                                        //     homeController.reportAPost(
                                                        //         report_type:
                                                        //             report_type,
                                                        //         description:
                                                        //             description,
                                                        //         post_id:
                                                        //             model.id ??
                                                        //                 '',
                                                        //         report_type_id:
                                                        //             report_type_id);
                                                        //   },
                                                        // );
                                                        ////////////////report///////////////////////////////////////////////////
                                                      },
                                                      child: const Text(
                                                        'Report',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ));
                                  },
                                  icon: const Icon(Icons.more_vert)),
                        ],
                      ),
                    ],
                  ),
                ),
              );
  }

  getIconAsPrivacy(String postPrivacy) {
    switch (postPrivacy) {
      case 'public':
        return Icons.public;
      case 'only_me':
        return Icons.lock;
      case 'friends':
        return Icons.people;
      default:
        return Icons.public;
    }
  }

  String getTextAsPostType(String postType) {
    switch (postType) {
      case 'campaign':
        return 'Sponsored ';
      default:
        return '';
    }
  }

  String getHeaderTextAsPostType(PostModel postModel) {
    switch (model.post_type) {
      case 'timeline_post':
        return '';
      case 'page_post':
        return '';
      case 'profile_picture':
        return 'updated his profile picture';
      case 'cover_picture':
        return 'updated his cover photo';
      case 'event':
        return '';
      case 'shared_reels':
        return '';
      case 'birthday':
        return '';
      case 'campaign':
        return '';
      default:
        return '';
    }
  }

  String getFeelingText(PostModel postModel) {
    return (model.feeling_id?.feelingName != null)
        ? ' is feeling ${model.feeling_id?.feelingName}'
        : '';
  }

  String getLocationText(PostModel postModel) {
    return (postModel.locationName.toString().contains('null') ||
            postModel.locationName.toString() == '')
        ? ''
        : ' at ${postModel.locationName}';
  }

  String getSharedLocationText(PostModel postModel) {
    return (postModel.share_post_id!.locationName.toString().contains('null'))
        ? ''
        : ' at ${model.share_post_id?.locationName}';
  }

  String getTagText(PostModel postModel) {
    if (postModel.taggedUserList != null) {
      if (postModel.taggedUserList!.length == 1) {
        return ' with ${postModel.taggedUserList![0].user?.firstName ?? ''}';
      } else if (postModel.taggedUserList!.length > 1) {
        return ' with ${postModel.taggedUserList![0].user?.firstName ?? ''} and ${postModel.taggedUserList!.length - 1} others';
      } else {
        return '';
      }
    } else {
      return '';
    }
  }

  String getSharedHeaderTextAsPostType(PostModel postModel) {
    switch (model.share_post_id!.post_type) {
      case 'timeline_post':
        return '';
      case 'page_post':
        return '';
      case 'profile_picture':
        return 'updated his profile picture';
      case 'cover_picture':
        return 'updated his cover photo';
      case 'event':
        return '';
      case 'shared_reels':
        return '';
      case 'birthday':
        return '';
      case 'campaign':
        return '';
      default:
        return '';
    }
  }

  Widget ReactionIcon(String reactionPath) {
    return Image(
        height: 17, image: NetworkImage(getFormatedFeelingUrl(reactionPath)));
  }

  String getFormatedFeelingUrl(String path) {
    return '${ApiConstant.SERVER_IP_PORT}/assets/logo/$path';
  }
}
