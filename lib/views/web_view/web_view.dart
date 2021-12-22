import 'package:flutter/material.dart';
import 'package:yacm/models/language/language.dart';
import 'package:yacm/models/theme/own_theme_fields.dart';
import 'package:yacm/views/common_views/explore_screen.dart';
import 'package:yacm/views/common_views/home_screen.dart';
import 'package:yacm/views/common_views/subscription_screen.dart';
import 'package:yacm/views/web_view/home_screen/widgets/side_bar.dart';
import 'package:yacm/views/web_view/home_screen/widgets/top_bar.dart';
import 'package:yacm/views/common_views/pinnder_screen.dart';
import 'package:yacm/views/common_views/profile_screen.dart';

/// This is a screen that uses cross platform screens and
/// web only widgets to generate a web view
class WebView extends StatefulWidget {
  const WebView({Key? key}) : super(key: key);

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  Language? _language;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _language = Language.of(context);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  Widget _body() {
    final List<Widget> _pages = [
      HomeScreen(language: _language!),
      PinnedScreen(language: _language!),
      ExploreScreen(),
      SubscriptionScreen(language: _language!),
      ProfileScreen()
    ];
    return Container(
      color: Theme.of(context).own().background,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Center(
                    child: PageView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: _pageController,
                      children: _pages,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SideBar(
            language: _language!,
            currentPage: _currentPage,
            onPageChange: (page) {
              setState(() {
                _currentPage = page;
                _pageController.jumpToPage(page);
              });
            },
            suggestedClubs: [
              {
                "name": "Bilkent Club 1 Bilkent Club 1 Bilkent Club 1",
                "subtitle": "subtitle1"
              },
              {"name": "Bilkent Club 2", "subtitle": "subtitle1"},
              {"name": "Bilkent Club 3", "subtitle": "subtitle1"},
              {"name": "Bilkent Club 4", "subtitle": "subtitle1"}
            ],
          ),
          Positioned(
            top: 5,
            child: TopBar(
              currentPage: _currentPage,
              onPageChange: (page) {
                setState(() {
                  _currentPage = page;
                  _pageController.jumpToPage(page);
                });
              },
              isSmall: (MediaQuery.of(context).size.width < 800),
              onLogoTap: () {},
              notifications: [
                {"title": "title1", "subtitle": "subtitle1"},
                {"title": "title1", "subtitle": "subtitle1"},
                {"title": "title1", "subtitle": "subtitle1"},
                {"title": "title1", "subtitle": "subtitle1"}
              ],
              recommendedClubs: [
                {
                  "name": "Bilkent Club 1 Bilkent Club 1 Bilkent Club 1",
                  "subtitle": "subtitle1"
                },
                {"name": "Bilkent Club 2", "subtitle": "subtitle1"},
                {"name": "Bilkent Club 3", "subtitle": "subtitle1"},
                {"name": "Bilkent Club 4", "subtitle": "subtitle1"}
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }
}
