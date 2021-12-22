import 'package:flutter/material.dart';
import 'package:yacm/models/theme/own_theme_fields.dart';
import 'package:yacm/views/mobile_view/widgets/app_bar.dart';
import 'package:yacm/views/mobile_view/widgets/bottom_bar.dart';

class MobileView extends StatefulWidget {
  const MobileView({Key? key}) : super(key: key);

  @override
  _MobileViewState createState() => _MobileViewState();
}

class _MobileViewState extends State<MobileView> {
  final PageController _currentPageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  dispose() {
    super.dispose();
    _currentPageController.dispose();
  }

  Widget _body() {
    return PageView(
      controller: _currentPageController,
      physics: NeverScrollableScrollPhysics(),
      children: [],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentPage == 0
          ? null
          : PreferredSize(
              child: MobileAppBar(currentPage: _currentPage),
              preferredSize: AppBar().preferredSize,
            ),
      backgroundColor: Theme.of(context).own().background,
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: _body(),
            ),
            MobileBottomBar(
                onTap: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                currentPage: _currentPage)
          ],
        ),
      ),
    );
  }
}
