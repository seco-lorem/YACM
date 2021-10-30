import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'head_bar_actions.dart';
import 'head_bar_search.dart';

class HeadBar extends StatelessWidget {
  final VoidCallback? onHomeTap;
  final VoidCallback? onLogOut;
  final VoidCallback? onNotificationTap;
  final TextEditingController? controller;
  final Function(String)? onSearchTap;
  const HeadBar(
      {Key? key,
      this.onHomeTap,
      this.onLogOut,
      this.onNotificationTap,
      this.controller,
      this.onSearchTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      height: 60,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Theme(
            data: Theme.of(context).copyWith(
                textButtonTheme: TextButtonThemeData(
                    style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent)))),
            child: TextButton(
                onPressed: onHomeTap!,
                child: Text(
                  "YACM",
                  style: GoogleFonts.pacifico(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color.fromRGBO(94, 119, 3, 1),
                  ),
                )),
          ),
          Center(
            child: HeadBarSearch(
              onPressed: onSearchTap!,
              controller: controller,
            ),
          ),
          HeadBarActions(
            onPressed: onNotificationTap!,
            onLogOut: onLogOut!,
          )
        ],
      ),
    );
  }
}
