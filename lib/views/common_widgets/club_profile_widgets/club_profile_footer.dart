import 'package:flutter/material.dart';
import 'package:yacm/models/theme/own_theme_fields.dart';
import 'package:yacm/util/ui_constants.dart';

/// This is a stateful widget that implements the
/// sendind message functionality for club profile page
class ClubProfileSendMessage extends StatefulWidget {
  const ClubProfileSendMessage({
    Key? key,
  }) : super(key: key);

  @override
  State<ClubProfileSendMessage> createState() => _ClubProfileSendMessageState();
}

class _ClubProfileSendMessageState extends State<ClubProfileSendMessage> {
  final TextEditingController _textEditingController = TextEditingController();
  bool _writing = false;

  @override
  dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(
          left: 8,
          right: 8,
          top: 8,
          bottom: MediaQuery.of(context).padding.bottom + 8),
      decoration: BoxDecoration(
        border: Border(
            top: BorderSide(
          color: Colors.transparent.withOpacity(.1),
        )),
      ),
      child: Row(
        children: [
          Visibility(
            visible: !_writing,
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.add,
                color: Theme.of(context).own().clubProfileFooterAdd,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 8, right: 8),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).own().clubProfileFooterAdd),
                  borderRadius:
                      BorderRadius.circular(UIConstants.borderRadius)),
              alignment: Alignment.topLeft,
              child: TextField(
                textAlign: TextAlign.justify,
                controller: _textEditingController,
                onChanged: (text) {
                  setState(() {
                    if (text.isNotEmpty) {
                      _writing = true;
                    } else {
                      _writing = false;
                    }
                  });
                },
                style: TextStyle(color: Colors.grey[600], fontSize: 16),
                cursorColor: Colors.grey[600],
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
          ),
          Visibility(
            visible: _writing,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: InkWell(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Theme.of(context).own().clubProfileFooterAdd)),
                  padding: EdgeInsets.all(8),
                  child: Center(
                    child: Icon(
                      Icons.send,
                      color: Theme.of(context).own().clubProfileFooterAdd,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}