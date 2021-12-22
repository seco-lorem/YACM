import 'package:flutter/material.dart';
import 'package:yacm/models/message/message.dart';

class ClubProfileMessages extends StatelessWidget {
  final List<Message> messages;
  final bool isAdmin;
  const ClubProfileMessages(
      {Key? key, required this.isAdmin, required this.messages})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 340 > 200
          ? MediaQuery.of(context).size.height - 340
          : 200,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              messages[index].senderName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(messages[index].message),
            trailing: Visibility(
              visible: isAdmin,
              child: InkWell(
                onTap: () {},
                child: Text(
                  "Mute",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
