import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/language/language.dart';
import '../../../models/theme/own_theme_fields.dart';
import '../../../util/ui_constants.dart';

class BottomScroller extends StatelessWidget {
  final int pageNumber;
  final int totalPages;
  final bool nextVisible;
  final VoidCallback? onBackTap;
  final VoidCallback? onNextTap;
  final VoidCallback? onFinishTap;
  const BottomScroller(
      {Key? key,
      this.pageNumber = 0,
      this.totalPages = 0,
      this.onBackTap,
      this.onNextTap,
      this.onFinishTap,
      this.nextVisible = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Language? language = Language.of(context);
    bool isShort = UIConstants.platformIsShort(context);

    return Container(
      height: UIConstants.getHeight(context, height: 20, multiplier: .075),
      width: UIConstants.getWidth(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          pageNumber != 1
              ? GestureDetector(
                  onTap: pageNumber != 1 ? onBackTap : null,
                  child: SizedBox(
                    width: UIConstants.getSafeWidth(context) * .225,
                    child: Text(
                      language!.signUpBack,
                      style: TextStyle(
                          color:
                              Theme.of(context).own().signUpBottomScrollerText,
                          fontSize: UIConstants.getHeight(context, height: 15),
                          decoration: TextDecoration.none),
                    ),
                  ),
                )
              : SizedBox(
                  width: UIConstants.getSafeWidth(context) * .225,
                ),
          Container(
              height: UIConstants.getSafeHeight(context) * .05,
              width: UIConstants.getSafeWidth(context) * .45,
              child: Align(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: totalPages,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: CircleAvatar(
                        radius: pageNumber == index + 1
                            ? isShort
                                ? UIConstants.getSafeHeight(context) * .015
                                : UIConstants.getSafeHeight(context) * .01
                            : isShort
                                ? UIConstants.getSafeHeight(context) * .0075
                                : UIConstants.getSafeHeight(context) * .005,
                        backgroundColor: pageNumber == index + 1
                            ? Theme.of(context)
                                .own()
                                .signUpBottomScrollerCurrentDot
                            : Theme.of(context).own().signUpBottomScrollerDots,
                      ),
                    );
                  },
                ),
              )),
          nextVisible
              ? GestureDetector(
                  onTap: onNextTap,
                  child: SizedBox(
                    width: UIConstants.getSafeWidth(context) * .225,
                    child: Text(
                      pageNumber != totalPages
                          ? language!.signUpNext
                          : language!.signUpFinish,
                      style: TextStyle(
                          color:
                              Theme.of(context).own().signUpBottomScrollerText,
                          fontSize: UIConstants.getHeight(context, height: 15),
                          decoration: TextDecoration.none),
                      textAlign: TextAlign.end,
                    ),
                  ),
                )
              : SizedBox(width: UIConstants.getSafeWidth(context) * .225)
        ],
      ),
    );
  }
}
