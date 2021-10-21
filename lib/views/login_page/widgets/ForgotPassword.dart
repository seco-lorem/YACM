import 'package:flutter/material.dart';
import '../../../models/language/language.dart';
import '../../../models/theme/own_theme_fields.dart';
import '../../../util/ui_constants.dart';

class ForgotPassword extends StatelessWidget {
  final bool hasPadding;
  const ForgotPassword({Key? key, this.hasPadding = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Language? language = Language.of(context);

    return Container(
        padding: hasPadding
            ? EdgeInsets.only(right: UIConstants.getPaddingHorizontal(context))
            : null,
        height: UIConstants.getHeight(context, height: 30, multiplier: .06),
        child: Row(
          children: <Widget>[
            Text(
              language!.loginPageForgotPassword,
              style: TextStyle(
                color: Theme.of(context).own().loginDontHaveAccount,
                fontSize: UIConstants.getHeight(context,
                    height: 18, multiplier: .025),
              ),
            ),
          ],
        ));
  }
}
