import 'package:flutter/material.dart';
import '../../../models/language/language.dart';
import '../../../models/theme/own_theme_fields.dart';
import '../../../util/ui_constants.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback? onTap;
  const LoginButton({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Language? language = Language.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: UIConstants.getHeight(context, height: 25, multiplier: .06),
        width: UIConstants.getWidth(
          context,
        ),
        decoration: BoxDecoration(
            color: Theme.of(context).own().loginButtonBackground,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
                color: Theme.of(context).own().loginButtonBorder ??
                    Colors.white.withOpacity(0))),
        child: Center(
          child: Text(language!.loginPageLogin,
              style: TextStyle(
                  color: Theme.of(context).own().loginButtonText,
                  fontWeight: FontWeight.bold,
                  fontSize: UIConstants.getHeight(context))),
        ),
      ),
    );
  }
}
