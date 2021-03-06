import 'package:flutter/material.dart';
import 'package:yacm/models/post/post.dart';
import 'package:yacm/models/post/posts/event.dart';
import 'package:yacm/util/ui_constants.dart';

class GridEvent extends StatelessWidget {
  final Post event;
  const GridEvent({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Event _event = event as Event;
    return Container(
        width: (UIConstants.getPostWidth(context) / 3) - 1,
        height: (UIConstants.getPostWidth(context) / 3) - 1,
        color: Colors.transparent.withOpacity(.03),
        child: _event.images.isNotEmpty
            ? Image.network(
                _event.images.first,
                fit: BoxFit.fill,
              )
            : SizedBox());
  }
}
