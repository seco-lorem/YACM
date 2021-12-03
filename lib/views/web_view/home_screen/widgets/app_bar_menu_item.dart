import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final Icon icon;
  final Icon boldIcon;
  final bool selected;
  final VoidCallback ontap;
  const MenuItem(
      {Key? key,
      required this.title,
      required this.icon,
      required this.boldIcon,
      required this.selected,
      required this.ontap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: ontap,
      title: Text(title,
          style: TextStyle(
              fontWeight: selected ? FontWeight.bold : FontWeight.normal)),
      trailing: selected ? boldIcon : icon,
    );
  }
}
