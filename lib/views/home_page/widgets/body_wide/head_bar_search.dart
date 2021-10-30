import 'package:flutter/material.dart';

import '../../../../util/ui_constants.dart';

class HeadBarSearch extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onPressed;
  const HeadBarSearch({Key? key, this.controller, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 8, right: 8),
        width: UIConstants.getWidth(context, width: 500, multiplier: .3),
        height: 40,
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(.35),
            borderRadius: BorderRadius.circular(24)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: UIConstants.getWidth(context, width: 500, multiplier: .3) *
                      .9 -
                  32,
              child: TextField(
                textAlignVertical: TextAlignVertical.bottom,
                autocorrect: false,
                keyboardType: TextInputType.text,
                textAlign: TextAlign.justify,
                style: TextStyle(
                    color: Colors.white, decoration: TextDecoration.none),
                maxLines: 1,
                cursorColor: Colors.white,
                controller: controller,
                decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: TextStyle(color: Colors.white.withOpacity(.8)),
                    border: InputBorder.none),
              ),
            ),
            Expanded(
              child: IconButton(
                  onPressed: onPressed!(controller!.text),
                  icon: Icon(Icons.search, color: Colors.white)),
            )
          ],
        ));
  }
}
