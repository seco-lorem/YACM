import 'package:flutter/material.dart';
import 'package:yacm/models/language/language.dart';
import 'package:yacm/models/post/post.dart';
import 'package:yacm/models/post/posts/event.dart';
import 'package:yacm/models/post/posts/poll.dart';
import 'package:yacm/models/theme/own_theme_fields.dart';
import 'package:yacm/util/helper.dart';
import 'package:yacm/views/common_widgets/post_widgets/event_widget.dart';
import 'package:yacm/views/common_widgets/post_widgets/poll_widget.dart';

class HomeScreen extends StatefulWidget {
  final Language language;
  const HomeScreen({Key? key, required this.language}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Container(
          padding: EdgeInsets.only(top: 60),
          color: Theme.of(context).own().background,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            controller: ScrollController(),
            itemCount: Helper.posts.length,
            itemBuilder: (context, index) {
              Widget _child;

              if (Helper.posts[index].type == PostType.EVENT) {
                _child = EvenWidget(
                    language: widget.language,
                    post: Helper.posts[index] as Event,
                    comments: Helper.comments);
              } else {
                _child = PollWidget(
                    language: widget.language,
                    post: Helper.posts[index] as Poll,
                    comments: Helper.comments);
              }

              return Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: _child,
                ),
              );
            },
          )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
