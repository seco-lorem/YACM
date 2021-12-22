import '../post.dart';

class Event implements Post {
  final String _author;
  final String _club;
  final bool _commentsOn;
  final String _message;
  final DateTime _publishDate;
  final DateTime _beginDate;
  final DateTime _endDate;
  final PostType _type = PostType.EVENT;
  final List<String> _images;
  final List<List<String>> _prerequisites;
  final String _id;

  String get author => _author;
  String get club => _club;
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
      this._club,
      this._commentsOn,
      this._message,
      this._publishDate,
      this._images,
      this._beginDate,
      this._endDate,
      this._prerequisites,
      this._id);
}
