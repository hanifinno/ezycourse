import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/app_assets.dart';
import '../button.dart';
import '../simmar_loader.dart';

class PostShimerLoader extends StatelessWidget {
  const PostShimerLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 10),
                  ShimmerLoader(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: const CircleAvatar(
                        radius: 19,
                        backgroundColor: Color.fromARGB(255, 45, 185, 185),
                        child: CircleAvatar(
                          radius: 17,
                          backgroundImage:
                              AssetImage(AppAssets.DEFAULT_PROFILE_IMAGE),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShimmerLoader(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 15,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                border:
                                    Border.all(color: Colors.white, width: 0),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              width: Get.width - 100,
                            ),
                            const SizedBox(height: 7),
                            Container(
                              height: 15,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                border:
                                    Border.all(color: Colors.white, width: 0),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              width: Get.width / 2,
                            ),
                          ],
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ShimmerLoader(
              child: Container(
                width: double.maxFinite,
                height: 256,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ShimmerLoader(
                  child: PostActionButton(
                    assetName: AppAssets.LIKE_ICON,
                    text: 'Like',
                    onPressed: () {},
                  ),
                ),
                ShimmerLoader(
                  child: PostActionButton(
                    assetName: AppAssets.COMMENT_ACTION_ICON,
                    text: 'Comment',
                    onPressed: () {},
                  ),
                ),
                ShimmerLoader(
                  child: PostActionButton(
                    assetName: AppAssets.SHARE_ACTION_ICON,
                    text: 'Share',
                    onPressed: () {},
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
