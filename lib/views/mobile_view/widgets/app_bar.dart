import 'package:flutter/material.dart';
import 'package:yacm/models/theme/own_theme_fields.dart';

class MobileAppBar extends StatelessWidget {
  final int currentPage;
  const MobileAppBar({Key? key, required this.currentPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> _titles = [
      "Explore",
      "QR Scanner",
      "Notifications",
      "Profile"
    ];
    return AppBar(
        centerTitle: true,
        title: Text(
          _titles[currentPage],
          style: TextStyle(
            color: Theme.of(context).own().appBarText,
          ),
        ));
  }
}
