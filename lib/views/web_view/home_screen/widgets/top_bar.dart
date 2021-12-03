import 'package:flutter/material.dart';

import '../../../../models/language/language.dart';
import '../../../../util/helper.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      SizedBox(
        width: 200,
        height: 110,
        child: Center(
          child: Text("Yacm".toUpperCase(),
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Color.fromRGBO(94, 119, 3, 1))),
        ),
      ),
      SizedBox(
        width: size.width - 400,
        height: 110,
        child: Center(child: TextField(decoration: const InputDecoration(labelText: 'Search'),)),
      ),
      SizedBox(
        width: 100,
        height: 110,
        child: Center(
            child: TextButton(
          child: Text(
            'Notifications',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
          onPressed: () {
            Helper.showLoginPopUp(
                context,
                Language.of(context)!,
                TextEditingController(),
                TextEditingController(),
                TextEditingController(),
                PageController(),
                TextEditingController(),
                TextEditingController(),
                () {},
                () {},
                (p0) => null,
                ["1", "2", "3", "1", "2", "3", "1", "2", "3", "1"],
                [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
          },
        )),
      ),
      SizedBox(
        width: 100,
        height: 110,
        child: Center(
            child: TextButton(
          child: Text(
            'Log Out',
            style: TextStyle(
                color: Colors.grey[600], fontSize: 14, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Helper.showChangeThemePopUp(
                context: context,
                themes: ["Light", "Dark"],
                onContinue: () => Navigator.pop(context),
                language: Language.of(context)!);
          },
        )),
      )
    ]);
  }
}
