import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final IconData? icon; // Optional icon
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onPressed;
  final Color? splashColor;
  final TextDecoration? textDecoration;
  final Color? highlightColor;
  final Color? activeColor;
  final Color? checkBorderColor;
  final bool? isChecked; // Optional checkbox
  final bool? isCheckBox; // Optional checkbox
  final ValueChanged<bool?>? onChanged; // Corrected type: nullable bool?

  const CustomTextButton({
    super.key,
    required this.text,
    this.icon,
    this.textDecoration,
    this.textColor = Colors.blue, // Default text color
    this.fontSize = 14.0, // Default font size
    this.fontWeight = FontWeight.normal, // Default font weight
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    this.onPressed,
    this.splashColor,
    this.highlightColor,
    this.checkBorderColor,
    this.activeColor,
    this.isChecked = false, // Default checkbox state is false
    this.isCheckBox = false, // Default checkbox state is false
    this.onChanged, // Optional callback for checkbox state change
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: padding,
        backgroundColor: splashColor,
        foregroundColor: highlightColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isCheckBox == true)
            Checkbox(
              // shape: OutlineInputBorder(),
              value: isChecked,
              side: BorderSide(color: checkBorderColor ?? Colors.white),
              onChanged: onChanged, // Accept nullable bool?
              checkColor: textColor, // Color of the check icon
              activeColor: activeColor ?? Colors.green, // Color when checked
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          if (icon != null) Icon(icon, color: textColor),
          Text(
            text,
            style: TextStyle(
                decoration: textDecoration ?? TextDecoration.underline,
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: textColor,
                fontFamily: 'Inter'
                // fontStyle:
                ),
          ),
        ],
      ),
    );
  }
}
