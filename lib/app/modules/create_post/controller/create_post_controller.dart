import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  Rx<Color> postBackgroundColor = postListColor.first.obs;
  Rx<bool> isBackgroundColorPost = false.obs;


  // RxString orgName = ''.obs;

  // Rx<String?> endDate = Rx(null);

  RxString dropdownValue = privacyList.first.obs;

  Rx<List<XFile>> xfiles = Rx([]);


  



  //Relationship
  Rx<String> postPrivacy = 'Public'.obs;



  String? getBackgroundColor() {
    if (isBackgroundColorPost.value) {
      return postBackgroundColor.value.value.toRadixString(16).substring(2, 8);
    } else {
      return null;
    }
  }

  bool isValidPost() {
    if (descriptionController.text.isNotEmpty || xfiles.value.isNotEmpty) {
      if (getBackgroundColor() != null) {}
      return true;
    }
    return false;
  }

  Future<void> onTapCreatePost() async {
    if (!isValidPost()) {
      showWarningSnackkbar(message: 'Empty post can not be submitted');
    } else {
      final ApiResponse response = await _apiCommunication.doPostRequest(
          apiEndPoint: 'save-post',
          isFormData: true,
          enableLoading: true,
          requestData: {
            'feed_txt': descriptionController.text,
            'community_id': 2914,
            'space_id': 5883,
            'upload_type': 'text',
            'activity_type': 'group',
            'is_background': 0,
            // 'post_privacy': (getPostPrivacyValue(dropdownValue.value)),
            // 'post_background_color': getBackgroundColor(),
            
          },
       );
      if (response.isSuccessful) {
        Get.back();
        showSuccessSnackkbar(message: 'Post submitted successfully');
      } else {
        debugPrint('');
      }
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
    if (Get.arguments != null) {
      xfiles.value = Get.arguments['media_files'];
    }
    else{
      xfiles.value = [];
    }
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
