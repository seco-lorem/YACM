import 'package:flutter/material.dart';

import '../../../../models/theme/own_theme_fields.dart';
import '../../../../util/ui_constants.dart';
import 'BottomTabBarItem.dart';

class BottomTabBar extends StatelessWidget {
  final List<BottomTabBarItem> items;
  const BottomTabBar(this.items, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      child: Container(
          width: UIConstants.getSafeWidth(context),
          height: UIConstants.getHeight(context, height: 30, multiplier: .05),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(width: 0, color: Colors.black38),
            ),
            color: Theme.of(context).own().homePageBottomBarColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: items,
          )),
    );
  }
}
