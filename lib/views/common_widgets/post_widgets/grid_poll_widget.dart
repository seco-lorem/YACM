import 'package:flutter/material.dart';
import 'package:yacm/models/post/post.dart';
import 'package:yacm/models/post/posts/poll.dart';
import 'package:yacm/models/theme/own_theme_fields.dart';
import 'package:yacm/util/ui_constants.dart';

class GridPoll extends StatelessWidget {
  final Post poll;
  const GridPoll({Key? key, required this.poll}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Poll _poll = poll as Poll;
    return Container(
      width: (UIConstants.getPostWidth(context) / 3) - 1,
      height: (UIConstants.getPostWidth(context) / 3) - 1,
      decoration: BoxDecoration(color: Colors.transparent.withOpacity(.03)),
      child: Center(
        child: Text(
          _poll.question,
          style: TextStyle(color: Theme.of(context).own().gridPostText),
        ),
      ),
    );
  }
}
