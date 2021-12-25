import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yacm/controllers/theme_controller/theme_changer.dart';
import 'package:yacm/models/language/language.dart';
import 'package:yacm/models/theme/own_theme_fields.dart';
import 'package:yacm/util/ui_constants.dart';

class GetTheme extends StatefulWidget {
  final Language language;
  final VoidCallback onClose;
  final VoidCallback onContine;
  final VoidCallback? onChanged;
  final bool? dark;
  const GetTheme(
      {Key? key,
      required this.language,
      required this.onClose,
      required this.onContine,
      this.onChanged,
      this.dark})
      : super(key: key);

  @override
  _GetThemeState createState() => _GetThemeState();
}

class _GetThemeState extends State<GetTheme> {
  final List<String> _themes = ["Light", "Dark"];
  int _choice = 0;

  @override
  initState() {
    super.initState();
    if (widget.dark != null) {
      if (widget.dark!) {
        _choice = 1;
      } else {
        _choice = 0;
      }
    }
  }

  Widget _continueButton(VoidCallback onTap) => TextButton(
      style: ButtonStyle(
          fixedSize: MaterialStateProperty.all<Size>(
              Size.fromWidth(UIConstants.getWidth(context))),
          backgroundColor: MaterialStateProperty.all<Color>(
              Theme.of(context).own().popUpLoginBackground),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(UIConstants.borderRadius)))),
      onPressed: () {
        onTap();
      },
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

  Widget _themesWidget() => SizedBox(
        height: 75,
        width: UIConstants.getWidth(context),
        child: ListView.builder(
          itemCount: _themes.length,
          itemBuilder: (context, int index) {
            return Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _themes[index],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
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
                        value: index,
                        groupValue: _choice,
                        onChanged: (value) {
                          Provider.of<ThemeChanger>(context, listen: false)
                              .setTheme(value == 1);
                          widget.onChanged!();
                          setState(() {
                            _choice = index;
                          });
                        }))
              ],
            );
          },
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Please Choose Your Theme Preference",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).own().popUpHeaderText)),
                    const SizedBox(height: 20),
                    _themesWidget(),
                    const SizedBox(height: 10),
                    _continueButton(widget.onContine)
                  ],
                ),
              ),
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
