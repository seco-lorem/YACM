import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yacm/controllers/post_manager/post_manager.dart';
import 'package:yacm/controllers/user_manager/user_manager.dart';
import 'package:yacm/models/language/language.dart';
import 'package:yacm/models/message/message.dart';
import 'package:yacm/models/post/posts/poll.dart';
import 'package:yacm/models/theme/own_theme_fields.dart';
import 'package:yacm/util/ui_constants.dart';
import 'package:yacm/views/common_widgets/post_widgets/post_settings_widget.dart';
import 'package:yacm/views/common_widgets/post_widgets/post_widget.dart';

class PollWidget extends StatefulWidget {
  final Language language;
  final Poll post;
  final List<Message> comments;
  final bool hasVoted;
  final bool manager;
  final bool advisor;
  final bool loggedIn;
  final bool popOnDelete;
  final List<String> managers;

  const PollWidget({
    Key? key,
    required this.language,
    required this.post,
    required this.comments,
    required this.hasVoted,
    required this.manager,
    required this.advisor,
    required this.loggedIn,
    required this.managers,
    this.popOnDelete = false,
  }) : super(key: key);

  @override
  _PollWidgetState createState() => _PollWidgetState();
}

class _PollWidgetState extends State<PollWidget> {
  int? choice;
  bool _hasVoted = false;

  PostManager? _postManager;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void initHasVoted() async {
    DocumentSnapshot temp = await FirebaseFirestore.instance
        .collection("posts")
        .doc(widget.post.id)
        .get();
    setState(() {
      if (FirebaseAuth.instance.currentUser != null) {
        _hasVoted =
            temp.get("voters").contains(FirebaseAuth.instance.currentUser!.uid);
      }
    });
  }

  @override
  initState() {
    super.initState();
    initHasVoted();
    _postManager = Provider.of<PostManager>(context, listen: false);
  }

  @override
  dispose() {
    super.dispose();
  }

  Widget _poll(int index) {
    final double width = UIConstants.getPostWidth(context);
    final double height =
        ((width * .8) * (3 / 4) / widget.post.votes.length) * .5;

    bool contains = false;
    if (widget.post.votes[index].containsValue(
        FirebaseAuth.instance.currentUser != null
            ? FirebaseAuth.instance.currentUser!.uid
            : "adwkmadwmkdawkmdaw")) {
      contains = true;
    }

    return SizedBox(
      width: width,
      child: InkWell(
        onTap: () async {
          if (widget.loggedIn) {
            bool result = await _postManager!.votePost(widget.post.id, index);
            if (result && !_hasVoted) {
              setState(() {
                choice = index;
                _hasVoted = true;
              });
            }
          }
        },
        child: Container(
          padding: _hasVoted
              ? EdgeInsets.zero
              : EdgeInsets.symmetric(vertical: (height) / 2),
          alignment: !_hasVoted ? Alignment.center : Alignment.centerLeft,
          decoration: BoxDecoration(
            border:
                Border.all(color: Theme.of(context).own().pollWidgetQuestion),
            borderRadius: BorderRadius.circular(UIConstants.borderRadius),
            color: Color.fromRGBO(244, 226, 198, 1),
          ),
          child: !_hasVoted
              ? Center(
                  child: Text(widget.post.options[index],
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).own().pollWidgetOption)))
              : Stack(
                  children: [
                    AnimatedContainer(
                      padding: EdgeInsets.only(left: 8),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(UIConstants.borderRadius),
                          color: contains
                              ? Theme.of(context).own().pollWidgetOption
                              : Theme.of(context)
                                  .own()
                                  .pollWidgetOption
                                  .withOpacity(.5)),
                      curve: Curves.easeIn,
                      height: height,
                      duration: const Duration(milliseconds: 250),
                      width: width *
                          widget.post.votes[index].length /
                          widget.post.voters.length,
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = UIConstants.getPostWidth(context);
    return Container(
        width: width,
        height: width * .9,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(UIConstants.borderRadius / 2),
            color: Theme.of(context).own().background.withOpacity(.1),
            boxShadow: []),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(widget.post.question,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .own()
                                      .pollWidgetQuestion)),
                        ),
                      ),
                      Expanded(
                        flex: 9,
                        child: ListView.builder(
                            controller: ScrollController(),
                            itemCount: widget.post.options.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Visibility(
                                      visible: _hasVoted,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 8.0,
                                              bottom: 2,
                                            ),
                                            child: Text(
                                                widget.post.options[index],
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(context)
                                                        .own()
                                                        .pollWidgetQuestion))),
                                      ),
                                    ),
                                    _poll(index),
                                  ],
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: PostSettings(
                      popOnDelete: widget.popOnDelete,
                      post: widget.post,
                      managers: widget.managers,
                      clubID: widget.post.clubID,
                      manager: widget.manager,
                      advisor: widget.advisor,
                      loggedIn: widget.loggedIn,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: PostWidget(
                  language: widget.language,
                  post: widget.post,
                  comments: widget.comments,
                  icons: [
                    Icon(
                      Icons.pin_drop,
                      color: Theme.of(context).own().postWidgetIcons,
                    ),
                  ],
                  onIconTaps: [
                    () async {
                      await _postManager!.pinPost(widget.post.id);
                    }
                  ]),
            )
          ],
        ));
  }
}
