import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/follower_user_model.dart';
import '../../utils/color.dart';
import '../../utils/image.dart';
import '../image.dart';

class FollowerCard extends StatelessWidget {
  const FollowerCard({
    super.key,
    required this.model,
    required this.onTapBlock
  });

  final UserId model;
  final VoidCallback onTapBlock;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 0.0,
      leading: Container(
        height: Get.width * 0.30,
        margin: const EdgeInsets.only(bottom: 5),
        child: RoundCornerNetworkImage(
          imageUrl: getFormatedProfileUrl(model.profilePic ?? ''),
        ),
      ),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${model.firstName ?? ''} ${model.lastName ?? ''}',
            style:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const Spacer(),
          PopupMenuButton(
              padding: const EdgeInsets.only(left: 20, bottom: 15),
              iconColor: Colors.black,
              icon: const Icon(
                Icons.more_vert_rounded,
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: () {
                    Get.dialog(AlertDialog(
                      contentPadding: const EdgeInsets.all(0),
                      content: Container(
                        decoration: BoxDecoration(
                          color: PRIMARY_COLOR,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 200,
                        width: Get.width,
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.stretch,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'Block A Friend',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.white),
                                child: Column(
                                  children: [
                                    const Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Are you sure, you want to block?',
                                              style:
                                              TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              style: ElevatedButton
                                                  .styleFrom(
                                                backgroundColor:
                                                Colors.white,
                                                foregroundColor:
                                                PRIMARY_COLOR,
                                              ),
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: const Text(
                                                'No',
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: ElevatedButton(
                                              style: ElevatedButton
                                                  .styleFrom(
                                                backgroundColor:
                                                PRIMARY_COLOR,
                                                foregroundColor:
                                                Colors.white,
                                              ),
                                              onPressed: () {
                                                onTapBlock();
                                                Get.back();
                                              },
                                              child: const Text('Yes'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ));
                  },
                  value: 1,
                  // row has two child icon and text.
                  child: const Text(
                    'Block',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ]),
        ],
      ),
    );
  }
}
