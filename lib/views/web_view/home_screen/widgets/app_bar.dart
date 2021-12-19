import 'package:flutter/material.dart';

import 'app_bar_menu_item.dart';

class LeftAppBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  const LeftAppBar({Key? key, required this.currentIndex, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> titleList = ["Home", "Pinned", "Explore", "Subscription", "Edit Profile"];
    final List<Icon> iconList = [Icon(Icons.home_outlined, color: Color.fromRGBO(94, 119, 3, 1)),
                                 Icon(Icons.pin_drop_outlined, color: Color.fromRGBO(94, 119, 3, 1)),
                                 Icon(Icons.explore_outlined, color: Color.fromRGBO(94, 119, 3, 1)),
                                 Icon(Icons.save_outlined, color: Color.fromRGBO(94, 119, 3, 1)),
                                 Icon(Icons.settings_outlined, color: Color.fromRGBO(94, 119, 3, 1))
                                 ];
    final List<Icon> boldIconList = [Icon(Icons.home, color: Color.fromRGBO(94, 119, 3, 1)),
                                     Icon(Icons.pin_drop, color: Color.fromRGBO(94, 119, 3, 1)),
                                     Icon(Icons.explore, color: Color.fromRGBO(94, 119, 3, 1)),
                                     Icon(Icons.save, color: Color.fromRGBO(94, 119, 3, 1)),
                                     Icon(Icons.settings, color: Color.fromRGBO(94, 119, 3, 1))
                                     ];
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
