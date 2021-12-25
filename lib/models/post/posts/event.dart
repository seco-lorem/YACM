import 'package:cloud_firestore/cloud_firestore.dart';

import '../post.dart';

class Event implements Post {
  late String _author;
  late String _clubID;
  late bool _commentsOn;
  late String _message;
  late DateTime _publishDate;
  late DateTime _beginDate;
  late DateTime _endDate;
  late PostType _type = PostType.EVENT;
  late List<String> _images;
  late List<List<String>> _prerequisites;
  late String _id;

  String get author => _author;
  String get clubID => _clubID;
  String get message => _message;
  bool get commentsOn => _commentsOn;
  DateTime get publishDate => _publishDate;
  DateTime get beginDate => _beginDate;
  DateTime get endDAte => _endDate;
  List<String> get images => _images;
  List<List<String>> get prerequisites => _prerequisites;
  PostType get type => _type;
  String get id => _id;

  Event(
      this._author,
      this._clubID,
      this._commentsOn,
      this._message,
      this._publishDate,
      this._images,
      this._beginDate,
      this._endDate,
      this._prerequisites,
      this._id);

  Event.fromDocumentSnapshot(DocumentSnapshot data) {
    _author = data.get("author");
    _clubID = data.get("clubID");
    _commentsOn = data.get("commentsOn");
    _message = data.get("message");
    _publishDate = data.get("publishDate");
    _images = data.get("images");
    _beginDate = data.get("beginDate");
    _endDate = data.get("endDate");
    _prerequisites = data.get("prerequisites") as List<List<String>>;
    _id = data.get("id");
  }

  Map<String, dynamic> toMap() {
    return {
      "author": _author,
      "clubID": _clubID,
      "message": _message,
      "commentsOn": _commentsOn,
      "publishDate": _publishDate,
      "beginDate": _beginDate,
      "endDate": _endDate,
      "images": _images,
      "prerequisites": _prerequisites,
      "type": _type,
      "id": _id
    };
  }
}
