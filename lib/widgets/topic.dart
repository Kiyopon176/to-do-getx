import 'package:flutter/material.dart';

class TopicView extends StatelessWidget {
  const TopicView({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final Icon icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            Text(label),
          ],
        ),
      ),
    );
  }
}