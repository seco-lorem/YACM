import 'package:flutter/material.dart';
import 'package:yacm/models/language/language.dart';
import 'package:yacm/models/message/message.dart';
import 'package:yacm/models/post/posts/poll.dart';
import 'package:yacm/util/ui_constants.dart';
import 'package:yacm/views/common_widgets/post_widgets/post_settings_widget.dart';
import 'package:yacm/views/common_widgets/post_widgets/post_widget.dart';

class PollWidget extends StatefulWidget {
  final Language language;
  final Poll post;
  final List<Message> comments;

  const PollWidget(
      {Key? key,
      required this.language,
      required this.post,
      required this.comments})
      : super(key: key);

  @override
  _PollWidgetState createState() => _PollWidgetState();
}

class _PollWidgetState extends State<PollWidget> {
  bool hasVoted = false;
  List<int> _votes = [];
  int? choice;
  int totalVotes = 0;
  int prevChoice = 0;

  @override
  initState() {
    super.initState();
    for (int i in widget.post.votes) {
      totalVotes += i;
    }
    _votes = widget.post.votes;
  }

  Widget _poll(int index) {
    final double width = UIConstants.getPostWidth(context);
    final double height =
        ((width * .8) * (3 / 4) / widget.post.votes.length) * .5;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
            padding: MaterialStateProperty.all(hasVoted
                ? EdgeInsets.zero
                : EdgeInsets.symmetric(vertical: (height) / 2)),
            backgroundColor:
                MaterialStateProperty.all(Color.fromRGBO(244, 226, 198, 1)),
            alignment: !hasVoted ? Alignment.center : Alignment.centerLeft,
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                side: BorderSide(color: Color.fromRGBO(94, 119, 3, 1)),
                borderRadius:
                    BorderRadius.circular(UIConstants.borderRadius)))),
        onPressed: () {
          setState(() {
            if (index == choice) {
              totalVotes -= 1;
              _votes[index] -= 1;
              choice = null;
              hasVoted = false;
              return;
            }
            if (choice != null) {
              prevChoice = choice!;
            }
            choice = index;
            if (!hasVoted) {
              totalVotes += 1;
              _votes[index] += 1;
            }
            if (hasVoted) {
              _votes[prevChoice] -= 1;
              _votes[index] += 1;
            }
            hasVoted = true;
          });
        },
        child: !hasVoted
            ? Center(
                child: Text(widget.post.options[index],
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(94, 119, 3, 1))))
            : Stack(
                children: [
                  AnimatedContainer(
                    padding: EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(UIConstants.borderRadius),
                        color: index == choice
                            ? Color.fromRGBO(94, 119, 3, 1)
                            : Color.fromRGBO(94, 119, 3, 1).withOpacity(.5)),
                    curve: Curves.easeIn,
                    height: height,
                    duration: const Duration(milliseconds: 250),
                    width: width * _votes[index] / totalVotes,
                  ),
                ],
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
            color: Color.fromRGBO(224, 205, 178, 1),
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
                                  color: Color.fromRGBO(94, 119, 3, 1))),
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
                                      visible: hasVoted,
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
                                                    color: Color.fromRGBO(
                                                        94, 119, 3, 1)))),
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
                      manager: false,
                      advisor: false,
                      loggedIn: true,
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
                      Icons.attachment,
                      color: Color.fromRGBO(94, 119, 3, 1),
                    ),
                  ],
                  onIconTaps: [
                    () {}
                  ]),
            )
          ],
        ));
  }
}
