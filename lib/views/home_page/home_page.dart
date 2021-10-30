import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/theme/own_theme_fields.dart';
import '../../util/ui_constants.dart';
import 'sub_pages/feed/feed.dart';
import 'widgets/body_slim/BottomTabBar.dart';
import 'widgets/body_slim/BottomTabBarItem.dart';
import 'widgets/body_wide/head_bar.dart';
import 'widgets/body_wide/profile_info.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;
  int _currentScrollFeed = 0;
  TextEditingController? _searchController;

  void initVariables() {
    setState(() {
      _searchController = TextEditingController();
    });
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      initVariables();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _searchController?.dispose();
  }

  BottomTabBar _bottomTabBar() {
    double _bottomBarItemHeight =
        UIConstants.getHeight(context, height: 30, multiplier: .04);
    List<BottomTabBarItem> _items = [
      BottomTabBarItem(
        Icons.home_outlined,
        Icons.home,
        Theme.of(context).own().homePageBottomBarItemColor,
        _currentPage == 0,
        size: _bottomBarItemHeight,
      ),
      BottomTabBarItem(
        CupertinoIcons.search,
        Icons.search,
        Theme.of(context).own().homePageBottomBarItemColor,
        _currentPage == 1,
        size: _bottomBarItemHeight,
      ),
      BottomTabBarItem(
        CupertinoIcons.qrcode_viewfinder,
        Icons.qr_code_scanner_rounded,
        Theme.of(context).own().homePageBottomBarItemColor,
        _currentPage == 2,
        size: _bottomBarItemHeight,
      ),
      BottomTabBarItem(
        Icons.notifications_outlined,
        Icons.notifications,
        Theme.of(context).own().homePageBottomBarItemColor,
        _currentPage == 3,
        size: _bottomBarItemHeight,
      ),
      BottomTabBarItem(
        CupertinoIcons.person,
        CupertinoIcons.person_fill,
        Theme.of(context).own().homePageBottomBarItemColor,
        _currentPage == 4,
        size: _bottomBarItemHeight,
      )
    ];
    return BottomTabBar(
      _items,
    );
  }

  Widget _currentPageWidget() {
    List<Widget> _pages = [
      Feed(
        topScrollerIndex: _currentScrollFeed,
        onScrollTap: (index) {
          setState(() {
            _currentScrollFeed = index!;
          });
        },
      )
    ];
    return _pages[_currentPage];
  }

  Widget _bodySlim() {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _currentPageWidget(),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom),
              child: _bottomTabBar(),
            )
          ],
        ),
      ),
    );
  }

  int _bodyWideCurrentPage = 1;
  void _changePage(int value) {
    setState(() {
      _bodyWideCurrentPage = value;
    });
  }

  Widget _bodyWidePage() {
    switch (_bodyWideCurrentPage) {
      case 1:

      default:
        return SizedBox();
    }
  }

  Widget _bodyWide() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: UIConstants.getSafeWidth(context),
      child: Column(
        children: [
          HeadBar(
            onHomeTap: () {
              _changePage(1);
            },
            onLogOut: () {
              Navigator.pop(context);
            },
            onNotificationTap: () {},
            onSearchTap: (value) {},
            controller: _searchController!,
          ),
          Expanded(
            child: Row(
              children: [
                UserProfile(
                    currentActive: _bodyWideCurrentPage,
                    userName: "Trial Account",
                    onTap: (value) => _changePage(value)),
                Expanded(
                  child: _bodyWidePage(),
                )
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
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).backgroundColor,
      body: UIConstants.getSafeWidth(context) < 500 ? _bodySlim() : _bodyWide(),
    );
  }
}
