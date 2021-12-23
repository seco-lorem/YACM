import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

  Future<bool> deletePost(String id) async {
    return await _firebaseManager.deletePost(id);
  }

  Future<bool> publishPost(Post post) async {
    return await _firebaseManager.publishPost(post);
  }

  Future<bool> commentPost(String id, Message message) async {
    return await _messageManager.sendToPost(message, id);
  }

  Future<List<QuerySnapshot>> checkOverlap(DateTime begin, DateTime end) async {
    return await _firebaseManager.checkOverlap(begin, end);
  }
}
