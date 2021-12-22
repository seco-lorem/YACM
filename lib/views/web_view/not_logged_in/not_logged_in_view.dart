import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yacm/models/language/language.dart';
import 'package:yacm/models/theme/own_theme_fields.dart';
import 'package:yacm/util/ui_constants.dart';
import 'package:yacm/views/common_widgets/get_language.dart';
import 'package:yacm/views/common_widgets/get_theme.dart';
import 'package:yacm/views/common_widgets/not_logged_in_widgets/sign_up_widget.dart';

class NotLoggedIn extends StatefulWidget {
  const NotLoggedIn({Key? key}) : super(key: key);

  @override
  _NotLoggedInState createState() => _NotLoggedInState();
}

class _NotLoggedInState extends State<NotLoggedIn> {
  bool _mouseHoverOnSignIn = false;
  bool _signUpVisible = false;
  bool _themeChosen = false;
  bool _languageChosen = true;
  Language? _language;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _language = Language.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Theme.of(context).own().background,
          child: Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "YACM",
                          style: GoogleFonts.pacifico(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).own().yacmLogoColor),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _signUpVisible = !_signUpVisible;
                            });
                          },
                          onHover: (value) {
                            setState(() {
                              _mouseHoverOnSignIn = value;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    UIConstants.borderRadius / 2),
                                color: _mouseHoverOnSignIn
                                    ? Theme.of(context).own().yacmLogoColor
                                    : Theme.of(context)
                                        .own()
                                        .yacmLogoColor
                                        .withOpacity(.7)),
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18,
                                  color: Theme.of(context).own().background),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  StreamBuilder(
                    stream: null,
                    builder: (context, stream) {
                      if (stream.connectionState == ConnectionState.active) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [],
                          ),
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  )
                ],
              ),
              Visibility(
                visible: _signUpVisible,
                child: SignUp(
                  language: _language!,
                  onClose: () {
                    setState(() {
                      _signUpVisible = !_signUpVisible;
                    });
                  },
                ),
              ),
              Visibility(
                visible: !_themeChosen,
                child: GetTheme(
                    language: _language!,
                    onClose: () {
                      setState(() {
                        _themeChosen = !_themeChosen;
                        _languageChosen = !_languageChosen;
                      });
                    },
                    onContine: () {
                      setState(() {
                        _themeChosen = !_themeChosen;
                        _languageChosen = !_languageChosen;
                      });
                    }),
              ),
              Visibility(
                visible: !_languageChosen,
                child: GetLanguage(
                    language: _language!,
                    onClose: () {
                      setState(() {
                        _languageChosen = !_languageChosen;
                      });
                    },
                    onContine: () {}),
              )
            ],
          )),
    );
  }
}
