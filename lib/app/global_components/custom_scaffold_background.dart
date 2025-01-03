import 'package:flutter/material.dart';

import '../config/app_assets.dart';

class CustomScaffold extends StatelessWidget {
  final Widget? appBar; 
  final Widget body;
  // final String backgroundImage;

  const CustomScaffold({
    super.key,
    required this.body,
    // required this.backgroundImage,
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar as PreferredSizeWidget?, 
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.APP_BG),
            fit: BoxFit.cover, 
          ),
        ),
        child: body, 
      ),
    );
  }
}
