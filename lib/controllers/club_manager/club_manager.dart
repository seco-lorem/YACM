import 'dart:io';
import 'package:yacm/controllers/firebase_manager/firebase_manager.dart';
import 'package:yacm/controllers/message_manager/message_manager.dart';
import 'package:yacm/controllers/post_manager/post_manager.dart';
import 'package:yacm/models/message/message.dart';
import 'package:yacm/models/post/post.dart';

class ClubManager {
  late PostManager _postManager;
  late MessageManager _messageManager;
  late FirebaseManager _firebaseManager;

  ClubManager(this._firebaseManager, this._messageManager, this._postManager);

  Future<bool> publishPost(Post post) async {
    throw UnimplementedError();
  }

  Future<String> startEvent() async {
    throw UnimplementedError();
  }

  Future<bool> finishEvent() async {
    throw UnimplementedError();
  }

  Future<bool> muteUser(String clubID, String userID) async {
    throw UnimplementedError();
  }

  Future<bool> unmuteUser(String clubID, String userID) async {
    throw UnimplementedError();
  }

  Future<bool> kickUser(String clubID, String userID) async {
    throw UnimplementedError();
  }

  Future<bool> updateEnrollable(bool enrollable) async {
    throw UnimplementedError();
  }

  Future<bool> updateClubPhoto(File photo, String clubID) async {
    throw UnimplementedError();
  }

  Future<bool> vetoPost(String postID) async {
    throw UnimplementedError();
  }

  Future<bool> deletePost(String postID) async {
    throw UnimplementedError();
  }

  Future<bool> sendMessage(Message message, String clubID) async {
    throw UnimplementedError();
  }

  Future<bool> enrollToClub(String clubID) async {
    throw UnimplementedError();
  }

  Future<bool> leaveClub(String clubID) async {
    throw UnimplementedError();
  }
}
