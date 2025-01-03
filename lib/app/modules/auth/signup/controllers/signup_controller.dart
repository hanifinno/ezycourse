import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../enum/singing_character.dart';
import '../../../../models/api_response.dart';
import '../../../../models/gender.dart';
import '../../../../routes/app_pages.dart';
import '../../../../services/api_communication.dart';
import '../../../../utils/snackbar.dart';

class SignupController extends GetxController {
  late final ApiCommunication _apiCommunication;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController mobileController;
  late TextEditingController passwordController;
  Rx<bool> obscureText = true.obs;

  final GlobalKey<FormState> nameFormKey = GlobalKey();
  final GlobalKey<FormState> emailFormKey = GlobalKey();
  final GlobalKey<FormState> otpFormKey = GlobalKey();
  final GlobalKey<FormState> mobileFormKey = GlobalKey();
  final GlobalKey<FormState> passwordFormKey = GlobalKey();

  Rx<DateTime> selectedDate = DateTime.now().obs;
    Rx<File?> selectedProfileImage = Rx<File?>(null); 

  Rx<double> year = 0.0.obs;
  var otp = ''.obs; // To store the entered OTP
  var remainingSeconds = 60.obs; // For countdown timer
  var resendEnabled = true.obs; // To enable/disable resend button
  Timer? timer;
  String? newEmail;

  Rx<List<GenderModel>> genderList = Rx([]);
      XFile? xFile;

  Rx<Gender> character = Gender.Male.obs;
  Rx<GenderModel?> selectedGender = Rx(null);

  // Method to verify OTP
  void verifyOtp(String otp) async {
    ApiResponse apiResponse = await _apiCommunication.doPostRequest(
      apiEndPoint: 'otp-verification',
      requestData: {
        'email': emailController.text,
        'otp': otp
      },
    );

  if (otp.isEmpty) {
   showErrorSnackkbar(message: 'Please Provide your OTP');
  } else if (apiResponse.isSuccessful) {
      Get.toNamed(Routes.PASSWORD);
      showSuccessSnackkbar(message: '${apiResponse.message}');
    } else {
      showErrorSnackkbar(message: '${apiResponse.message}');
    }
  }

  void onTapPickProfileImage() async {
    // Use ImagePicker or similar package to pick an image
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedProfileImage.value = File(pickedFile.path);
    }
  }

  // Method to remove the selected profile image
  void removeProfileImage() {
    selectedProfileImage.value = null;
  }

  // Add validation for profile picture in the form
  String? validateProfilePic() {
    if (selectedProfileImage.value == null) {
      return 'Profile Pic cannot be empty';
    }
    return null;
  }

  //------------------------------- PROFILE PICTURES ----------------------------//

  void sendOtp() async {
    ApiResponse apiResponse = await _apiCommunication.doPostRequest(
      apiEndPoint: 'email-verification',
      requestData: {
        'email': emailController.text,
      },
    );

    if (apiResponse.isSuccessful) {
      showSuccessSnackkbar(message: '${apiResponse.message}');
    } else {
      showErrorSnackkbar(message: '${apiResponse.message}');
    }
  }

  // Method to start the OTP resend timer
  void startOtpResendTimer() {
    remainingSeconds.value = 120;
    resendEnabled.value = false;

    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 120), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        resendEnabled.value = true;
        timer.cancel();
      }
    });
  }

  void resendOtp(String email) {
    print("Resending OTP to email: $email");
    startOtpResendTimer();
  }

  void onSelectDate(DateTime dateTime) {
    selectedDate.value = dateTime;
    Duration difference = DateTime.now().difference(selectedDate.value);
    year.value = difference.inDays / 365;
  }

  void getGenders() async {
    final ApiResponse apiResponse = await _apiCommunication.doGetRequest(
      apiEndPoint: 'gender',
      responseDataKey: 'allGender',
    );
    if (apiResponse.isSuccessful) {
      genderList.value = (apiResponse.data as List)
          .map((element) => GenderModel.fromMap(element))
          .toList();
    } else {
      // debugPrint('Test');
    }
  }

  void onClickNextFromGender() {
    if (selectedGender.value == null) {
      showWarningSnackkbar(message: 'Please select gender first');
    } else {
      Get.toNamed(Routes.NUMBER);
    }
  }

  void signUp() async {
    if (passwordFormKey.currentState!.validate()) {
      final ApiResponse apiResponse = await _apiCommunication.doPostRequest(
        apiEndPoint: 'signup',
        mediaFiles: [selectedProfileImage.value!],
        isFormData: true,
        fileKey: 'profile_pic',
        requestData: {
          'first_name': firstNameController.text,
          'last_name': lastNameController.text,
          'email': emailController.text,
          'otp':otp.value,
          'password': passwordController.text,
          'phone': mobileController.text,
          'gender': selectedGender.value?.id,
          'day': selectedDate.value.day,
          'month': selectedDate.value.month,
          'year': selectedDate.value.year,
          
          'isAccept': true,
        },
      );
      if (apiResponse.isSuccessful) {
        Get.until((route) => Get.currentRoute == Routes.LOGIN);
      } else {
        // debugPrint('');
      }
    }
  }

  @override
  void onInit() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    mobileController = TextEditingController();
    // mobileController.text = '+880';
    passwordController = TextEditingController();
    _apiCommunication = ApiCommunication();
    onSelectDate(DateTime(2000, 01, 01));
    super.onInit();
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    passwordController.dispose();
    _apiCommunication.endConnection();
    super.onClose();
  }
}
