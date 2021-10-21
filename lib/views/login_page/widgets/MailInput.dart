import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../models/language/language.dart';
import '../../../models/theme/own_theme_fields.dart';
import '../../../util/ui_constants.dart';

class MailInput extends StatelessWidget {
  final TextEditingController? textEditingController;
  const MailInput({Key? key, this.textEditingController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Language? language = Language.of(context);
    bool isWide = UIConstants.platformIsWide(context);

    return Container(
      child: Column(
        children: <Widget>[
          Container(
            width: UIConstants.getWidth(
              context,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: isWide
                      ? 0
                      : UIConstants.getPaddingHorizontal(context) * .5),
              child: Row(
                children: [
                  Text(
                    language!.loginPageMail,
                    style: TextStyle(
                      color: Theme.of(context).own().loginMailInputBorder,
                      fontWeight: FontWeight.w400,
                      fontSize: UIConstants.getHeight(context,
                          height: 12, multiplier: .03),
                      decoration: TextDecoration.none,
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: UIConstants.getColumnSpacing(context) * .5,
          ),
          Container(
            padding: EdgeInsets.only(
              left: UIConstants.getPaddingHorizontal(context) * .5,
              right: UIConstants.getPaddingHorizontal(context) * .5,
            ),
            height: UIConstants.getHeight(context, height: 30, multiplier: .06),
            width: UIConstants.getWidth(
              context,
            ),
            decoration: BoxDecoration(
                color: Theme.of(context).own().loginMailBackground,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                    color: Theme.of(context).own().loginMailInputBorder ??
                        Colors.white.withOpacity(0))),
            child: TextField(
              cursorColor: Theme.of(context).own().loginMailText,
              controller: textEditingController,
              textAlignVertical: TextAlignVertical.bottom,
              style: TextStyle(
                color: Theme.of(context).own().loginMailText,
                fontWeight: FontWeight.w400,
                fontSize: UIConstants.getHeight(context),
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
}
