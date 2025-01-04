import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/post_color_list.dart';
import '../../../utils/color.dart';
import '../controller/create_post_controller.dart';

class CreatePostView extends GetView<CreatePostController> {
  const CreatePostView({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();

    return Scaffold(
      backgroundColor: PRIMARY_GREY_COLOR,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child:  Text(
                    "Close",
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                // Title
                const Text(
                  "Create Post",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Create Button
                TextButton(
                  onPressed: () {
                    controller.onTapCreatePost();
                  },
                  child: const Text(
                    "Create",
                    style: TextStyle(
                      color: PURPLE,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Input Box
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
            child: TextFormField(
              controller: controller.descriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "What’s on your mind?",
                hintStyle: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
                fillColor: Colors.white, 
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none, 
                  borderRadius:
                      BorderRadius.circular(8), 
                ),
              ),
              cursorColor: PRIMARY_COLOR, 
              style: const TextStyle(fontSize: 18),
            ),
          ),

          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, right: 8),
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 1,
                  ),
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    if (_scrollController.hasClients) {
                      _scrollController.animateTo(
                        _scrollController.offset - 50,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                ),
              ),

              // Color List
              Expanded(
                child: Container(
                  height: 30,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ListView.builder(
                    controller: _scrollController,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: postListColor.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          // Your logic for selecting colors
                          print('Selected color index: $index');
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            gradient: postListColor[index],
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
