import 'package:ezycourse/app/config/app_assets.dart';
import 'package:ezycourse/app/utils/color.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String subtitle;

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(10.0), 
        child: Image.asset(
          AppAssets.MENU,
          height: 24, 
          width: 24,  
          fit: BoxFit.contain, 
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
        ],
      ),
      backgroundColor: PRIMARY_COLOR,
      elevation: 4.0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80.0);
}
