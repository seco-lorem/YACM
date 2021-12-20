import 'package:flutter/material.dart';
import 'package:yacm/models/theme/own_theme_fields.dart';

import 'app_bar_menu_item.dart';

class LeftAppBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  const LeftAppBar({Key? key, required this.currentIndex, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> titleList = ["Home", "Pinned", "Explore", "Subscription", "Edit Profile"];
    final List<Icon> iconList = [Icon(Icons.home_outlined, color: Theme.of(context).own().yacmLogoColor),
                                 Icon(Icons.pin_drop_outlined, color: Theme.of(context).own().yacmLogoColor),
                                 Icon(Icons.explore_outlined, color: Theme.of(context).own().yacmLogoColor),
                                 Icon(Icons.save_outlined, color: Theme.of(context).own().yacmLogoColor),
                                 Icon(Icons.settings_outlined, color: Theme.of(context).own().yacmLogoColor)
                                 ];
    final List<Icon> boldIconList = [Icon(Icons.home, color: Theme.of(context).own().yacmLogoColor),
                                     Icon(Icons.pin_drop, color: Theme.of(context).own().yacmLogoColor),
                                     Icon(Icons.explore, color: Theme.of(context).own().yacmLogoColor),
                                     Icon(Icons.save, color: Theme.of(context).own().yacmLogoColor),
                                     Icon(Icons.settings, color: Theme.of(context).own().yacmLogoColor)
                                     ];
    return Container(
        width: 200,
        height: MediaQuery.of(context).size.height - 150,
        padding: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
            color: Theme.of(context).own().background,
            borderRadius: BorderRadius.circular(0),
            ),
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            CircleAvatar(
              backgroundColor: Theme.of(context).own().yacmLogoColor,
              radius: 50,
              backgroundImage: AssetImage('assets/emptyUser.png'),
            ),
            SizedBox(
              width: 200,
              height: MediaQuery.of(context).size.height - 150,
              child: ListView.builder(itemCount: 5,itemBuilder: (context, index) {
                return MenuItem(
                  title: titleList[index],
                  icon: iconList[index],
                  boldIcon: boldIconList[index],
                  selected: index == currentIndex,
                  ontap: () => onTap(index),
                );
              },),
            )              
          ]),
        ));
  }
}
