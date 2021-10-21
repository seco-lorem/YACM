import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../models/language/language.dart';
import '../../../models/theme/own_theme_fields.dart';
import '../../../util/ui_constants.dart';

class PasswordInput extends StatelessWidget {
  final TextEditingController? textEditingController;
  const PasswordInput({Key? key, this.textEditingController}) : super(key: key);

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
                    language!.loginPagePassword,
                    style: TextStyle(
                      color: Theme.of(context).own().loginPasswordInputBorder,
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
                color: Theme.of(context).own().loginPasswordBackground,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                    color: Theme.of(context).own().loginPasswordInputBorder ??
                        Colors.white.withOpacity(0))),
            child: TextField(
              cursorColor: Theme.of(context).own().loginPasswordText,
              controller: textEditingController,
              textAlignVertical: TextAlignVertical.bottom,
              style: TextStyle(
                color: Theme.of(context).own().loginPasswordText,
                fontWeight: FontWeight.w400,
                fontSize: UIConstants.getHeight(context),
                decoration: TextDecoration.none,
              ),
              decoration: InputDecoration(border: InputBorder.none),
              keyboardType: TextInputType.text,
              maxLines: 1,
              obscureText: true,
              autocorrect: false,
            ),
          )
        ],
      ),
    );
  }
}
