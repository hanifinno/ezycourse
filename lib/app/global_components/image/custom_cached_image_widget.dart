import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../config/app_assets.dart';

class CustomCachedImageWidget extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;
  final Color? backgroundColor;
  final bool isAllSideRadius;
  const CustomCachedImageWidget(
      {required this.imageUrl,
      this.width,
      this.height,
      required this.fit,
      this.placeholder,
      this.errorWidget,
      this.isAllSideRadius = false,
      this.backgroundColor = Colors.purple,
      super.key});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        imageBuilder: (context, imageProvider) => Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: isAllSideRadius
                    ? BorderRadius.circular(10)
                    : const BorderRadius.vertical(top: Radius.circular(10)),
                image: DecorationImage(image: imageProvider, fit: fit))),
        placeholder: (context, url) =>
            placeholder ??
            Container(
              height: height,
              width: width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: isAllSideRadius
                      ? BorderRadius.circular(10)
                      : const BorderRadius.vertical(top: Radius.circular(10))),
              child: const SizedBox(
                height: 16,
                width: 16,
                child: CircularProgressIndicator(
                    color: Colors.grey, strokeWidth: 2),
              ),
            ),
        errorWidget: (context, url, error) =>
            errorWidget ??
            Container(
              height: height,
              width: width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage(AppAssets.DEFAULT_IMAGE),
                      fit: BoxFit.cover),
                  color: Colors.grey[500],
                  borderRadius: isAllSideRadius
                      ? BorderRadius.circular(10)
                      : const BorderRadius.vertical(top: Radius.circular(10))),
            ),
        fadeInDuration: const Duration(milliseconds: 500),
        fadeOutDuration: const Duration(milliseconds: 500),
        color: backgroundColor);
  }
}
