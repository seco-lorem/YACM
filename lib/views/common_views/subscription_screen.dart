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

class SubscriptionScreen extends StatefulWidget {
  final Language language;
  const SubscriptionScreen({Key? key, required this.language})
      : super(key: key);

  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen>
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
          child: StreamBuilder(
            stream: Provider.of<UserManager>(context).getSubbedPosts(),
            builder: (context, AsyncSnapshot<QuerySnapshot> stream) {
              if (stream.connectionState == ConnectionState.active) {
                List<Widget> _posts = [
                  SizedBox(width: MediaQuery.of(context).size.width)
                ];
                for (DocumentSnapshot post in stream.data!.docs) {
                  if (post.get("type") == "event") {
                    _posts.add(EvenWidget(
                        language: widget.language,
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
                        post: Event.fromDocumentSnapshot(post),
                        comments: []));
                  } else if (post.get("type") == "poll") {
                    _posts.add(PollWidget(
                        loggedIn:
                            Provider.of<UserManager>(context).user != null,
                        manager: Provider.of<UserManager>(context).user != null &&
                            post.get("managers").contains(
                                Provider.of<UserManager>(context).user!.id),
                        advisor: Provider.of<UserManager>(context).user != null &&
                            post.get("advisor").compareTo(
                                    Provider.of<UserManager>(context)
                                        .user!
                                        .id) ==
                                0,
                        hasVoted:
                            Provider.of<UserManager>(context).user != null &&
                                !post.get("voters").contains(
                                    Provider.of<UserManager>(context).user!.id),
                        language: widget.language,
                        post: Poll.fromDocumentSnapshot(post),
                        comments: []));
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
