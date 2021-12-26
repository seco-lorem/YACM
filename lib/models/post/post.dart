enum PostType { EVENT, POLL }

abstract class Post {
  late String _clubName;
  late String _clubID;
  late String _message;
  late DateTime _publishDate;
  late bool _commentsOn;
  late PostType _type;
  late String _id;

  String get clubName => _clubName;
  String get clubID => _clubID;
  String get message => _message;
  DateTime get publishDate => _publishDate;
  bool get commentsOn => _commentsOn;
  PostType get type => _type;
  String get id => _id;

  Map<String, dynamic> toMap();
}
