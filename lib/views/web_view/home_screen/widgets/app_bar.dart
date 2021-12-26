import 'package:flutter/material.dart';
import 'package:yacm/models/language/language.dart';

import 'app_bar_menu_item.dart';

class LeftAppBar extends StatelessWidget {
  const LeftAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Language? _language = Language.of(context);
    return Container(
        width: 200,
        height: MediaQuery.of(context).size.height - 150,
        padding: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
            color: Color.fromRGBO(244, 226, 198, 1),
            borderRadius: BorderRadius.circular(0),
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
  }
}
