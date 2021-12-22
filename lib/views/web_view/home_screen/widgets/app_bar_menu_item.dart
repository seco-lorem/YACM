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
    return Material(
      type: MaterialType.transparency,
      child: ListTile(
        selected: selected,
        selectedTileColor: Colors.black.withOpacity(.2),
        hoverColor: Colors.black.withOpacity(.1),
        onTap: ontap,
        title: Text(title,
            style: TextStyle(
                color: Colors.grey[700],
                fontWeight: selected ? FontWeight.bold : FontWeight.normal)),
        trailing: selected ? boldIcon : icon,
      ),
    );
  }
}
