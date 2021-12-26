import 'package:cloud_firestore/cloud_firestore.dart';

import '../post.dart';

class Event implements Post {
  late String _clubName;
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

  String get clubName => _clubName;
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
      this._clubName,
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
    List<List<String>> _pre = [];
    List<String> _tempImages = [];
    for (String image in data.get("images")) {
      _tempImages.add(image);
    }
    _clubName = data.get("clubName");
    _clubID = data.get("clubID");
    _commentsOn = data.get("commentsOn");
    _message = data.get("message");
    _publishDate = DateTime.parse(data.get("publishDate").toDate().toString());
    _images = _tempImages;
    _beginDate = DateTime.parse(data.get("beginDate").toDate().toString());
    _endDate = DateTime.parse(data.get("endDate").toDate().toString());
    _prerequisites = _pre;
    _id = data.get("id");
  }

  Map<String, dynamic> toMap() {
    return {
      "author": _clubName,
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
