import 'package:flutter/material.dart';

class CustomCircularImage extends StatelessWidget {
  final String imageUrl;
  final Alignment? alignement;
  final double radius; // Radius for the circular image
  // final String errorImageUrl; // URL for the error image
  final double? imageHeight; // URL for the error image
  final double? imageWidth; // URL for the error image

  const CustomCircularImage({
    super.key,
    required this.imageUrl,
    this.radius = 50.0, // Default radius if not provided
    // required this.errorImageUrl, 
    this.imageHeight,this.imageWidth, this.alignement
    // Error image to show if network image fails
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignement?? Alignment.center,
      child: ClipOval(
        child: Image.network(
          imageUrl,
          width: imageWidth?? radius * 2, // Double the radius for diameter
          height: imageWidth?? radius * 2, // Double the radius for diameter
          fit: BoxFit.cover, // Ensure the image covers the entire circle
          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child; // Image loaded successfully
            } else {
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                      : null,
                ),
              );
            }
          },
          errorBuilder: (context, error, stackTrace) {
            return ClipOval(
              child: Image.asset(
                'assets/images/profile.png',
                width:imageWidth?? radius * 2,
                height:imageHeight?? radius * 2,
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      ),
    );
  }
}
