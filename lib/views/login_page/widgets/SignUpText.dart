import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../models/language/language.dart';
import '../../../models/theme/own_theme_fields.dart';
import '../../../util/ui_constants.dart';

class SignUpText extends StatelessWidget {
  final VoidCallback? onTap;
  const SignUpText({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Language? language = Language.of(context);

    return Container(
      height: UIConstants.getHeight(context, height: 30),
      width: UIConstants.getWidth(context),
      child: Center(
        child: RichText(
            text: TextSpan(children: [
          TextSpan(
              text: language!.loginPageDontHaveAccount,
              style: TextStyle(
                color: Theme.of(context).own().loginDontHaveAccount,
                fontSize: UIConstants.getHeight(context, height: 15),
              )),
          TextSpan(
              text: language.loginPageSignUp,
              style: TextStyle(
                  color: Theme.of(context).own().loginSignUp,
                  fontSize: UIConstants.getHeight(context, height: 15),
                  fontWeight: FontWeight.bold),
              recognizer: TapGestureRecognizer()..onTap = onTap)
        ])),
      ),
    );
  }
}
