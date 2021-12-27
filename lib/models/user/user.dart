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
  @HiveField(7)
  late String _name;

  String get id => _id;
  String get mail => _mail;
  String get photoURL => _photoURL;
  String get name => this._name;
  List<String> get pinnedPosts => _pinnedPosts;
  List<String> get events => _events;
  List<String> get clubs => _clubs;
  List<String> get interests => _interests;

  User(this._id, this._mail, this._photoURL, this._pinnedPosts, this._events,
      this._clubs, this._interests, this._name);

  User.fromMap(Map<String, dynamic> data) {
    List<String> posts = [];
    for (var data in data["pinnedPosts"]) {
      posts.add(data);
    }
    List<String> events = [];
    for (var data in data["events"]) {
      events.add(data);
    }
    List<String> clubs = [];
    for (var data in data["clubs"]) {
      clubs.add(data);
    }
    List<String> interests = [];
    for (var data in data["interests"]) {
      interests.add(data);
    }
    _name = data["name"];
    _id = data["id"];
    _mail = data["mail"];
    _photoURL = data["photoURL"];
    _pinnedPosts = posts;
    _events = events;
    _clubs = clubs;
    _interests = interests;
  }

  User.fromUser(User other) {
    _id = other.id;
    _mail = other.mail;
    _photoURL = other.photoURL;
    _pinnedPosts = other.pinnedPosts;
    _events = other.events;
    _clubs = other.clubs;
    _interests = other.interests;
    _name = other.name;
  }

  void update(Map<String, dynamic> data) {
    for (String key in data.keys) {
      print(key);
      switch (key) {
        case "id":
          _id = data["id"];
          break;
        case "mail":
          _mail = data["mail"];
          break;
        case "photoURL":
          _photoURL = data["photoURL"];
          break;
        case "pinnedPosts":
          _pinnedPosts = data["pinnedPosts"] as List<String>;
          break;
        case "events":
          _events = data["events"] as List<String>;
          break;
        case "clubs":
          _clubs = data["clubs"] as List<String>;
          break;
        case "interests":
          _interests = data["interests"] as List<String>;
          break;
        case "name":
          _name = data["name"];
          break;
      }
    }
  }
}
