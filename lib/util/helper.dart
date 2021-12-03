import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/language/language.dart';
import '../models/theme/own_theme_fields.dart';
import 'ui_constants.dart';

class Helper {
  static Future<Widget> showLoginPopUp(
      BuildContext context,
      Language language,
      TextEditingController mailController,
      TextEditingController passwordController,
      TextEditingController passwordController2,
      PageController pageController,
      TextEditingController nameController,
      TextEditingController idController,
      VoidCallback onSignUp,
      VoidCallback onLogin,
      Function(int?) onInterestChoose,
      List<String> interests,
      List<int> chosen) async {
    List<int> _chosen = chosen;
    Widget _textInputField(
            {required String header,
            required bool obscureText,
            required int maxLength,
            required TextEditingController controller,
            bool onlyNumbers = false,
            bool isMail = false}) =>
        TextField(
            onChanged: (data) {
              if (isMail) {
                controller.text =
                    data.split("@ug.bilkent.edu.tr")[0] + "@ug.bilkent.edu.tr";
                controller.selection = TextSelection.fromPosition(
                  TextPosition(
                      offset: controller.text
                          .split("@ug.bilkent.edu.tr")[0]
                          .length),
                );
              }
            },
            inputFormatters: onlyNumbers
                ? [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ]
                : [],
            controller: controller,
            obscureText: obscureText,
            maxLength: maxLength,
            keyboardType: onlyNumbers ? TextInputType.number : null,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            cursorColor: Theme.of(context).own().popUpTextInputColor,
            style: TextStyle(
              decoration: TextDecoration.none,
              color: Theme.of(context).own().popUpTextInputColor,
              fontSize: 18,
            ),
            decoration: InputDecoration(
                counterText: "",
                labelText: header,
                labelStyle: TextStyle(
                    color: Theme.of(context).own().popUpTextInputColor),
                floatingLabelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).own().inputFieldBorder),
                focusedBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(UIConstants.borderRadius),
                    borderSide: BorderSide(
                        width: 3,
                        color: Theme.of(context).own().inputFieldBorder)),
                border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(UIConstants.borderRadius),
                    borderSide: BorderSide(
                        width: 3,
                        color: Theme.of(context).own().inputFieldBorder))));

    Widget _loginButton(VoidCallback onTap) => TextButton(
        style: ButtonStyle(
            fixedSize: MaterialStateProperty.all<Size>(
                Size.fromWidth(UIConstants.getWidth(context))),
            backgroundColor: MaterialStateProperty.all<Color>(
                Theme.of(context).own().popUpLoginBackground),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(UIConstants.borderRadius)))),
        onPressed: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            language.loginPageLogin,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).own().popUpLogin),
          ),
        ));

    Widget _dividerOr() => Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Divider(
                color: Colors.grey[600],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "or",
                style: TextStyle(color: Colors.grey[700]),
              ),
            ),
            Expanded(
              child: Divider(
                color: Colors.grey[600],
              ),
            )
          ],
        );

    Widget _signUp(VoidCallback onTap) => TextButton(
          onPressed: onTap,
          style: ButtonStyle(
              overlayColor: MaterialStateProperty.all<Color>(
                  Colors.black.withOpacity(.1))),
          child: Text(
            "Sign Up",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Theme.of(context).own().popUpSignUp),
          ),
        );

    Widget _finish(VoidCallback onTap) => TextButton(
        style: ButtonStyle(
            fixedSize: MaterialStateProperty.all<Size>(
                Size.fromWidth(UIConstants.getWidth(context))),
            backgroundColor: MaterialStateProperty.all<Color>(
                Theme.of(context).own().popUpLoginBackground),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(UIConstants.borderRadius)))),
        onPressed: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            language.signUpFinish,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).own().popUpLogin),
          ),
        ));

    Widget _interests(List<String> interests, List<int> chosen,
            Function(int?) onChanged) =>
        StatefulBuilder(builder: (context, setState) {
          print(_chosen);
          return SizedBox(
            height: 330,
            width: UIConstants.getWidth(context),
            child: ListView.builder(
              itemCount: interests.length,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      interests[index],
                      style: TextStyle(
                        color: Theme.of(context).own().popUpInterestsText,
                      ),
                    ),
                    Theme(
                        data: Theme.of(context).copyWith(
                            unselectedWidgetColor:
                                Theme.of(context).own().popUpInterestsRadio,
                            radioTheme: RadioThemeData(
                                fillColor: MaterialStateProperty.all<Color>(
                                    Theme.of(context)
                                        .own()
                                        .popUpInterestsRadio))),
                        child: Radio(
                            value: 1,
                            groupValue: _chosen[index],
                            onChanged: (value) {
                              setState(() {
                                if (_chosen[index] == 0) {
                                  print("x");
                                  _chosen[index] = 1;
                                } else {
                                  print("y");
                                  _chosen[index] = 0;
                                }
                              });
                            }))
                  ],
                );
              },
            ),
          );
        });

    Widget _pages(PageController controller) => SizedBox(
          width: UIConstants.getWidth(context),
          height: UIConstants.getHeight(context, height: 400, multiplier: 0.5),
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            controller: controller,
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "YACM",
                      style: GoogleFonts.pacifico(
                          color: Theme.of(context).own().yacmLogoColor,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none),
                    ),
                    const SizedBox(height: 20),
                    _textInputField(
                        header: language.loginPageMail,
                        obscureText: false,
                        maxLength: 100,
                        controller: mailController),
                    const SizedBox(height: 10),
                    _textInputField(
                        header: language.loginPagePassword,
                        obscureText: true,
                        maxLength: 100,
                        controller: passwordController),
                    const SizedBox(height: 10),
                    _loginButton(() {}),
                    const SizedBox(height: 25),
                    _dividerOr(),
                    const SizedBox(height: 20),
                    _signUp(() {
                      mailController.clear();
                      passwordController.clear();
                      passwordController2.clear();
                      nameController.clear();
                      idController.clear();
                      pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn);
                    }),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: UIConstants.getWidth(context),
                      child: Stack(
                        children: [
                          Center(
                            child: Text(
                              "YACM",
                              style: GoogleFonts.pacifico(
                                  color: Theme.of(context).own().yacmLogoColor,
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none),
                            ),
                          ),
                          Positioned(
                              top: 10,
                              right: 10,
                              child: IconButton(
                                color: Theme.of(context).own().popUpClose,
                                highlightColor: Theme.of(context)
                                    .own()
                                    .popUpClose
                                    .withOpacity(.5),
                                hoverColor: Colors.black,
                                splashColor: Colors.black,
                                onPressed: () {
                                  mailController.clear();
                                  passwordController.clear();
                                  passwordController2.clear();
                                  nameController.clear();
                                  idController.clear();
                                  pageController.previousPage(
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.easeIn);
                                },
                                icon: Icon(
                                  Icons.close,
                                ),
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    _textInputField(
                        header: "Name",
                        obscureText: false,
                        maxLength: 100,
                        controller: nameController),
                    const SizedBox(height: 10),
                    _interests(
                      interests,
                      chosen,
                      onInterestChoose,
                    ),
                    const SizedBox(height: 10),
                    _textInputField(
                        header: language.loginPageMail,
                        obscureText: false,
                        maxLength: 100,
                        controller: mailController,
                        isMail: true),
                    const SizedBox(height: 10),
                    _textInputField(
                        header: "ID",
                        obscureText: false,
                        maxLength: 8,
                        controller: idController,
                        onlyNumbers: true),
                    const SizedBox(height: 10),
                    _textInputField(
                        header: language.loginPagePassword,
                        obscureText: true,
                        maxLength: 100,
                        controller: passwordController),
                    const SizedBox(height: 10),
                    _textInputField(
                        header: language.loginPagePassword,
                        obscureText: true,
                        maxLength: 100,
                        controller: passwordController2),
                    const SizedBox(height: 20),
                    _finish(() {
                      Navigator.pop(context);
                    })
                  ],
                ),
              ),
            ],
          ),
        );

    Widget result = await showDialog(
        useSafeArea: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return Dialog(
              backgroundColor: Theme.of(context).own().popUpBackground,
              elevation: 12,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(UIConstants.borderRadius)),
              insetPadding: EdgeInsets.symmetric(
                horizontal: (MediaQuery.of(context).size.width -
                                UIConstants.getWidth(context)) /
                            2 <
                        0
                    ? 0
                    : (MediaQuery.of(context).size.width -
                            UIConstants.getWidth(context)) /
                        2,
                vertical: (MediaQuery.of(context).size.height -
                                UIConstants.getHeight(context,
                                    height: 400, multiplier: 0.5)) /
                            2 <
                        0
                    ? 0
                    : (MediaQuery.of(context).size.height -
                            UIConstants.getHeight(context,
                                height: 400, multiplier: 0.5)) /
                        2,
              ),
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: UIConstants.getPaddingHorizontal(context),
                      vertical: UIConstants.getPaddingVertical(context)),
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(UIConstants.borderRadius),
                      color: Theme.of(context).own().popUpBackground),
                  width: UIConstants.getWidth(context),
                  height: UIConstants.getHeight(context,
                      height: 400, multiplier: 0.5),
                  child: _pages(
                    pageController,
                  ),
                ),
              ),
            );
          });
        });

    return result;
  }

  static Future<Widget> showGetLanguagePopUp(
      {required BuildContext context,
      required List<String> languages,
      required VoidCallback onContinue,
      required Language language}) async {
    Widget _continueButton(VoidCallback onTap) => TextButton(
        style: ButtonStyle(
            fixedSize: MaterialStateProperty.all<Size>(
                Size.fromWidth(UIConstants.getWidth(context))),
            backgroundColor: MaterialStateProperty.all<Color>(
                Theme.of(context).own().popUpLoginBackground),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(UIConstants.borderRadius)))),
        onPressed: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            language.signUpFinish,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).own().popUpLogin),
          ),
        ));

    Widget _languages(List<String> languages, List<int> chosen) => SizedBox(
          height: 75,
          width: UIConstants.getWidth(context),
          child: ListView.builder(
            itemCount: languages.length,
            itemBuilder: (context, index) {
              return Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    languages[index],
                    style: TextStyle(
                      color: Theme.of(context).own().popUpInterestsText,
                    ),
                  ),
                  Theme(
                      data: Theme.of(context).copyWith(
                          unselectedWidgetColor:
                              Theme.of(context).own().popUpInterestsRadio,
                          radioTheme: RadioThemeData(
                              fillColor: MaterialStateProperty.all<Color>(
                                  Theme.of(context)
                                      .own()
                                      .popUpInterestsRadio))),
                      child: Radio(
                          value: 1, groupValue: chosen[index], onChanged: null))
                ],
              );
            },
          ),
        );

    Widget result = await showDialog(
        barrierDismissible: false,
        useSafeArea: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return Dialog(
              backgroundColor: Theme.of(context).own().popUpBackground,
              elevation: 12,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(UIConstants.borderRadius)),
              insetPadding: EdgeInsets.symmetric(
                horizontal: (MediaQuery.of(context).size.width -
                                UIConstants.getWidth(context)) /
                            2 <
                        0
                    ? 0
                    : (MediaQuery.of(context).size.width -
                            UIConstants.getWidth(context)) /
                        2,
                vertical: (MediaQuery.of(context).size.height -
                                UIConstants.getHeight(context,
                                    height: 200, multiplier: 0.3)) /
                            2 <
                        0
                    ? 0
                    : (MediaQuery.of(context).size.height -
                            UIConstants.getHeight(context,
                                height: 200, multiplier: 0.3)) /
                        2,
              ),
              child: Center(
                child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: UIConstants.getPaddingHorizontal(context),
                        vertical: UIConstants.getPaddingVertical(context)),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(UIConstants.borderRadius),
                        color: Theme.of(context).own().popUpBackground),
                    width: UIConstants.getWidth(context),
                    height: UIConstants.getHeight(context,
                        height: 200, multiplier: 0.3),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Please Choose Your Language Preference",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).own().popUpHeaderText)),
                          const SizedBox(height: 20),
                          _languages(languages, [1, 0]),
                          const SizedBox(height: 10),
                          _continueButton(onContinue)
                        ],
                      ),
                    )),
              ),
            );
          });
        });

    return result;
  }

  static Future<Widget> showChangeThemePopUp(
      {required BuildContext context,
      required Language language,
      required VoidCallback onContinue,
      required List<String> themes}) async {
    Widget _continueButton(VoidCallback onTap) => TextButton(
        style: ButtonStyle(
            fixedSize: MaterialStateProperty.all<Size>(
                Size.fromWidth(UIConstants.getWidth(context))),
            backgroundColor: MaterialStateProperty.all<Color>(
                Theme.of(context).own().popUpLoginBackground),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(UIConstants.borderRadius)))),
        onPressed: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            language.signUpFinish,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).own().popUpLogin),
          ),
        ));

    Widget _languages(List<String> themes, List<int> chosen) => SizedBox(
          height: 75,
          width: UIConstants.getWidth(context),
          child: ListView.builder(
            itemCount: themes.length,
            itemBuilder: (context, index) {
              return Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    themes[index],
                    style: TextStyle(
                      color: Theme.of(context).own().popUpInterestsText,
                    ),
                  ),
                  Theme(
                      data: Theme.of(context).copyWith(
                          unselectedWidgetColor:
                              Theme.of(context).own().popUpInterestsRadio,
                          radioTheme: RadioThemeData(
                              fillColor: MaterialStateProperty.all<Color>(
                                  Theme.of(context)
                                      .own()
                                      .popUpInterestsRadio))),
                      child: Radio(
                          value: 1, groupValue: chosen[index], onChanged: null))
                ],
              );
            },
          ),
        );

    Widget result = await showDialog(
        useSafeArea: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return Dialog(
              backgroundColor: Theme.of(context).own().popUpBackground,
              elevation: 12,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(UIConstants.borderRadius)),
              insetPadding: EdgeInsets.symmetric(
                horizontal: (MediaQuery.of(context).size.width -
                                UIConstants.getWidth(context)) /
                            2 <
                        0
                    ? 0
                    : (MediaQuery.of(context).size.width -
                            UIConstants.getWidth(context)) /
                        2,
                vertical: (MediaQuery.of(context).size.height -
                                UIConstants.getHeight(context,
                                    height: 200, multiplier: 0.3)) /
                            2 <
                        0
                    ? 0
                    : (MediaQuery.of(context).size.height -
                            UIConstants.getHeight(context,
                                height: 200, multiplier: 0.3)) /
                        2,
              ),
              child: Center(
                child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: UIConstants.getPaddingHorizontal(context),
                        vertical: UIConstants.getPaddingVertical(context)),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(UIConstants.borderRadius),
                        color: Theme.of(context).own().popUpBackground),
                    width: UIConstants.getWidth(context),
                    height: UIConstants.getHeight(context,
                        height: 200, multiplier: 0.3),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Please Choose Your Theme Preference",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).own().popUpHeaderText)),
                          const SizedBox(height: 20),
                          _languages(themes, [1, 0]),
                          const SizedBox(height: 10),
                          _continueButton(onContinue)
                        ],
                      ),
                    )),
              ),
            );
          });
        });

    return result;
  }
}
