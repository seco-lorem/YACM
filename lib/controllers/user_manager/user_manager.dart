import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:yacm/controllers/firebase_manager/firebase_manager.dart';
import 'package:yacm/controllers/hive_manager/managers/user_hive_manager.dart';
import 'package:yacm/models/user/user.dart';

class UserManager extends ChangeNotifier {
  static const String BOX_NAME = "user_box";
  User? _user;
  bool _loading = false;
  User? get user => _user;
  bool get loading => _loading;
  // ignore: unused_field
  late UserHiveManager _userHiveManager;
  late FirebaseManager _firebaseManager;

  UserManager(this._userHiveManager, this._firebaseManager);

  Future<bool> signIn(String email, String password) async {
    _setLoading(true);
    bool result =
        await _firebaseManager.signIn(email: email, password: password);

    String id = _firebaseManager.getUserID();

    DocumentSnapshot<Map<String, dynamic>> tempData =
        await _firebaseManager.getUserData(id);

    if (result) {
      User tempUser = await _userHiveManager.create(
          BOX_NAME, id, User.fromMap(tempData.data()!));
      _user = tempUser;
      notifyListeners();
      _setLoading(false);
      return true;
    }

    _setLoading(false);
    return false;
  }

  Future<bool> signUp(String email, String password, User user) async {
    throw UnimplementedError();
  }

  Future<bool> signOut() async {
    _setLoading(true);
    await _userHiveManager.delete(BOX_NAME, _user!.id);
    await _firebaseManager.signOut();
    _user = null;
    notifyListeners();
    _setLoading(false);
    return true;
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
    return _firebaseManager.getPosts();
  }

  void _setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }
}
