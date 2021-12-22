import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yacm/models/theme/own_theme_fields.dart';

class MobileBottomBar extends StatelessWidget {
  final Function(int) onTap;
  final int currentPage;
  const MobileBottomBar(
      {Key? key, required this.onTap, required this.currentPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _bottomItem(
        {required IconData icon,
        required IconData boldIcon,
        required int index}) {
      return InkWell(
          onTap: () => onTap(index),
          child: Icon(
            index == currentPage ? boldIcon : icon,
            color: Theme.of(context).own().appBarText,
          ));
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom + 8, left: 8, right: 8),
      color: Theme.of(context).own().appBar,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _bottomItem(
              icon: Icons.home_outlined, boldIcon: Icons.home_filled, index: 0),
          _bottomItem(
              icon: Icons.explore_outlined, boldIcon: Icons.explore, index: 1),
          _bottomItem(
              icon: CupertinoIcons.qrcode_viewfinder,
              boldIcon: CupertinoIcons.qrcode,
              index: 2),
          _bottomItem(
              icon: Icons.notifications_outlined,
              boldIcon: Icons.notifications,
              index: 3),
          _bottomItem(
              icon: CupertinoIcons.person,
              boldIcon: CupertinoIcons.person_fill,
              index: 4)
        ],
      ),
    );
  }
}
