import 'package:flutter/material.dart';
import 'package:yacm/views/common_views/club_profile.dart';
import 'package:yacm/views/common_views/profile_screen.dart';
import 'package:yacm/views/web_view/not_logged_in/not_logged_in_view.dart';
import 'package:yacm/views/web_view/web_view.dart';
import '../../models/language/language.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return ClubProfile(id:"");
  }
}
