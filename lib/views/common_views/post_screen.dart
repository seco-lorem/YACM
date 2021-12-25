import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yacm/controllers/post_manager/post_manager.dart';
import 'package:yacm/controllers/user_manager/user_manager.dart';
import 'package:yacm/models/language/language.dart';
import 'package:yacm/models/post/posts/event.dart';
import 'package:yacm/models/post/posts/poll.dart';
import 'package:yacm/models/theme/own_theme_fields.dart';
import 'package:yacm/views/common_widgets/post_widgets/event_widget.dart';
import 'package:yacm/views/common_widgets/post_widgets/poll_widget.dart';

class PostScreen extends StatefulWidget {
  final String postID;
  const PostScreen({Key? key, required this.postID}) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).own().background,
      child: Center(
        child: StreamBuilder(
          stream: Provider.of<PostManager>(context, listen: false)
              .getPostStream(widget.postID),
          builder: (context, AsyncSnapshot<DocumentSnapshot> stream) {
            if (stream.hasData) {
              if (stream.data!.get("type") == "event") {
                return EvenWidget(
                    language: Language.of(context)!,
                    post: Event.fromDocumentSnapshot(stream.data!),
                    comments: []);
              } else if (stream.data!.get("type") == "poll") {
                return PollWidget(
                    language: Language.of(context)!,
                    post: Poll.fromDocumentSnapshot(stream.data!),
                    comments: []);
              }
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    ));
  }
}
