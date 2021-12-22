import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yacm/models/language/language.dart';
import 'package:yacm/models/theme/own_theme_fields.dart';
import 'package:yacm/util/ui_constants.dart';

class SignUp extends StatefulWidget {
  final Language language;
  final VoidCallback onClose;
  const SignUp({Key? key, required this.language, required this.onClose})
      : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final List<String> _interests = [];
  final List<bool> _chosen = [];
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final PageController _pageController = PageController();

  @override
  dispose() {
    _mailController.dispose();
    _passwordController.dispose();
    _passwordController2.dispose();
    _nameController.dispose();
    _idController.dispose();
    _pageController.dispose();
    super.dispose();
  }

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
                    offset:
                        controller.text.split("@ug.bilkent.edu.tr")[0].length),
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
              labelStyle:
                  TextStyle(color: Theme.of(context).own().popUpTextInputColor),
              floatingLabelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).own().inputFieldBorder),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(UIConstants.borderRadius),
                  borderSide: BorderSide(
                      width: 3,
                      color: Theme.of(context).own().inputFieldBorder)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(UIConstants.borderRadius),
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
              borderRadius: BorderRadius.circular(UIConstants.borderRadius)))),
      onPressed: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          widget.language.loginPageLogin,
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
            overlayColor:
                MaterialStateProperty.all<Color>(Colors.black.withOpacity(.1))),
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
              borderRadius: BorderRadius.circular(UIConstants.borderRadius)))),
      onPressed: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          widget.language.signUpFinish,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).own().popUpLogin),
        ),
      ));

  Widget _getInterests() => SizedBox(
        height: 330,
        width: UIConstants.getWidth(context),
        child: ListView.builder(
          itemCount: _interests.length,
          itemBuilder: (context, index) {
            return Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _interests[index],
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
                                Theme.of(context).own().popUpInterestsRadio))),
                    child: Radio(
                        value: 1,
                        groupValue: _chosen[index],
                        onChanged: (value) {
                          setState(() {
                            _chosen[index] = !_chosen[index];
                          });
                        }))
              ],
            );
          },
        ),
      );

  Widget _pages() => SizedBox(
        width: UIConstants.getWidth(context),
        height: UIConstants.getHeight(context, height: 400, multiplier: 0.5),
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          controller: _pageController,
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
                      header: widget.language.loginPageMail,
                      obscureText: false,
                      maxLength: 100,
                      controller: _mailController),
                  const SizedBox(height: 10),
                  _textInputField(
                      header: widget.language.loginPagePassword,
                      obscureText: true,
                      maxLength: 100,
                      controller: _passwordController),
                  const SizedBox(height: 10),
                  _loginButton(() {}),
                  const SizedBox(height: 25),
                  _dividerOr(),
                  const SizedBox(height: 20),
                  _signUp(() {
                    _mailController.clear();
                    _passwordController.clear();
                    _passwordController2.clear();
                    _nameController.clear();
                    _idController.clear();
                    _pageController.nextPage(
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
                                _mailController.clear();
                                _passwordController.clear();
                                _passwordController2.clear();
                                _nameController.clear();
                                _idController.clear();
                                _pageController.previousPage(
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
                      controller: _nameController),
                  const SizedBox(height: 10),
                  _getInterests(),
                  const SizedBox(height: 10),
                  _textInputField(
                      header: widget.language.loginPageMail,
                      obscureText: false,
                      maxLength: 100,
                      controller: _mailController,
                      isMail: true),
                  const SizedBox(height: 10),
                  _textInputField(
                      header: "ID",
                      obscureText: false,
                      maxLength: 8,
                      controller: _idController,
                      onlyNumbers: true),
                  const SizedBox(height: 10),
                  _textInputField(
                      header: widget.language.loginPagePassword,
                      obscureText: true,
                      maxLength: 100,
                      controller: _passwordController),
                  const SizedBox(height: 10),
                  _textInputField(
                      header: widget.language.loginPagePassword,
                      obscureText: true,
                      maxLength: 100,
                      controller: _passwordController2),
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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black.withOpacity(.7),
      padding: EdgeInsets.all(8),
      child: Stack(
        children: [
          Center(
            child: Container(
              width: UIConstants.getPostWidth(context),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).own().background,
                borderRadius: BorderRadius.circular(UIConstants.borderRadius),
              ),
              child: _pages(),
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: IconButton(
                onPressed: widget.onClose,
                icon: Icon(Icons.close, color: Colors.white)),
          )
        ],
      ),
    );
  }
}
