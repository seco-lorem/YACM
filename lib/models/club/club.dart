class Club {
  late String _id;
  late String _advisor;
  late String _clubPhoto;
  late String _clubName;
  late bool _enrollable;
  late List<String> _members;
  late List<String> _managers;
  late List<String> _mutedMembers;

  String get id => _id;
  String get advisor => _advisor;
  String get clubPhoto => _clubPhoto;
  String get clubName => _clubName;
  bool get enrollable => _enrollable;
  List<String> get members => _members;
  List<String> get managers => _managers;
  List<String> get mutedMembers => _mutedMembers;

  Club(this._id, this._advisor, this._clubPhoto, this._clubName,
      this._enrollable, this._managers, this._members, this._mutedMembers);

  Map<String, dynamic> toMap() {
    return {
      "id": _id,
      "advisor": _advisor,
      "clubPhoto": _clubPhoto,
      "clubName": _clubName,
      "enrollable": _enrollable,
      "members": _members,
      "managers": _managers,
      "mutedMembers": _mutedMembers
    };
  }
}
