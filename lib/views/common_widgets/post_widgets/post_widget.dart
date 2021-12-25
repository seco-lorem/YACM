import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:yacm/models/message/message.dart';
import 'package:yacm/models/theme/own_theme_fields.dart';
import 'package:yacm/views/common_widgets/post_widgets/comment_widget.dart';

import '../../../models/language/language.dart';
import '../../../models/post/post.dart';
import '../../../util/ui_constants.dart';

class PostWidget extends StatelessWidget {
  final Language language;
  final Post post;
  final List<Icon> icons;
  final List<VoidCallback> onIconTaps;
  final List<Message> comments;
  const PostWidget(
      {Key? key,
      required this.language,
      required this.post,
      required this.icons,
      required this.onIconTaps,
      required this.comments})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = UIConstants.getPostWidth(context);
    return Container(
      width: width,
      height: width * .1,
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 0,
                          color: Theme.of(context).own().postWidgetDivider))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SizedBox(
                      height: (width * .8 * 7) / 40,
                      width: width * .7 - 16,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(
                                        context, "/club?id=${post.clubID}");
                                  },
                                text: post.clubID + " ",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: post.message,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.grey[600]))
                          ]),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: SizedBox(
                      height: (width * .8 * 7) / 40,
                      width: width * .3 - 16,
                      child: ListView.builder(
                        controller: ScrollController(),
                        reverse: true,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: icons.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                                onPressed: onIconTaps[index],
                                icon: icons[index]),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return CommentWidget(
                    imageURL: comments[index].senderPhotoURL,
                    name: comments[index].senderName,
                    comment: comments[index].message,
                    sentDate: comments[index].sentDate);
              },
            ),
          )
        ],
      ),
    );
  }
}
