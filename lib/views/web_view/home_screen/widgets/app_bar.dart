import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:yacm/models/language/language.dart';
=======
import 'package:yacm/models/theme/own_theme_fields.dart';
>>>>>>> main

import 'app_bar_menu_item.dart';

class LeftAppBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  const LeftAppBar({Key? key, required this.currentIndex, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    Language? _language = Language.of(context);
=======
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
>>>>>>> main
    return Container(
        width: 200,
        height: MediaQuery.of(context).size.height - 150,
        padding: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
            color: Theme.of(context).own().background,
            borderRadius: BorderRadius.circular(0),
<<<<<<< HEAD
            boxShadow: [
              BoxShadow(
                  offset: Offset(-2, 0),
                  blurRadius: 30,
                  color: Colors.black.withOpacity(0.16))
            ]),
        child: Column(children: <Widget>[
          const CircleAvatar(
            backgroundColor: Color.fromRGBO(94, 119, 3, 1),
            radius: 50,
            backgroundImage: AssetImage('assets/emptyUser.png'),
          ),
          const Spacer(),
          MenuItem(
              title: _language!.home,
              ontap: () {},
              icon: Icon(Icons.home_outlined,
                  color: Color.fromRGBO(94, 119, 3, 1)),
              boldIcon: Icon(Icons.home, color: Color.fromRGBO(94, 119, 3, 1)),
              selected: true),
          MenuItem(
              title: _language.pinned,
              ontap: () {},
              icon: Icon(Icons.pin_drop_outlined,
                  color: Color.fromRGBO(94, 119, 3, 1)),
              boldIcon:
                  Icon(Icons.pin_drop, color: Color.fromRGBO(94, 119, 3, 1)),
              selected: false),
          MenuItem(
              title: _language.explore,
              ontap: () {},
              icon: Icon(Icons.explore_outlined,
                  color: Color.fromRGBO(94, 119, 3, 1)),
              boldIcon:
                  Icon(Icons.explore, color: Color.fromRGBO(94, 119, 3, 1)),
              selected: false),
          MenuItem(
              title: _language.subscription,
              ontap: () {},
              icon: Icon(Icons.save_outlined,
                  color: Color.fromRGBO(94, 119, 3, 1)),
              boldIcon: Icon(Icons.save, color: Color.fromRGBO(94, 119, 3, 1)),
              selected: false),
          MenuItem(
              title: _language.profile,
              ontap: () {},
              icon: Icon(Icons.settings_outlined,
                  color: Color.fromRGBO(94, 119, 3, 1)),
              boldIcon:
                  Icon(Icons.settings, color: Color.fromRGBO(94, 119, 3, 1)),
              selected: false),
          const Spacer()
        ]));
=======
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
>>>>>>> main
  }
}
