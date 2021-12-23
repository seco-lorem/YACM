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
    throw UnimplementedError();
  }

  Future<bool> deletePost(String id) async {
    throw UnimplementedError();
  }

  Future<bool> publishPost(Post post) async {
    throw UnimplementedError();
  }

  Future<bool> commentPost(String id, Message message) async {
    throw UnimplementedError();
  }

  Future<List<DocumentSnapshot>> checkOverlap(
      DateTime begin, DateTime end) async {
    throw UnimplementedError();
  }
}
