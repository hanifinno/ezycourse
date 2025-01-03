import 'package:flutter/material.dart';

class UserCallIconButton extends StatelessWidget {
  const UserCallIconButton({
    super.key,
    required this.onPressed,
    required this.iconData,
    this.backgroundColor,
    this.size = 32,
    this.borderWidth = 0,
  });
  final void Function()? onPressed;
  final IconData iconData;
  final Color? backgroundColor;
  final double size;
  final double borderWidth;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size + borderWidth,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: size,
        backgroundColor: backgroundColor,
        child: IconButton(
            onPressed: onPressed,
            color: Colors.white,
            icon: Icon(
              size: size,
              iconData,
            )),
      ),
    );
  }
}
