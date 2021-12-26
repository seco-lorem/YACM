import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yacm/models/post/post.dart';

class Poll implements Post {
  late String _clubName;
  late String _clubID;
  late bool _commentsOn;
  late String _message;
  late DateTime _publishDate;
  late List<String> _options;
  late List<int> _votes;
  late String _question;
  late PostType _type = PostType.POLL;
  late String _id;

  String get clubName => _clubName;
  String get clubID => _clubID;
  String get message => _message;
  bool get commentsOn => _commentsOn;
  DateTime get publishDate => _publishDate;
  List<String> get options => _options;
  List<int> get votes => _votes;
  String get question => _question;
  PostType get type => _type;
  String get id => _id;

  Poll(this._clubName, this._clubID, this._commentsOn, this._message,
      this._publishDate, this._options, this._votes, this._question, this._id);

  Poll.fromDocumentSnapshot(DocumentSnapshot data) {
    List<String> tempOptions = [];
    for (String option in data.get("options")) {
      tempOptions.add(option);
    }
    List<int> tempVotes = [];
    for (int vote in data.get("votes")) {
      tempVotes.add(vote);
    }
    _clubName = data.get("clubName");
    _clubID = data.get("clubID");
    _commentsOn = data.get("commentsOn");
    _message = data.get("message");
    _publishDate = DateTime.parse(data.get("publishDate").toDate().toString());
    _options = tempOptions;
    _votes = tempVotes;
    _question = data.get("question");
    _id = data.get("id");
  }

  Map<String, dynamic> toMap() {
    return {
      "author": _clubName,
      "clubID": _clubID,
      "message": _message,
      "commentsOn": _commentsOn,
      "publishDate": _publishDate,
      "options": _options,
      "question": _question,
      "votes": _votes,
      "type": _type,
      "id": _id
    };
  }
}
