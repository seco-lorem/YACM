import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yacm/controllers/hive_manager/managers/user_hive_manager.dart';
import 'package:yacm/models/message/message.dart';
import 'package:yacm/models/user/user.dart';

class UserManager extends ChangeNotifier {
  User? _user;
  User? get user => _user;
  // ignore: unused_field
  late UserHiveManager _userHiveManager;

  UserManager(this._userHiveManager);

  Future<int> signIn(String email, String password) async {
    throw UnimplementedError();
  }

  Future<bool> signUp(String email, String password, User user) async {
    throw UnimplementedError();
  }

  Future<bool> signOut() async {
    throw UnimplementedError();
  }

  Future<User> update(Map<String, dynamic> data) async {
    throw UnimplementedError();
  }

  Future<bool> enrollToEvent(String eventID) async {
    throw UnimplementedError();
  }

  Future<bool> deleteNotification(String notificationID) async {
    throw UnimplementedError();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getNotifications() {
    throw UnimplementedError();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getSubbedPosts() {
    throw UnimplementedError();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getSuggestedClubs() {
    throw UnimplementedError();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getPinnedPosts() {
    throw UnimplementedError();
  }

  Future<bool> sendMessageToClub(String clubID, Message message) async {
    throw UnimplementedError();
  }

  Future<bool> sendMessageToPost(String postID, Message message) async {
    throw UnimplementedError();
  }

  Future<bool> enrollToClub(String clubID) async {
    throw UnimplementedError();
  }

  Future<bool> leaveClub(String clubID) async {
    throw UnimplementedError();
  }
}
