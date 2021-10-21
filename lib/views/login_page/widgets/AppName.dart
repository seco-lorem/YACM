import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/theme/own_theme_fields.dart';
import '../../../util/ui_constants.dart';

class AppName extends StatelessWidget {
  const AppName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: UIConstants.getHeight(context, height: 40, multiplier: .3),
      width: UIConstants.getWidth(context),
      child: Center(
        child: Text("YACM",
            style: GoogleFonts.pacifico(
                fontSize:
                    UIConstants.getHeight(context, height: 30, multiplier: .1),
                fontStyle: FontStyle.italic,
                color: Theme.of(context).own().loginAppNameColor)),
      ),
    );
  }
}
