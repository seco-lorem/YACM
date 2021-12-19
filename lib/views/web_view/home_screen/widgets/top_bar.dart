import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yacm/models/theme/own_theme_fields.dart';

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
          child: Text(
                      "YACM",
                      style: GoogleFonts.pacifico(
                          color: Theme.of(context).own().yacmLogoColor,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none),
                    ),
        ),
      ),
      SizedBox(
        width: size.width - 400,
        height: 110,
        child: Center(child: TextField(decoration: const InputDecoration(labelText: 'Search'),onTap: () => {},)),
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
                ["Technology", "Science", "Sports", "Gaming", "Sci-Fi", "Food", "Travel", "Economics", "Law", "Politics"],
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
