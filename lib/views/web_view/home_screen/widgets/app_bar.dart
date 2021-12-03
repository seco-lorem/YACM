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
            color: Colors.lightGreen,
            borderRadius: BorderRadius.circular(0),
            boxShadow: [
              BoxShadow(
                  offset: Offset(-2, 0),
                  blurRadius: 30,
                  color: Colors.black.withOpacity(0.16))
            ]),
        child: Column(children: <Widget>[
          const CircleAvatar(
            backgroundImage: AssetImage('assets/emptyUser.png'),
          ),
          const Spacer(),
          MenuItem(
              title: "Home",
              ontap: () {},
              icon: Icons.home_outlined,
              boldIcon: Icons.home,
              selected: true),
          MenuItem(
              title: "Pinned",
              ontap: () {},
              icon: Icons.pin_drop_outlined,
              boldIcon: Icons.pin_drop,
              selected: false),
          MenuItem(
              title: "Explore",
              ontap: () {},
              icon: Icons.home_outlined,
              boldIcon: Icons.home,
              selected: false),
          MenuItem(
              title: "Subscription",
              ontap: () {},
              icon: Icons.save_outlined,
              boldIcon: Icons.save,
              selected: false),
          MenuItem(
              title: "Edit Profile",
              ontap: () {},
              icon: Icons.home_outlined,
              boldIcon: Icons.home,
              selected: false),
          const Spacer()
        ]));
  }
}
