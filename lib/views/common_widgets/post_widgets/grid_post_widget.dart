import 'package:flutter/material.dart';
import 'package:yacm/models/post/post.dart';
import 'package:yacm/models/post/posts/event.dart';
import 'package:yacm/router/route_names.dart';
import 'package:yacm/util/ui_constants.dart';
import 'package:yacm/views/common_views/post_screen.dart';
import 'package:yacm/views/common_widgets/post_widgets/grid_event_widget.dart';
import 'package:yacm/views/common_widgets/post_widgets/grid_poll_widget.dart';

class GridPost extends StatefulWidget {
  final List<Post> posts;
  const GridPost({Key? key, required this.posts}) : super(key: key);

  @override
  _GridPostState createState() => _GridPostState();
}

class _GridPostState extends State<GridPost> {
  void _navigateToPost(Post post) {
    Navigator.pushNamed(context, RouteNames.post + "?id=" + post.id);
  }

  List<Widget> _posts() {
    List<Widget> _returnList = [];

    for (Post post in widget.posts) {
      if (post.type == PostType.EVENT) {
        _returnList.add(SizedBox(
          width: (UIConstants.getPostWidth(context) / 3) - 1,
          height: (UIConstants.getPostWidth(context) / 3) - 1,
          child: InkWell(
            onTap: () {
              _navigateToPost(post);
            },
            child: GridEvent(
              event: post,
            ),
          ),
        ));
      } else if (post.type == PostType.POLL) {
        _returnList.add(SizedBox(
          width: (UIConstants.getPostWidth(context) / 3) - 1,
          height: (UIConstants.getPostWidth(context) / 3) - 1,
          child: InkWell(
            onTap: () {
              _navigateToPost(post);
            },
            child: Hero(
              tag: post.id,
              child: GridPoll(poll: post),
            ),
          ),
        ));
      }
    }

    return _returnList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
        ),
        Container(
          width: UIConstants.getPostWidth(context),
          child: Wrap(runSpacing: 1, spacing: 1, children: _posts()),
        ),
      ],
    );
  }
}
