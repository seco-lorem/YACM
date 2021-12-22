import 'package:firebase/firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  late String _id;
  @HiveField(1)
  late String _mail;
  @HiveField(2)
  late String _photoURL;
  @HiveField(3)
  late List<String> _pinnedPosts;
  @HiveField(4)
  late List<String> _events;
  @HiveField(5)
  late List<String> _clubs;
  @HiveField(6)
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

  User.fromMap(Map<String, dynamic> data) {
    _id = data["id"];
    _mail = data["mail"];
    _photoURL = data["photoURL"];
    _pinnedPosts = data["pinnedPosts"] as List<String>;
    _events = data["events"] as List<String>;
    _clubs = data["clubs"] as List<String>;
    _interests = data["interests"] as List<String>;
  }
}
