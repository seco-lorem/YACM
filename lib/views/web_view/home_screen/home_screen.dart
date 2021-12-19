import 'package:flutter/material.dart';
import 'widgets/app_bar.dart';
import 'widgets/top_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;
  @override
  void dispose(){
    super.dispose();
    _pageController.dispose();
  }
  void changePage(){
    _pageController.jumpToPage(_currentIndex);
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: Color.fromRGBO(244, 226, 198, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TopBar(size: size),
            Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
              SizedBox(
                width: 200,
                child: LeftAppBar(currentIndex: _currentIndex, onTap: (index) {setState(() {
                  _currentIndex = index;
                  _pageController.jumpToPage(_currentIndex);
                });}),
              ),
              SizedBox(
                width: (size.width - 400),
                height: size.height - 150,
                child: PageView(
                  controller: _pageController,
                  children: <Widget>[
                    Container(
                      //POST Page View +Page view Controller 
                      width: (size.width - 400),
                      height: size.height - 150,
                      alignment: Alignment.bottomCenter,
                      color: Color.fromRGBO(244, 226, 198, 1),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            for (int i = 0; i < 100; i++)Center(
                              child: Text(
                              'POST' + i.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 30),
                              )
                            ),
                          ],
                        ),
                      )
                    ),
                    Container(
                      //POST Page View +Page view Controller 
                      width: (size.width - 400),
                      height: size.height - 150,
                      alignment: Alignment.bottomCenter,
                      color: Color.fromRGBO(244, 226, 198, 1),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            for (int i = 0; i < 80; i++)Center(
                              child: Text(
                              'POST' + i.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 30),
                              )
                            ),
                          ],
                        ),
                      )
                    ),
                    Container(
                      //POST Page View +Page view Controller 
                      width: (size.width - 400),
                      height: size.height - 150,
                      alignment: Alignment.bottomCenter,
                      color: Color.fromRGBO(244, 226, 198, 1),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            for (int i = 0; i < 60; i++)Center(
                              child: Text(
                              'POST' + i.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 30),
                              )
                            ),
                          ],
                        ),
                      )
                    ),
                    Container(
                      //POST Page View +Page view Controller 
                      width: (size.width - 400),
                      height: size.height - 150,
                      alignment: Alignment.bottomCenter,
                      color: Color.fromRGBO(244, 226, 198, 1),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            for (int i = 0; i < 40; i++)Center(
                              child: Text(
                              'POST' + i.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 30),
                              )
                            ),
                          ],
                        ),
                      )
                    ),
                    Container(
                      //POST Page View +Page view Controller 
                      width: (size.width - 400),
                      height: size.height - 150,
                      alignment: Alignment.bottomCenter,
                      color: Color.fromRGBO(244, 226, 198, 1),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            for (int i = 0; i < 20; i++)Center(
                              child: Text(
                              'POST' + i.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 30),
                              )
                            ),
                          ],
                        ),
                      )
                    ),
                  ]
                ),
              ),
              Container(
                width: 200,
                height: size.height - 150,
                alignment: Alignment.topCenter,
                color: Color.fromRGBO(244, 226, 198, 1),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: 
                            Text(
                              'Suggested Clubs',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 24, color: Color.fromRGBO(94, 119, 3, 1)),
                            ),
                        ),
                        
                        Text(
                          'ACM Bilkent Club',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                        ),
                        Text(
                          'Aikido Society',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                        ),
                        Text(
                          'Tea Club',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                        ),
                        Text(
                          'Arab Culture Society',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                        ),
                        Text(
                          'Archaeology Club',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                        ),
                        Text(
                          'Astronomy Society',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                        ),
                        Text(
                          'Literature Society',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                        ),
                        Text(
                          'Atelier Bilkent Society',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ],
        ),
      )
    );
  }
}
