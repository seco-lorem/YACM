import 'package:flutter/material.dart';
import 'package:yacm/models/theme/own_theme_fields.dart';

class CommentWidget extends StatelessWidget {
  final String imageURL;
  final String name;
  final String comment;
  final String sentDate;
  const CommentWidget(
      {Key? key,
      required this.imageURL,
      required this.name,
      required this.comment,
      required this.sentDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageURL),
      ),
      trailing: Text(
        sentDate.substring(11, 16),
        textAlign: TextAlign.right,
        style: TextStyle(
            color: Theme.of(context).own().commentWidgetDate, fontSize: 16),
      ),
      title: Text(
        name,
        style: TextStyle(
            color: Theme.of(context).own().commentWidgetName, fontSize: 16),
      ),
      subtitle: Text(
        comment,
        style: TextStyle(
            color: Theme.of(context).own().commentWidgetComment, fontSize: 14),
      ),
    );
  }
}
