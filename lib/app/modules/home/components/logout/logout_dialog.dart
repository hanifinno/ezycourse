import 'package:ezycourse/app/modules/home/controllers/home_controller.dart';
import 'package:ezycourse/app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogoutDialog {
  static void showLogoutDialog() {
    HomeController controller = Get.find();
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              const Text(
                'Logout',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),

              // Subtitle
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  text: 'Are you sure, you want to log\n ',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                  ),
                  children: [
                    TextSpan(
                      text: 'out?',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              const Divider(
                indent: 1,
                endIndent: 1,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.logout();
                    },
                    child: const Text(
                      'Yes',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: PURPLE),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 50,
                    color: Colors.grey,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Text(
                      'No',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
