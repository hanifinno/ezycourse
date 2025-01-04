import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/login_creadential.dart';
import '../../../data/post.dart';
import '../../../data/post_color_list.dart';
import '../../../models/api_response.dart';
import '../../../models/post.dart';
import '../../../services/api_communication.dart';
import '../../../utils/snackbar.dart';

class CreatePostController extends GetxController {
  late ApiCommunication _apiCommunication;
  late LoginCredential _loginCredential;
  late UserModel userModel;
  late TextEditingController descriptionController;

  var feelingController = ''.obs;
  var tagPeopleController = ''.obs;
  RxString wordLimit = ''.obs;

  // For Background color post view
  Rx<LinearGradient?> postGradientBackground = postListColor.first.obs;
  Rx<bool> isBackgroundColorPost = false.obs;

  Rx<String> postPrivacy = 'Public'.obs;

  RxString dropdownValue = privacyList.first.obs;
  Rx<List<XFile>> xfiles = Rx([]);


  String? getBackgroundColor() {
    if (isBackgroundColorPost.value) {
      final gradient = postGradientBackground.value;
      if (gradient != null) {
        return jsonEncode({
          'colors': gradient.colors
              .map((color) =>
                  color.value.toRadixString(16).padLeft(8, '0').substring(2, 8))
              .toList(),
        });
      }
    }
    return null;
  }

  bool isValidPost() {
    if (descriptionController.text.isNotEmpty || xfiles.value.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<void> onTapCreatePost() async {
    if (!isValidPost()) {
      showWarningSnackkbar(message: 'Empty post cannot be submitted');
      return;
    }

    final requestData = {
      'feed_txt': descriptionController.text,
      'community_id': 2914,
      'space_id': 5883,
      'upload_type': 'text',
      'activity_type': 'group',
      'is_background': isBackgroundColorPost.value ? 1 : 0,
      'post_background_color': getBackgroundColor(),
    };

    final ApiResponse response = await _apiCommunication.doPostRequest(
      apiEndPoint: 'save-post',
      isFormData: true,
      enableLoading: true,
      requestData: requestData,
    );

    if (response.isSuccessful) {
      Get.back();
      showSuccessSnackkbar(message: 'Post submitted successfully');
    } else {
      showWarningSnackkbar(message: 'Failed to submit post');
    }
  }

  Future<void> pickFiles() async {
    final ImagePicker picker = ImagePicker();
    List<XFile> mediaXFiles = await picker.pickMultipleMedia();
    xfiles.value.addAll(mediaXFiles);
    xfiles.refresh();
  }

  @override
  void onInit() {
    _apiCommunication = ApiCommunication();
    _loginCredential = LoginCredential();
    xfiles.value = Get.arguments?['media_files'] ?? [];
    descriptionController = TextEditingController();
    userModel = _loginCredential.getUserData();
    super.onInit();
  }

  @override
  void onClose() {
    _apiCommunication.endConnection();
    descriptionController.dispose();
    xfiles.value.clear();
    super.onClose();
  }
}
