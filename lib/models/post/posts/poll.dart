import 'package:yacm/models/post/post.dart';

class Poll implements Post {
  final String _author;
  final String _club;
  final bool _commentsOn;
  final String _message;
  final DateTime _publishDate;
  final List<String> _options;
  final List<int> _votes;
  final String _question;
  final PostType _type = PostType.POLL;
  final String _id;

  String get author => _author;
  String get club => _club;
  String get message => _message;
  bool get commentsOn => _commentsOn;
  DateTime get publishDate => _publishDate;
  List<String> get options => _options;
  List<int> get votes => _votes;
  String get question => _question;
  PostType get type => _type;
  String get id => _id;

  Poll(this._author, this._club, this._commentsOn, this._message,
      this._publishDate, this._options, this._votes, this._question, this._id);
}
