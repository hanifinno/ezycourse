import 'package:flutter/material.dart';

class CustomGradientElevatedButton extends StatelessWidget {
  final String text;
  final IconData? iconLeading; // Optional icon
  final IconData? iconTrailing; // Optional icon
  final Color textColor;
  final double fontSize;
  final double height;
  final double? width;
  final FontWeight fontWeight;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onPressed;
  final List<Color> gradientColors;
  final double elevation;
  final BorderRadius? borderRadius;

  const CustomGradientElevatedButton({
    super.key,
    required this.text,
    this.iconLeading,
    this.iconTrailing,
    this.textColor = Colors.white,
    this.fontSize = 16.0,
    this.height = 16.0,
    this.width ,
    this.borderRadius,
    this.fontWeight = FontWeight.normal,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    this.margin ,
    this.onPressed,
    required this.gradientColors, // Gradient colors
    this.elevation = 2.0, // Button elevation
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent, 
        elevation: 0, 
        padding: padding,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        side: BorderSide.none, 
      ),
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius:borderRadius?? BorderRadius.circular(8.0),
        ),
        child: Container(
          width:width?? double.infinity,
          height: height, // Set button height
          padding: padding,
          margin: margin,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon, if provided
              if (iconLeading != null) ...[
                Icon(iconLeading, color: textColor),
                const SizedBox(width: 8), // Space between icon and text
              ],
              // Text
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  fontFamily: 'Inter'
                ),
              ),
       iconTrailing !=null?       const Spacer(): const SizedBox.shrink(),
              // Icon, if provided
              if (iconTrailing != null) ...[
                const SizedBox(width: 8), // Space between text and icon
                Icon(iconTrailing, color: textColor),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
