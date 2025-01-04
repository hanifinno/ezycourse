import 'package:ezycourse/app/config/app_assets.dart';
import 'package:ezycourse/app/modules/home/components/logout/logout_dialog.dart';
import 'package:ezycourse/app/modules/home/controllers/home_controller.dart';
import 'package:ezycourse/app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomNavBar extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
        currentIndex: controller.selectedIndex.value,
        onTap: controller.changeTab,
        backgroundColor: Colors.white,
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AppAssets.COMMUNITY,
                  height: 24,
                  width: 24,
                ),
                const SizedBox(height: 4),
                const Text(
                  'Community',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: (){
               LogoutDialog.showLogoutDialog();
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    AppAssets.LOGOUT,
                    height: 24,
                    width: 24,
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Logout',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
