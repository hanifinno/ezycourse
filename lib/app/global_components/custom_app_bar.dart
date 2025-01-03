import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final IconData leadingIcon;
  final VoidCallback onLeadingIconPressed;
  final List<Widget> actions;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.leadingIcon,
    required this.onLeadingIconPressed,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80.0), // Custom height of AppBar
      child: AppBar(
        backgroundColor: Colors.blueAccent, // Set your custom color here
        elevation: 5.0, // Optional: adds shadow
        leading: IconButton(
          icon: Icon(leadingIcon),
          onPressed: onLeadingIconPressed,
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: actions, // Custom actions (icons/buttons) on the right side
      ),
    );
  }
}
