import 'package:flutter/material.dart';

class SelectableIcon extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const SelectableIcon({
    Key? key,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.blue.withOpacity(0.5) : Colors.grey.withOpacity(0.3),
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.blue : Colors.black,
          size: 30,
        ),
      ),
    );
  }
}
