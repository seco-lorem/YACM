import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:universal_io/io.dart';
import 'package:yacm/controllers/firebase_manager/firebase_manager.dart';
import 'package:yacm/controllers/message_manager/message_manager.dart';
import 'package:yacm/controllers/post_manager/post_manager.dart';
import 'package:yacm/models/club/club.dart';
import 'package:yacm/models/message/message.dart';
import 'package:yacm/models/post/post.dart';

class ClubManager extends ChangeNotifier {
  late PostManager _postManager;
  late MessageManager _messageManager;
  late FirebaseManager _firebaseManager;

  ClubManager(this._firebaseManager, this._messageManager, this._postManager);

  Future<bool> createPollPost(Map<String, dynamic> post) async {
    return await _postManager.createPollPost(post);
  }

  Future<bool> createEventPost(
      Map<String, dynamic> post, List<File?> photos) async {
    return await _postManager.createEventPost(post, photos);
  }

  Future<bool> startEvent(Club club) async {
    return _firebaseManager.startEvent(club);
  }

  Future<bool> finishEvent(String id) async {
    return _firebaseManager.finishEvent(id);
  }

  Future<bool> muteUser(String clubID, String userID) async {
    return await _firebaseManager.muteUser(clubID, userID);
  }

  Future<bool> unmuteUser(String clubID, String userID) async {
    return await _firebaseManager.unmuteUser(clubID, userID);
  }

  Future<bool> kickUser(String clubID, String userID) async {
    return await _firebaseManager.muteUser(clubID, userID);
  }

  Future<bool> updateEnrollable(String clubID, bool enrollable) async {
    return await _firebaseManager.updateEnrollable(clubID, enrollable);
  }

  Future<bool> updateClubPhoto(File photo, String clubID) async {
    return await _firebaseManager.updateClubPhoto(
        clubId: clubID, newPhoto: photo);
  }

  Future<bool> vetoPost(String postID) async {
    return await _postManager.vetoPost(postID);
  }

  Future<bool> deletePost(String postID) async {
    return await _postManager.deletePost(postID);
  }

  Future<bool> sendMessage(Message message, String clubID) async {
    return await _messageManager.sendToClub(message, clubID);
  }

  Future<bool> enrollToClub(String clubID) async {
    return await _firebaseManager.enrollToClub(clubId: clubID);
  }

  Future<bool> leaveClub(String clubID) async {
    return await _firebaseManager.leaveClub(clubId: clubID);
  }

  Stream<DocumentSnapshot> getClubStream(String clubID) {
    return _firebaseManager.getClubStream(clubID);
  }

  Stream<QuerySnapshot> getClubPosts(String clubID) {
    return _firebaseManager.getClubPosts(clubID);
  }
}
