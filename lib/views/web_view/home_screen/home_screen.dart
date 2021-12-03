import 'package:flutter/material.dart';
import 'widgets/app_bar.dart';
import 'widgets/top_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      width: size.width,
      height: size.height,
      color: Colors.teal,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TopBar(size: size),
          Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
            const SizedBox(
              width: 200,
              child: LeftAppBar(),
            ),
            Container(
                //POST
                width: (size.width - 400),
                height: size.height - 150,
                alignment: Alignment.bottomCenter,
                color: Colors.blue,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                          child: Text(
                        'POST',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      )),
                      Center(
                          child: Text(
                        'POST',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      )),
                      Center(
                          child: Text(
                        'POST',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      )),
                      Center(
                          child: Text(
                        'POST',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      )),
                      Center(
                          child: Text(
                        'POST',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      )),
                      Center(
                          child: Text(
                        'POST',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      )),
                      Center(
                          child: Text(
                        'POST',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      )),
                      Center(
                          child: Text(
                        'POST',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      )),
                      Center(
                          child: Text(
                        'POST',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      )),
                      Center(
                          child: Text(
                        'POST',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      )),
                      Center(
                          child: Text(
                        'POST',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      )),
                      Center(
                          child: Text(
                        'POST',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      )),
                      Center(
                          child: Text(
                        'POST',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      )),
                      Center(
                          child: Text(
                        'POST',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      )),
                      Center(
                          child: Text(
                        'POST',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      )),
                      Center(
                          child: Text(
                        'POST',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      )),
                      Center(
                          child: Text(
                        'POST',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      )),
                      Center(
                          child: Text(
                        'POST',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      )),
                      Center(
                          child: Text(
                        'POST',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      )),
                      Center(
                          child: Text(
                        'POST',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      )),
                      Center(
                          child: Text(
                        'POST',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      )),
                      Center(
                          child: Text(
                        'POST',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      )),
                      Center(
                          child: Text(
                        'POST',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      )),
                      Center(
                          child: Text(
                        'POST',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      )),
                      Center(
                          child: Text(
                        'POST',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      )),
                      Center(
                          child: Text(
                        'POST',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      )),
                      Center(
                          child: Text(
                        'POST',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      )),
                      Center(
                          child: Text(
                        'POST',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      )),
                      Center(
                          child: Text(
                        'POST',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      )),
                      Center(
                          child: Text(
                        'POST',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      )),
                      Center(
                          child: Text(
                        'POST',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      )),
                    ],
                  ),
                )),
            Container(
              width: 200,
              height: size.height - 150,
              alignment: Alignment.topCenter,
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    Text(
                      'Suggested Clubs',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24),
                    ),
                    Text(
                      'Club1',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Club2',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Club3',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ],
      ),
    ));
  }
}
