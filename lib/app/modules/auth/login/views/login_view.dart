import 'package:ezycourse/app/components/responsive/responsive.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/app_assets.dart';

import '../../../../global_components/custom_elevated_button.dart';
import '../../../../global_components/custom_fonts.dart';
import '../../../../global_components/custom_gradient_elevated_button.dart';
import '../../../../global_components/custom_textbutton.dart';
import '../../../../global_components/custom_textformfield.dart';
import '../../../../utils/color.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        extendBody: true,
        backgroundColor: PRIMARY_COLOR,
        body: SingleChildScrollView(
          child: Container(
            height: Responsive.getHeight(context),
            width: Responsive.getWidth(context),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppAssets.APP_BG), fit: BoxFit.cover)),
            child: Column(
              children: [
                // ============================================================ top section ===========================================================================
                Container(
                  width: Responsive.getWidth(context),
                  padding: const EdgeInsetsDirectional.only(
                      top: 56, start: 16, end: 16, bottom: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: Responsive.getHeight(context) / 8),
                        padding: const EdgeInsets.only(
                          left: 30,
                          right: 30,
                        ),
                        child: Image.asset(
                          AppAssets.APP_LOGO,
                          // height: 72,
                          // width: 72,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                // ==================== form field section ======================
                Container(
                  padding: const EdgeInsets.only(
                    top: 5,
                  ),
                  width: Responsive.getWidth(context),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )),
                  child: Container(
                    width: Responsive.getWidth(context),
                    padding: EdgeInsets.only(top: 20,bottom: 60, left: 20, right: 20),
                    decoration: const BoxDecoration(
                        color: PRIMARY_COLOR_3,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        )),
                    child: Column(
                      children: [
                        Form(
                          key: controller.loginFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: const Text(
                                  'Sign In',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Inter',
                                    fontSize: 38,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 50,),
                              // ============== email/username field =================
                              const Text(
                                'Email',
                                style: TextStyle(
                                  color: TEXT_WHITE_1,
                                  fontFamily: 'Inter',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              CustomTextFormField(
                                controller: controller.userIdController,
                                hintText: 'johndoe@gmail.com',
                                hintStyle:
                                    CustomTextStyles.interBlack(color: Colors.grey),
                              ),
                              const SizedBox(height: 16),
                              // ================= password field =====================
                              const Text(
                                'Password',
                                style: TextStyle(
                                  color: TEXT_WHITE_1,
                                  fontFamily: 'Inter',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Obx(() {
                                return CustomTextFormField(
                                  obscureText: controller.obscureText.value,
                                  controller: controller.passwordController,
                                  hintText: 'Type your password',
                                  hintStyle:
                                      CustomTextStyles.interBlack(color: Colors.grey),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      controller.obscureText.value
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      controller.obscureText.value =
                                          !controller.obscureText.value;
                                    },
                                  ),
                                );
                              }),
                              const SizedBox(height: 16),
                              CustomTextButton(
                                  padding: EdgeInsets.zero,
                                  activeColor: Colors.white,
                                  checkBorderColor: Colors.white,
                                  isCheckBox: true,
                                  isChecked: false,
                                  onChanged: (value) {},
                                  onPressed: () {},
                                  textColor: Colors.white,
                                  text: 'Remember me'),
                              const SizedBox(height: 32),
                              // ================ login button
                              CustomGradientElevatedButton(
                                borderRadius: BorderRadius.circular(15),
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                height: 50,
                                text: 'Login',
                                fontWeight: FontWeight.bold,
                                gradientColors: const [
                                  BUTTON_GRADIENT_FIRST_COLOR,
                                  BUTTON_GRADIENT_SECOND_COLOR,
                                ],
                                onPressed: () {
                                  controller.onPressedLogin();
                                },
                              ),
                              const SizedBox(height: 16),
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
        ),
      ),
    );
  }
}
