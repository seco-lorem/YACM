import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yacm/controllers/user_manager/user_manager.dart';
import 'package:yacm/models/language/language.dart';
import 'package:yacm/models/post/post.dart';
import 'package:yacm/models/post/posts/event.dart';
import 'package:yacm/models/post/posts/poll.dart';
import 'package:yacm/models/theme/own_theme_fields.dart';
import 'package:yacm/util/helper.dart';
import 'package:yacm/views/common_widgets/post_widgets/event_widget.dart';
import 'package:yacm/views/common_widgets/post_widgets/grid_post_widget.dart';
import 'package:yacm/views/common_widgets/post_widgets/poll_widget.dart';

/// This is a screen for explore page
/// which works both on mobile (iOS and Android) and web
class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      padding: EdgeInsets.only(top: 60),
      color: Theme.of(context).own().background,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Align(
        alignment: Alignment.topCenter,
        child: StreamBuilder(
          stream: Provider.of<UserManager>(context).getPosts(),
          builder: (context, AsyncSnapshot<QuerySnapshot> stream) {
            if (stream.connectionState == ConnectionState.active) {
              List<Post> _posts = [];
              for (DocumentSnapshot post in stream.data!.docs) {
                if (post.get("type") == "event") {
                  _posts.add(Event.fromDocumentSnapshot(post));
                } else if (post.get("type") == "poll") {
                  _posts.add(Poll.fromDocumentSnapshot(post));
                }
              }
              return GridPost(posts: _posts.reversed.toList());
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
