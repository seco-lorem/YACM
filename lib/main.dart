import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:yacm/views/common_views/club_profile.dart';
import 'controllers/language_controller/language_delegate.dart';
import 'controllers/language_controller/locale_constant.dart';
import 'controllers/shared_pref_controller/sp_controller.dart';
import 'controllers/theme_controller/theme_changer.dart';
import 'models/language/language.dart';
import 'views/app_view/app_view.dart';

void main() async {
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyBPFKxM9MsxTQGEaQr6Q4G-PTuD4K3GdS8",
          authDomain: "yacm-c626b.firebaseapp.com",
          projectId: "yacm-c626b",
          storageBucket: "yacm-c626b.appspot.com",
          messagingSenderId: "336218459715",
          appId: "1:336218459715:web:77d0188c6263488d6e0ef6",
          measurementId: "G-4P9C8VHPVB"));
  runApp(MultiProviderApp());
}

/// This class is implemented so the providers are
/// supplied in a better scope
class MultiProviderApp extends StatefulWidget {
  @override
  State<MultiProviderApp> createState() => _MultiProviderAppState();
}

class _MultiProviderAppState extends State<MultiProviderApp> {
  bool? _darkMode;

  void initVariables() async {
    bool? tempDarkMode = await SPController.getBoolValue("darkMode");
    if (tempDarkMode == null) {
      SPController.setBoolValue("darkMode", false);
    }
    setState(() {
      _darkMode = tempDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeChanger>(
          create: (context) => ThemeChanger(_darkMode ?? false),
        )
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  Language? _language;

  @override
  void initState() {
    super.initState();
    getLocaleFromCache();
  }

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() async {
    getLocale().then((locale) {
      setState(() {
        _locale = locale;
        _language = Language.of(context);
      });
    });
    super.didChangeDependencies();
  }

  void getLocaleFromCache() async {
    Locale tempLocale = await getLocale();
    setState(() {
      _locale = tempLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      locale: _locale,
      title: 'YACM',
      home: AppView(),
      theme: _themeChanger.getTheme(),
      localizationsDelegates: <LocalizationsDelegate>[
        LanguageDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      routes: {"/club_profile": (context) => ClubProfile(id: "id")},
      debugShowCheckedModeBanner: false,
    );
  }
}
