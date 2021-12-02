import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      SizedBox(
        width: 200,
        height: 110,
        child: Center(
          child: Text("Yacm".toUpperCase(),
              textAlign: TextAlign.center,
              style:
                  const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        ),
      ),
      SizedBox(
        width: size.width - 400,
        height: 110,
        child: Center(child: TextField()),
      ),
      SizedBox(
        width: 100,
        height: 110,
        child: Center(
            child: TextButton(
          child: const Text(
            'Notifications',
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
          onPressed: () {},
        )),
      ),
      SizedBox(
        width: 100,
        height: 110,
        child: Center(
            child: TextButton(
          child: const Text(
            'Log Out',
            style: TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
          ),
          onPressed: () {},
        )),
      )
    ]);
  }
}
