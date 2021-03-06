import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:universal_io/io.dart';
import 'package:yacm/controllers/club_manager/club_manager.dart';
import 'package:yacm/controllers/firebase_manager/firebase_manager.dart';
import 'package:yacm/controllers/hive_manager/managers/user_hive_manager.dart';
import 'package:yacm/controllers/message_manager/message_manager.dart';
import 'package:yacm/controllers/post_manager/post_manager.dart';
import 'package:yacm/controllers/user_manager/user_manager.dart';
import 'package:yacm/models/theme/own_theme_fields.dart';
import 'package:yacm/models/user/user.dart';
import 'package:yacm/router/route_generator.dart';
import 'package:yacm/views/web_view/not_logged_in/not_logged_in_view.dart';
import 'controllers/language_controller/language_delegate.dart';
import 'controllers/language_controller/locale_constant.dart';
import 'controllers/shared_pref_controller/sp_controller.dart';
import 'controllers/theme_controller/theme_changer.dart';
import 'models/language/language.dart';
import 'views/app_view/app_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isIOS || Platform.isAndroid) {
    await Firebase.initializeApp();
  } else {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBPFKxM9MsxTQGEaQr6Q4G-PTuD4K3GdS8",
            authDomain: "yacm-c626b.firebaseapp.com",
            projectId: "yacm-c626b",
            storageBucket: "yacm-c626b.appspot.com",
            messagingSenderId: "336218459715",
            appId: "1:336218459715:web:77d0188c6263488d6e0ef6",
            measurementId: "G-4P9C8VHPVB"));
  }
  Hive
    ..initFlutter()
    ..registerAdapter(UserAdapter());
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
  void initState() {
    super.initState();
    initVariables();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SPController.getBoolValue("darkMode"),
        builder: (context, AsyncSnapshot<bool?> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null) {
              SPController.setBoolValue("darkMode", false);
            }
            return MultiProvider(
              providers: [
                ChangeNotifierProvider<ThemeChanger>(
                  create: (context) => ThemeChanger(snapshot.data ?? false),
                ),
                ChangeNotifierProvider<UserManager>(
                  create: (context) =>
                      UserManager(UserHiveManager(), FirebaseManager()),
                ),
                ChangeNotifierProvider<PostManager>(
                  create: (context) => PostManager(
                      FirebaseManager(), MessageManager(FirebaseManager())),
                ),
                ChangeNotifierProvider<ClubManager>(
                  create: (context) => ClubManager(
                      FirebaseManager(),
                      MessageManager(FirebaseManager()),
                      PostManager(FirebaseManager(),
                          MessageManager(FirebaseManager()))),
                )
              ],
              child: MyApp(),
            );
          }
          return Container();
        });
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
  bool _loggedIn = false;
  Widget? _home;

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
      });
    });
    super.didChangeDependencies();
  }

  void getLocaleFromCache() async {
    Locale tempLocale = await getLocale();
    bool loggedIn = await SPController.getBoolValue("loggedIn") ?? false;

    if (loggedIn) {
      await Provider.of<UserManager>(context, listen: false).getOwnData();
    }
    setState(() {
      _locale = tempLocale;
      _loggedIn = loggedIn;
      _home = _loggedIn ? AppView() : NotLoggedIn();
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      locale: _locale,
      title: 'YACM',
      home: _home,
      theme: _themeChanger.getTheme(),
      supportedLocales: const [Locale('tr'), Locale('en')],
      localizationsDelegates: <LocalizationsDelegate>[
        LanguageDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
