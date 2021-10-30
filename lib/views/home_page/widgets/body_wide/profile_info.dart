import 'package:flutter/material.dart';

import '../../../../util/ui_constants.dart';

class UserProfile extends StatelessWidget {
  final String? userName;
  final int? currentActive;
  final Function(int)? onTap;
  const UserProfile({Key? key, this.userName, this.currentActive, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: UIConstants.getWidth(context, width: 250, multiplier: .25),
      padding: EdgeInsets.only(left: 2),
      child: Scrollbar(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: 600,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: CircleAvatar(
                    radius: 48,
                    backgroundColor: Color.fromRGBO(94, 119, 3, 1),
                    child: Image.asset(
                      "assets/emptyUser.png",
                      width: 64,
                      height: 64,
                      color: Colors.white54,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: UIConstants.getWidth(context,
                      width: 250, multiplier: .25),
                  child: Text(
                    userName!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  onTap: () {
                    onTap!(1);
                  },
                  title: Text(
                    "Home",
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(
                    currentActive! == 1 ? Icons.home : Icons.home_outlined,
                    color: Color.fromRGBO(94, 119, 3, 1),
                  ),
                  tileColor:
                      currentActive! == 1 ? Colors.black.withOpacity(.1) : null,
                ),
                ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  onTap: () => onTap!(2),
                  title: Text(
                    "Suggested",
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(
                    currentActive! == 2
                        ? Icons.widgets
                        : Icons.widgets_outlined,
                    color: Color.fromRGBO(94, 119, 3, 1),
                  ),
                  tileColor:
                      currentActive! == 2 ? Colors.black.withOpacity(.1) : null,
                ),
                ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  onTap: () => onTap!(3),
                  title: Text(
                    "Pinned",
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(
                    currentActive! == 3
                        ? Icons.pin_drop
                        : Icons.pin_drop_outlined,
                    color: Color.fromRGBO(94, 119, 3, 1),
                  ),
                  tileColor:
                      currentActive! == 3 ? Colors.black.withOpacity(.1) : null,
                ),
                ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  onTap: () => onTap!(4),
                  title: Text(
                    "Explore",
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(
                    currentActive! == 4
                        ? Icons.explore
                        : Icons.explore_outlined,
                    color: Color.fromRGBO(94, 119, 3, 1),
                  ),
                  tileColor:
                      currentActive! == 4 ? Colors.black.withOpacity(.1) : null,
                ),
                ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  onTap: () => onTap!(5),
                  title: Text(
                    "Subscriptions",
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(
                    currentActive! == 5
                        ? Icons.whatshot
                        : Icons.whatshot_outlined,
                    color: Color.fromRGBO(94, 119, 3, 1),
                  ),
                  tileColor:
                      currentActive! == 5 ? Colors.black.withOpacity(.1) : null,
                ),
                ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  onTap: () => onTap!(6),
                  title: Text(
                    "Edit Profile",
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(
                    currentActive! == 6
                        ? Icons.settings
                        : Icons.settings_outlined,
                    color: Color.fromRGBO(94, 119, 3, 1),
                  ),
                  tileColor:
                      currentActive! == 6 ? Colors.black.withOpacity(.1) : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
