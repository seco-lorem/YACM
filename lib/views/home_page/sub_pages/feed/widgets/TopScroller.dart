import 'package:flutter/material.dart';

import '../../../../../models/theme/own_theme_fields.dart';
import '../../../../../util/ui_constants.dart';

class TopScroller extends StatelessWidget {
  final Function(int?)? onTap;
  final int currentFeed;
  const TopScroller({Key? key, this.onTap, this.currentFeed = 0})
      : super(key: key);

  Widget _scrollerItem(int index, String text, BuildContext context) {
    return GestureDetector(
      onTap: () => onTap!(index),
      child: Container(
        child: Text(
          text,
          maxLines: null,
          style: TextStyle(
              color: currentFeed == index
                  ? Theme.of(context).own().feedScrollerChosenText
                  : Theme.of(context).own().feedScrollerText,
              fontSize: UIConstants.getHeight(context, height: 15)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(top: UIConstants.getPaddingVertical(context) * 2),
      child: Container(
        width: UIConstants.getSafeWidth(context),
        height: UIConstants.getSafeHeight(context) * .1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _scrollerItem(0, "Active", context),
            _scrollerItem(1, "Suggested", context),
            _scrollerItem(2, "Pinned", context)
          ],
        ),
      ),
    );
  }
}
