class User {
  late String _id;
  late String _mail;
  late String _photoURL;
  late List<String> _pinnedPosts;
  late List<String> _events;
  late List<String> _clubs;
  late List<String> _interests;

  String get id => _id;
  String get mail => _mail;
  String get photoURL => _photoURL;
  List<String> get pinnedPosts => _pinnedPosts;
  List<String> get events => _events;
  List<String> get clubs => _clubs;
  List<String> get interests => _interests;

  User(this._id, this._mail, this._photoURL, this._pinnedPosts, this._events,
      this._clubs, this._interests);
}
