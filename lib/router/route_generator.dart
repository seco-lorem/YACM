import 'package:flutter/material.dart';
import 'package:yacm/models/language/languages/English.dart';
import 'package:yacm/models/language/languages/Turkish.dart';
import 'package:yacm/router/route_names.dart';
import 'package:yacm/views/common_views/club_profile.dart';
import 'package:yacm/views/common_views/explore_screen.dart';
import 'package:yacm/views/common_views/home_screen.dart';
import 'package:yacm/views/common_views/profile_screen.dart';

class _GeneratePageRoute extends PageRouteBuilder {
  final Widget widget;
  final String routeName;
  _GeneratePageRoute({required this.widget, required this.routeName})
      : super(
            settings: RouteSettings(name: routeName),
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return widget;
            },
            reverseTransitionDuration: Duration(milliseconds: 250),
            transitionDuration: Duration(milliseconds: 250),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return SlideTransition(
                textDirection: TextDirection.rtl,
                position: Tween<Offset>(
                  begin: Offset(-1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            });
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    String splitted = settings.name!.split('?')[0];
    switch (splitted) {
      case RouteNames.post:
        Uri settingsUri = Uri.parse(settings.name.toString());
        final postId = settingsUri.queryParameters['id'];
        print("PostId = " + postId.toString());
        return _GeneratePageRoute(
            widget: ProfileScreen(), routeName: settings.name.toString());
      default:
        return _GeneratePageRoute(
            widget: ClubProfile(
              id: "",
            ),
            routeName: settings.name.toString());
    }
  }
}
