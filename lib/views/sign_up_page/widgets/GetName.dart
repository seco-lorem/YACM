import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../models/language/language.dart';
import '../../../models/theme/own_theme_fields.dart';
import '../../../util/ui_constants.dart';

class GetName extends StatelessWidget {
  final TextEditingController? textEditingController;
  const GetName({Key? key, this.textEditingController}) : super(key: key);

  Widget getNameBox(
      BuildContext context, Language? language, bool isWide, bool isShort) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: UIConstants.getPaddingHorizontal(context) * .5,
              right: UIConstants.getPaddingHorizontal(context) * .5,
            ),
            height: UIConstants.getHeight(context, height: 30, multiplier: .07),
            width: UIConstants.getWidth(context),
            decoration: BoxDecoration(
                color: Theme.of(context).own().signUpGetNameBackground,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                    color: Theme.of(context).own().signUpGetNameBorder ??
                        Colors.white.withOpacity(0))),
            child: TextField(
              textAlignVertical: TextAlignVertical.bottom,
              cursorColor: Theme.of(context).own().signUpGetNameText,
              controller: textEditingController,
              style: TextStyle(
                color: Theme.of(context).own().signUpGetNameText,
                fontWeight: FontWeight.w400,
                fontSize: UIConstants.getHeight(context, height: 15),
                decoration: TextDecoration.none,
              ),
              decoration: InputDecoration(border: InputBorder.none),
              keyboardType: TextInputType.text,
              maxLines: 1,
              autocorrect: false,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Language? language = Language.of(context);
    bool isShort = UIConstants.platformIsShort(context);
    bool isWide = UIConstants.platformIsWide(context);

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: UIConstants.getPaddingHorizontal(context) * 2),
      child: Column(
        children: <Widget>[
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: language!.signUpWelcomer,
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Theme.of(context).own().signUpWelcomerText,
                    fontSize: UIConstants.getHeight(context, multiplier: .04)),
              ),
              TextSpan(
                  text: "YACM",
                  style: GoogleFonts.pacifico(
                      color: Theme.of(context).own().signUpWelcomerText,
                      fontSize: UIConstants.getHeight(context, multiplier: .04),
                      fontStyle: FontStyle.italic))
            ]),
          ),
          SizedBox(height: UIConstants.getColumnSpacing(context)),
          SizedBox(
            width: UIConstants.getWidth(context),
            child: Text(
              "Please enter your name and surname to begin",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: UIConstants.getHeight(context),
                color: Theme.of(context).own().signUpGetNameText,
              ),
            ),
          ),
          SizedBox(height: UIConstants.getColumnSpacing(context) * .5),
          getNameBox(context, language, isWide, isShort)
        ],
      ),
    );
  }
}
