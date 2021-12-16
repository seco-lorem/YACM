import 'package:flutter/material.dart';

import 'app_bar_menu_item.dart';

class LeftAppBar extends StatelessWidget {
  const LeftAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        height: MediaQuery.of(context).size.height - 150,
        padding: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
            color: Color.fromRGBO(244, 226, 198, 1),
            borderRadius: BorderRadius.circular(0),
            ),
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            const CircleAvatar(
              backgroundColor: Color.fromRGBO(94, 119, 3, 1),
              radius: 50,
              backgroundImage: AssetImage('assets/emptyUser.png'),
            ),
            MenuItem(
                title: "Home",
                ontap: () {},
                icon: Icon(Icons.home_outlined, color: Color.fromRGBO(94, 119, 3, 1)),
                boldIcon: Icon(Icons.home, color: Color.fromRGBO(94, 119, 3, 1)),
                selected: true),
            MenuItem(
                title: "Pinned",
                ontap: () {},
                icon: Icon(Icons.pin_drop_outlined, color: Color.fromRGBO(94, 119, 3, 1)),
                boldIcon: Icon(Icons.pin_drop, color: Color.fromRGBO(94, 119, 3, 1)),
                selected: false),
            MenuItem(
                title: "Explore",
                ontap: () {},
                icon: Icon(Icons.explore_outlined, color: Color.fromRGBO(94, 119, 3, 1)),
                boldIcon: Icon(Icons.explore, color: Color.fromRGBO(94, 119, 3, 1)),
                selected: false),
            MenuItem(
                title: "Subscription",
                ontap: () {},
                icon: Icon(Icons.save_outlined, color: Color.fromRGBO(94, 119, 3, 1)),
                boldIcon: Icon(Icons.save, color: Color.fromRGBO(94, 119, 3, 1)),
                selected: false),
            MenuItem(
                title: "Edit Profile",
                ontap: () {},
                icon: Icon(Icons.settings_outlined, color: Color.fromRGBO(94, 119, 3, 1)),
                boldIcon: Icon(Icons.settings, color: Color.fromRGBO(94, 119, 3, 1)),
                selected: false),
          ]),
        ));
  }
}
