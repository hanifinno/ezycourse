import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String? text;
  final String? imageAsset; // Optional image asset
  final Color? textColor;
  final Color? backgroundColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onPressed;
  final Color? splashColor;
  final Color? highlightColor;
  final double? elevation;

  const CustomElevatedButton({
    super.key,
    required this.text,
    this.imageAsset, // Optional asset image
    this.textColor = Colors.white, // Default text color
    this.backgroundColor = Colors.blue, // Default background color
    this.fontSize = 16.0, // Default font size
    this.fontWeight = FontWeight.normal, // Default font weight
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    this.onPressed,
    this.splashColor,
    this.highlightColor,
    this.elevation = 2.0, // Default elevation
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Colors.white, // White background
        padding: padding,
        elevation: elevation, // Button elevation
        splashFactory: splashColor != null ? InkRipple.splashFactory : null,
        foregroundColor: splashColor ?? Colors.grey.withOpacity(0.3), // Default splash color
        // highlightColor: highlightColor ?? Colors.grey.withOpacity(0.1), // Default highlight color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (imageAsset != null)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Image.asset(
                imageAsset!,
                width: 24.0, // Image width
                height: 24.0, // Image height
              ),
            ),
          Text(
            text ?? '',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: textColor ?? Colors.black, // Text color (black for white background)
            ),
          ),
        ],
      ),
    );
  }
}
