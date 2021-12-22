import 'package:flutter/material.dart';

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
        style: TextStyle(color: Color.fromRGBO(94, 119, 3, 1), fontSize: 16),
      ),
      title: Text(
        name,
        style: TextStyle(color: Color.fromRGBO(94, 119, 3, 1), fontSize: 16),
      ),
      subtitle: Text(
        comment,
        style: TextStyle(color: Colors.grey[600], fontSize: 14),
      ),
    );
  }
}
