import 'package:flutter/material.dart';

import 'widgets/TopScroller.dart';

class Feed extends StatelessWidget {
  final int topScrollerIndex;
  final Function(int?)? onScrollTap;
  const Feed({Key? key, this.onScrollTap, this.topScrollerIndex = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TopScroller(
          onTap: onScrollTap,
          currentFeed: topScrollerIndex,
        ),
      ],
    );
  }
}
