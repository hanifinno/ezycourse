import 'dart:io';

import 'package:ezycourse/app/config/app_assets.dart';
import 'package:ezycourse/app/utils/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../components/image.dart';
import '../../../data/post_color_list.dart';
import '../../../utils/color.dart';
import '../../../utils/post_type.dart';
import '../controller/create_post_controller.dart';


class CreatePostView extends GetView<CreatePostController> {
  const CreatePostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Create Post',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            InkWell(
              onTap: () {
                controller.onTapCreatePost();
              },
              child: const Text(
                'Post',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              children: [
                NetworkCircleAvatar(
                    imageUrl:
                        AppAssets.DEFAULT_PROFILE_IMAGE),
                const SizedBox(
                  width: 5,
                ),
                Obx(() => Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                              text: TextSpan(children: [
                           
                            TextSpan(
                                    text: '',
                                    style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 16)),
                            
                             TextSpan(
                                        text: '',
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 16)),
                          ])),
                          const SizedBox(
                            height: 5,
                          ),
                             ],
                      ),
                    ))
              ],
            ),
          ),
          Obx(
            () => controller.isBackgroundColorPost.value
                ? Container(
                    width: double.maxFinite,
                    height: 240,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: controller.postBackgroundColor.value,
                    ),
                    child: TextFormField(
                      validator: (text) {
                        if (text!.length >= 101) {
                          return 'You have crossed word limit';
                        }
                        return null;
                      },
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(101),
                      ],
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: const TextStyle(fontSize: 25, color: Colors.white),
                      controller: controller.descriptionController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        errorText: controller.wordLimit.value.length >= 101
                            ? 'You have crossed word limit'
                            : null,
                        hintText:
                            'What’s on your mind?',
                      ),
                      onChanged: (val) {
                        controller.wordLimit.value = val.toString();
                        //                final linkRegex = RegExp(
                        //     r'http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\\(\\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+');
                        // final match = linkRegex.firstMatch(val);
                        // if (match != null) {
                        //   final url = match.group(0)!;
                        //   controller.getLinkPreview(url);
                        // } else {
                        //   controller.clearPreview();
                        // }
                      },
                    ),
                  )
                : TextFormField(
                    onChanged: (value) {
                      
                    },
                    controller: controller.descriptionController,
                    maxLines: 10,
                    decoration: InputDecoration(
                      //alignLabelWithHint: false,
                      fillColor: Colors.white,
                      filled: true,
                      border: InputBorder.none,
                      hintText:
                          'What’s on your mind ?',
                      hintStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                  ),
          ),
      
          //========================================= Color ListView for Post =================================================//
          Obx(() => Visibility(
                visible: !controller.xfiles.value.isNotEmpty,
                child: Container(
                  width: Get.width,
                  height: 35,
                  margin: const EdgeInsets.only(top: 10),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: postListColor.length,
                    scrollDirection: Axis.horizontal,
                    physics: const ScrollPhysics(),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          if (index == 0) {
                            controller.isBackgroundColorPost.value = false;
                          } else {
                            controller.isBackgroundColorPost.value = true;
                            controller.postBackgroundColor.value =
                                postListColor[index];
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          height: 20,
                          width: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: postListColor[index]),
                        ),
                      );
                    },
                  ),
                ),
              )),

//
          //========================================= Image ListView for Post =================================================//

          Obx(
            () => Visibility(
              visible: controller.xfiles.value.isNotEmpty,
              child: Container(
                margin: const EdgeInsets.only(top: 10, left: 10),
                decoration: const BoxDecoration(),
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.xfiles.value.length,
                  itemBuilder: (BuildContext context, int index) {
                    XFile xFile = controller.xfiles.value[index];
                    return Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Image(
                            fit: BoxFit.cover,
                            height: 100,
                            width: 100,
                            image: FileImage(
                              File(xFile.path),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 5,
                          right: 10,
                          child: InkWell(
                            onTap: () {
                              controller.xfiles.value.removeAt(index);
                              controller.xfiles.refresh();
                            },
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
          //========================================= Other option adding icon =================================================//
          Expanded(
            child: Obx(() => Card(
                  shadowColor: Colors.black,
                  elevation: 4,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        //=============================== Add Photo
                        Visibility(
                          visible: !controller.isBackgroundColorPost.value,
                          child: InkWell(
                            onTap: () {
                              controller.pickFiles();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                PostType(
                                  icon: Image.asset(
                                    AppAssets.ADD_PHOTO_ICON,
                                    height: 30,
                                    width: 30,
                                  ),
                                  title: 'Photo/Video',
                                ),
                                Obx(() => Text(
                                      '${controller.xfiles.value.length} Added ',
                                      style: const TextStyle(fontSize: 16),
                                    ))
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                     
                        const SizedBox(
                          height: 20,
                        ),
                    
                           ],
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }


}
