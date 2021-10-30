import 'package:flutter/material.dart';

class BottomTabBarItem extends StatelessWidget {
  final bool bold;
  final double size;
  final IconData icon;
  final IconData boldIcon;
  final VoidCallback? onTap;
  final Color? color;

  const BottomTabBarItem(this.icon, this.boldIcon, this.color, this.bold,
      {Key? key, this.onTap, this.size = 18})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        bold ? boldIcon : icon,
        size: size,
        color: color,
      ),
    );
  }
}
