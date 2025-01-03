import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/button.dart';
import '../../../../components/text_form_field.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/color.dart';
import '../controllers/signup_controller.dart';

class NameView extends GetView<SignupController> {
  const NameView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.arrow_back_ios, color: Colors.black),
            ),
            const Text(
              'Create account',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(height: 1),
            const SizedBox(height: 40),
            const Center(
              child: Text(
                "What's your name?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Enter the name you use in real life.',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(32),
              child: Form(
                key: controller.nameFormKey,
                child: Row(
                  children: [
                    Expanded(
                      child: SignUpTextFormField(
                        controller: controller.firstNameController,
                        label: 'First Name',
                        validationText: 'First name is required',
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: SignUpTextFormField(
                        controller: controller.lastNameController,
                        label: 'Last Name',
                        validationText: 'First name is required',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Profile Photo',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                controller.onTapPickProfileImage();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: DottedBorder(
                  color: PRIMARY_COLOR,
                  strokeWidth: 2,
                  dashPattern: const [8, 4],
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(12),
                  child: Container(
                    width: double.infinity,
                    // margin: EdgeInsets.symmetric(horizontal: 10),
                    // padding: EdgeInsets.symmetric(horizontal: 10),

                    height: 200,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icon/group_profile/file_upload.png',
                          height: 30,
                          width: 30,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Click to Upload Photo',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: PRIMARY_COLOR,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Obx(() {
              return Visibility(
                visible: controller.selectedProfileImage.value != null
                    ? true
                    : false,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        // Display the selected image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: controller.selectedProfileImage.value != null
                              ? Image.file(
                                  controller.selectedProfileImage.value!,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                )
                              : null, // If no image is selected, show nothing
                        ),
                        // Close icon to remove the image
                        IconButton(
                          onPressed: () {
                            controller.removeProfileImage();
                          },
                          icon: const Icon(Icons.close, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      onPressed: () {
                        // Validate the form and the profile picture
                        if (controller.nameFormKey.currentState!.validate() &&
                            controller.validateProfilePic() == null) {
                          Get.toNamed(Routes.BIRTHDAY);
                        } else {
                          // Show validation message for profile picture
                          if (controller.validateProfilePic() != null) {
                            Get.snackbar(
                              'Validation Error',
                              controller.validateProfilePic()!,
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          }
                        }
                      },
                      text: 'Next',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
