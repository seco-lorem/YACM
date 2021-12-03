import 'package:flutter/material.dart';

import '../../models/language/language.dart';
import '../../util/helper.dart';
import '../web_view/home_screen/home_screen.dart';

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  Language? _language;

  @override
  void didChangeDependencies() {
    setState(() {
      _language = Language.of(context);
    });
    super.didChangeDependencies();
  }

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      await Helper.showGetLanguagePopUp(
          context: context,
          languages: ["English", "Turkish"],
          onContinue: () => Navigator.pop(context),
          language: Language.of(context)!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}
