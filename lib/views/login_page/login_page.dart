import 'package:flutter/material.dart';

import '../../util/ui_constants.dart';
import 'widgets/AppName.dart';
import 'widgets/ForgotPassword.dart';
import 'widgets/LoginButton.dart';
import 'widgets/MailInput.dart';
import 'widgets/PasswordInput.dart';
import 'widgets/SignUpText.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool? rememberMe = false;

  Widget spacerHeight() => SizedBox(
        height: UIConstants.getColumnSpacing(context),
      );
  Widget spacerWidth() => SizedBox(
        width: UIConstants.getRowSpacing(context),
      );

  Widget body() {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Container(
          color: Theme.of(context).backgroundColor,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: UIConstants.getPaddingHorizontal(context),
                vertical: UIConstants.getPaddingVertical(context)),
            child: Column(
              children: <Widget>[
                spacerHeight(),
                spacerHeight(),
                AppName(),
                spacerHeight(),
                spacerHeight(),
                spacerHeight(),
                MailInput(),
                spacerHeight(),
                PasswordInput(),
                Container(
                  width: UIConstants.getWidth(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      /*RememberMe(
                        value: rememberMe,
                        onChanged: (value) {
                          setState(() {
                            rememberMe = value;
                          });
                        },
                      ),*/
                      ForgotPassword()
                    ],
                  ),
                ),
                spacerHeight(),
                LoginButton(
                  onTap: () {
                    Navigator.pushNamed(context, "/home");
                  },
                ),
                SignUpText(
                  onTap: () {
                    Navigator.pushNamed(context, "/signup");
                  },
                ),
              ],
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: body(),
    );
  }
}
