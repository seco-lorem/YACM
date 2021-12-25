import 'package:yacm/controllers/firebase_manager/firebase_manager.dart';
import 'package:yacm/models/message/message.dart';

class MessageManager {
  late FirebaseManager _firebaseManager;
  MessageManager(this._firebaseManager);

  Future<bool> sendToClub(Message message, String clubID) async {
    return await _firebaseManager.sendMessageToClubChat(
        message: message, clubId: clubID);
  }

  Future<bool> sendToPost(Message message, String postID) async {
    return await _firebaseManager.sendCommentToPost(
        postId: postID, message: message);
  }
}
