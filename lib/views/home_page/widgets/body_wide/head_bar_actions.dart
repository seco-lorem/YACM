import 'package:flutter/material.dart';

class HeadBarActions extends StatelessWidget {
  final VoidCallback? onPressed;
  final VoidCallback? onLogOut;
  const HeadBarActions({Key? key, this.onPressed, this.onLogOut})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Theme(
              data: Theme.of(context).copyWith(
                  textButtonTheme: TextButtonThemeData(
                      style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(
                              Colors.grey.withOpacity(.15))))),
              child: TextButton(
                onPressed: onPressed!,
                child: Text(
                  "Notifications",
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4.0, right: 8),
            child: Theme(
              data: Theme.of(context).copyWith(
                  textButtonTheme: TextButtonThemeData(
                      style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(
                              Colors.grey.withOpacity(.15))))),
              child: TextButton(
                onPressed: onLogOut!,
                child: Text(
                  "Log Out",
                  style: TextStyle(
                      color: Color.fromRGBO(94, 119, 3, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
