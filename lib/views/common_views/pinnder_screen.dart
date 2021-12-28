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
import 'package:yacm/views/common_widgets/post_widgets/poll_widget.dart';

/// This is a screen for pinned page
/// which works both on mobile (iOS and Android) and web
class PinnedScreen extends StatefulWidget {
  final Language language;
  const PinnedScreen({Key? key, required this.language}) : super(key: key);

  @override
  _PinnedScreenState createState() => _PinnedScreenState();
}

class _PinnedScreenState extends State<PinnedScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Theme.of(context).own().background,
      body: Container(
          padding: EdgeInsets.only(top: 60),
          color: Theme.of(context).own().background,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: StreamBuilder(
            stream: Provider.of<UserManager>(context).getPinnedPosts(),
            builder: (context, AsyncSnapshot<QuerySnapshot> stream) {
              if (stream.connectionState == ConnectionState.active) {
                List<Widget> _posts = [
                  SizedBox(width: MediaQuery.of(context).size.width)
                ];
                for (DocumentSnapshot post in stream.data!.docs) {
                  if (post.get("type") == "event") {
                    _posts.add(EvenWidget(
                        loggedIn: Provider.of<UserManager>(context).user !=
                            null,
                        manager:
                            Provider.of<UserManager>(context).user != null &&
                                post.get("managers").contains(
                                    Provider.of<UserManager>(context).user!.id),
                        advisor:
                            Provider.of<UserManager>(context).user != null &&
                                post.get("advisor").compareTo(
                                        Provider.of<UserManager>(context)
                                            .user!
                                            .id) ==
                                    0,
                        language: widget.language,
                        post: Event.fromDocumentSnapshot(post),
                        comments: []));
                  } else if (post.get("type") == "poll") {
                    _posts.add(PollWidget(
                      language: widget.language,
                      post: Poll.fromDocumentSnapshot(post),
                      comments: [],
                      loggedIn: Provider.of<UserManager>(context).user != null,
                      manager: Provider.of<UserManager>(context).user != null &&
                          post.get("managers").contains(
                              Provider.of<UserManager>(context).user!.id),
                      advisor: Provider.of<UserManager>(context).user != null &&
                          post.get("advisor").compareTo(
                                  Provider.of<UserManager>(context).user!.id) ==
                              0,
                      hasVoted:
                          Provider.of<UserManager>(context).user != null &&
                              !post.get("voters").contains(
                                  Provider.of<UserManager>(context).user!.id),
                    ));
                  }
                }
                return SingleChildScrollView(
                  controller: ScrollController(),
                  child: Column(
                    children: _posts,
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
