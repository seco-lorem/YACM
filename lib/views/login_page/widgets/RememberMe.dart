import 'package:flutter/material.dart';

import '../../../models/language/language.dart';
import '../../../models/theme/own_theme_fields.dart';
import '../../../util/ui_constants.dart';

class RememberMe extends StatelessWidget {
  final Function(bool?)? onChanged;
  final bool? value;
  const RememberMe({Key? key, this.onChanged, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Language? language = Language.of(context);

    return Container(
      padding:
          EdgeInsets.only(left: UIConstants.getPaddingHorizontal(context) * 0),
      height: UIConstants.getHeight(context, height: 30, multiplier: .06),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Theme(
            data: Theme.of(context).copyWith(
                unselectedWidgetColor:
                    Theme.of(context).own().loginCheckBoxActiveColor),
            child: Transform.scale(
              scale:
                  UIConstants.getHeight(context, height: 1, multiplier: .002),
              child: Checkbox(
                shape: CircleBorder(),
                value: value,
                onChanged: onChanged,
                activeColor: Theme.of(context).own().loginCheckBoxActiveColor,
                checkColor: Colors.white,
              ),
            ),
          ),
          Text(
            language!.loginPageRememberMe,
            style: TextStyle(
                color: Theme.of(context).own().loginDontHaveAccount,
                fontSize: UIConstants.getHeight(context,
                    height: 18, multiplier: .025)),
          )
        ],
      ),
    );
  }
}
