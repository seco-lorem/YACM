import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:universal_io/io.dart';
import 'package:yacm/controllers/firebase_manager/firebase_manager.dart';
import 'package:yacm/controllers/message_manager/message_manager.dart';
import 'package:yacm/models/message/message.dart';
import 'package:yacm/models/post/post.dart';

class PostManager extends ChangeNotifier {
  late MessageManager _messageManager;
  late FirebaseManager _firebaseManager;

  PostManager(this._firebaseManager, this._messageManager);

  Future<bool> vetoPost(String id) async {
    return await _firebaseManager.vetoPost(id);
  }

  Future<bool> votePost(String postID, int index) async {
    return await _firebaseManager.vote(postID, index);
  }

  Future<bool> deletePost(String id) async {
    return await _firebaseManager.deletePost(id);
  }

  Future<bool> commentPost(String id, Message message) async {
    return await _messageManager.sendToPost(message, id);
  }

  Future<List<QuerySnapshot>> checkOverlap(DateTime begin, DateTime end) async {
    return await _firebaseManager.checkOverlap(begin, end);
  }

  Stream<DocumentSnapshot> getPostStream(String postID) {
    return _firebaseManager.getPostStream(postID: postID);
  }

  Future<bool> createEventPost(
      Map<String, dynamic> data, List<File?> photos) async {
    return _firebaseManager.createEventPost(postData: data, photos: photos);
  }

  Future<bool> createPollPost(Map<String, dynamic> data) async {
    return await _firebaseManager.createPollPost(pollPostData: data);
  }

  Future<bool> pinPost(String postID) async {
    return await _firebaseManager.pinPost(postId: postID);
  }

  Future<bool> attendPost(String postID, String name) async {
    return await _firebaseManager.attendPost(postId: postID, name: name);
  }

  Future<bool> subToClub(String clubID, String name) async {
    return await _firebaseManager.subToClub(clubID, name);
  }
}
