import 'package:cloud_firestore/cloud_firestore.dart';

class Club {
  late String _id;
  late String _advisor;
  late String _clubPhoto;
  late String _clubName;
  late String _description;
  late bool _enrollable;
  late List<String> _members;
  late List<String> _managers;
  late List<String> _mutedMembers;

  String get id => _id;
  String get advisor => _advisor;
  String get clubPhoto => _clubPhoto;
  String get clubName => _clubName;
  String get description => _description;
  bool get enrollable => _enrollable;
  List<String> get members => _members;
  List<String> get managers => _managers;
  List<String> get mutedMembers => _mutedMembers;

  Club(
      this._id,
      this._advisor,
      this._clubPhoto,
      this._clubName,
      this._enrollable,
      this._managers,
      this._members,
      this._mutedMembers,
      this._description);

  Club.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    List<String> tempManagers = [];
    List<String> tempMutedMembers = [];
    List<String> tempMembers = [];
    for (String data in snapshot.get("managers")) {
      tempManagers.add(data);
    }
    for (String data in snapshot.get("mutedMembers")) {
      tempMutedMembers.add(data);
    }
    for (String data in snapshot.get("members")) {
      tempMembers.add(data);
    }

    _id = snapshot.get("id");
    _advisor = snapshot.get("advisor");
    _clubPhoto = snapshot.get("clubPhoto");
    _clubName = snapshot.get("clubName");
    _enrollable = snapshot.get("enrollable");
    _description = snapshot.get("description");
    _managers = tempManagers;
    _mutedMembers = tempMutedMembers;
    _members = tempMembers;
  }

  Map<String, dynamic> toMap() {
    return {
      "id": _id,
      "advisor": _advisor,
      "clubPhoto": _clubPhoto,
      "clubName": _clubName,
      "enrollable": _enrollable,
      "members": _members,
      "managers": _managers,
      "mutedMembers": _mutedMembers,
      "description": _description
    };
  }
}
