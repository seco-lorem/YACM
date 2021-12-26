import 'package:flutter/material.dart';
import 'package:yacm/models/language/language.dart';
import 'package:yacm/models/theme/own_theme_fields.dart';
import 'package:yacm/util/ui_constants.dart';

class PostSettings extends StatefulWidget {
  final bool manager;
  final bool advisor;
  final bool loggedIn;
  const PostSettings(
      {Key? key,
      required this.manager,
      required this.advisor,
      required this.loggedIn})
      : super(key: key);

  @override
  _PostSettingsState createState() => _PostSettingsState();
}

class _PostSettingsState extends State<PostSettings> {
  bool _settingsVisible = false;

  Widget _child(
      {required bool visible,
      required String setting,
      required VoidCallback onTap}) {
    return Visibility(
      visible: visible,
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          setting,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Theme.of(context).own().postSettingsText),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Language? _language = Language.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IconButton(
          icon: Icon(Icons.more_vert, color: Colors.white),
          onPressed: () {
            setState(() {
              _settingsVisible = !_settingsVisible;
            });
          },
        ),
        Visibility(
          visible: _settingsVisible,
          child: Container(
            decoration: BoxDecoration(
                border:
                    Border.all(color: Theme.of(context).own().postSettingsText),
                borderRadius: BorderRadius.circular(UIConstants.borderRadius),
                color: Theme.of(context).own().postSettings),
            padding:
                const EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 10),
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _child(
                    visible: widget.manager,
                    setting: _language!.delete,
                    onTap: () {}),
                _child(
                    visible: widget.advisor,
                    setting: _language.veto,
                    onTap: () {}),
                _child(
                    visible: widget.loggedIn,
                    setting: _language.sub,
                    onTap: () {})
              ],
            ),
          ),
        )
      ],
    );
  }
}
