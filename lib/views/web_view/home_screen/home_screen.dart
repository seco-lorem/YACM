import 'package:flutter/material.dart';
import 'widgets/app_bar.dart';
import 'widgets/top_bar.dart';
import 'package:yacm/models/theme/own_theme_fields.dart';

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

  List<Widget> suggestedClubElements(List<String> clubNames){
    List<Widget> elements = [];
    elements.add(Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Text(
          "Suggested Clubs",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      )
    );
    for (String clubName in clubNames) {
      Widget element = Padding(
                        padding: EdgeInsets.symmetric(vertical: 3),
                        child: Text(
                          clubName,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                        ),
      );
      elements.add(element);
    }
    return elements;
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: Theme.of(context).own().background,
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
                      color: Theme.of(context).own().background,
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
                      color: Theme.of(context).own().background,
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
                      color: Theme.of(context).own().background,
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
                      color: Theme.of(context).own().background,
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
                      color: Theme.of(context).own().background,
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
                color: Theme.of(context).own().background,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: suggestedClubElements(["a","b","c","d"])
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
