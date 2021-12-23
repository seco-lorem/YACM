import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:universal_io/io.dart';
import 'package:yacm/models/club/club.dart';
import 'package:yacm/models/message/message.dart';
import 'package:yacm/models/post/post.dart';

/// Methods:
///    Related to clubs: getClub, getClubMemberCount
///    Related to users:
///
class FirebaseManager {
  static FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  static FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  String getUserID() {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  /// Returns a map that can be accessed like json format
  /// Example:
  ///      var manager = await FirebaseManager.getInstance();
  ///      var json = await manager.getClub('ACM');
  ///       print(json['clubInfo']['memberCount']);
  Future<DocumentSnapshot<Map<String, dynamic>>> getClub(
      String clubName) async {
    return await FirebaseFirestore.instance
        .collection('clubs')
        .doc(clubName)
        .get();
  }

  ///  try {
  ///      manager.registerUser(email: 'enis.ozer@ug.bilkent.edu.tr', password: '123456');
  ///    );
  ///  } on FirebaseAuthException catch (e) {
  ///    if (e.code == 'user-not-found') {
  ///      print('No user found for that email.');
  ///    } else if (e.code == 'wrong-password') {
  ///      print('Wrong password provided for that user.');
  ///    }
  ///  }
  Future<bool> registerUser(
      {required String email,
      required String password,
      required List<String> interests,
      required File photo}) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    User? user = userCredential.user;

    String? photoURL;

    await _firebaseStorage
        .ref('userPhotos/${user!.uid}.png')
        .putFile(photo)
        .then((data) async {
      photoURL = await data.ref.getDownloadURL();
    });

    Map<String, dynamic> userData = {
      "id": user.uid,
      "mail": email,
      "photoURL": photoURL ?? "",
      "pinnedPosts": [],
      "events": [],
      "clubs": [],
      "interests": interests
    };

    await createUserInFirestore(userData);

    // send the verification mail
    if (!user.emailVerified) {
      await user.sendEmailVerification();
    }
    return true;
  }

  /// CollectionReference posts = FirebaseFirestore.instance.collection('posts');
  ///
  ///  await posts
  ///    .doc(clubName)
  ///    .collection('clubPosts')
  ///    .add({'postInfo': postData})
  Future<bool> createUserInFirestore(Map<String, dynamic> userData) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userData['uid'])
          .set(userData);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  ///
  /// try {
  ///   manager.signIn(email: 'enis.ozer@ug.bilkent.edu.tr', password: '123456')
  ///    } on FirebaseAuthException catch (e) {
  ///  if (e.code == 'user-not-found') {
  ///    print('No user found for that email.');
  ///  } else if (e.code == 'wrong-password') {
  ///    print('Wrong password provided for that user.');
  ///  }
  ///}
  Future<bool> signIn({String? email, String? password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);
    } on FirebaseAuthException catch (error) {
      print(error.toString());
      return false;
    }
    return true;
  }

  /// signs out current authenticated user
  /// FirebaseManager manager = await FirebaseManager.getInstance();
  /// manager.signOut();
  Future<bool> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (error) {
      return false;
    }
    return true;
  }

  /// manager.createPost(clubName: 'ACM', postData: {
  ///  'postType:': 'poll',
  ///  'postMessage': 'test',
  ///  'beginDate': '2.12.2021',
  ///  'endDate': '8.12.2021',
  ///  'publishDate': '2.12.2021',
  ///  'commentsOn': false,
  ///  'commentsId': 'no',
  /// },
  /// files: [
  /// File(""),
  /// File(""),
  /// ]);
  // should return boolean
  Future<bool> createEventPost(
      {required Map<String, dynamic> postData,
      required List<File> photos}) async {
    postData['postType'] = 'event';
    // Add post to posts collection
    String? postId = await createPostInFirestore(postData);

    // Add post photos to storage
    List<String> _urls =
        await _addPostPhotosToStorage(postId!, postData["clubName"], photos);

    await FirebaseFirestore.instance
        .collection("posts")
        .doc(postId)
        .update({"photos": _urls});

    return true;
  }

  /// Return a document snapshot containing post metadata
  /// club name is not required
  /// var json = await manager.getPost(clubName:'ACM',
  ///     postId: 'd55cD092RflhpUpn15nF');
  Future<DocumentSnapshot<Map<String, dynamic>>> getPost(
      {required String postId}) async {
    return await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .get();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getPosts() {
    return FirebaseFirestore.instance.collection('posts').snapshots();
  }

  /// Returns the document id which will be used as post id
  Future<String?> createPostInFirestore(Map<String, dynamic> postData) async {
    String postId = "";

    await FirebaseFirestore.instance
        .collection('posts')
        .add(postData)
        .then((value) => (postId = value.id));
    return postId;
  }

  ///  This must the be tested with the real application
  ///  Can't read files directly from OS
  Future<List<String>> _addPostPhotosToStorage(
      String postId, String clubName, List<File> files) async {
    String basePath = "postPhotos/$clubName/$postId";
    List<String> _photoURLs = [];

    for (var i = 0; i < files.length; i++) {
      String destination = basePath + "photo" + i.toString();
      await FirebaseStorage.instance
          .ref(destination)
          .putFile(files[i])
          .then((data) async {
        String url = await data.ref.getDownloadURL();
        _photoURLs.add(url);
      });
    }
    return _photoURLs;
  }

  Future<bool> createPollPost(
      {String? clubName, Map<String, dynamic>? pollPostData}) async {
    try {
      pollPostData!['clubName'] = clubName;
      pollPostData['postType'] = 'poll';
      pollPostData['voterUIDs'] = [];

      await FirebaseFirestore.instance.collection('posts').add(pollPostData);
    } catch (e) {
      return false;
    }

    return true;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData(String id) async {
    return await FirebaseFirestore.instance.collection("users").doc(id).get();
  }

  /// Writes the given message to the given post with [postId]
  Future<bool> sendCommentToPost(
      {required String postId, required Message message}) async {
    try {
      CollectionReference posts = _firebaseFirestore.collection('postComments');

      await posts.doc(postId).collection("comments").add(message.toMap());
    } catch (e) {
      print(e.toString());
      return false;
    }
    return true;
  }

  /// enrols current user to event
  /// user must be signed in
  Future<bool> enrollToEvent({String? eventId}) async {
    try {
      // check whether the user is signed in or not
      if (_firebaseAuth.currentUser == null) return false;
      String? uid = _firebaseAuth.currentUser?.uid;
      var tmp = [uid];
      await _firebaseFirestore
          .collection('events')
          .doc(eventId)
          .update({"participants": FieldValue.arrayUnion(tmp)});
    } catch (e) {
      print(e.toString());
      return false;
    }
    return true;
  }

  /// user must be signed in otherwise
  /// a false will be returned
  Future<bool> enrollToClub({String? clubId}) async {
    try {
      // check whether the user is signed in or not
      if (_firebaseAuth.currentUser == null) return false;

      String? uid = _firebaseAuth.currentUser!.uid;

      // add user id to clubs members array
      var tmp1 = [uid];
      await _firebaseFirestore
          .collection('clubs')
          .doc(clubId)
          .update({"members": FieldValue.arrayUnion(tmp1)});
    } catch (e) {
      print(e.toString());
      return false;
    }
    return true;
  }

  /// user must be signed in otherwise
  /// a false will be returned
  Future<bool> leaveClub({String? clubId}) async {
    try {
      // check whether the user is signed in or not
      if (_firebaseAuth.currentUser == null) return false;

      String? uid = _firebaseAuth.currentUser!.uid;

      // delete user id from clubs members array
      var tmp1 = [uid];
      await _firebaseFirestore
          .collection('clubs')
          .doc(clubId)
          .update({"members": FieldValue.arrayRemove(tmp1)});
    } catch (e) {
      print(e.toString());
      return false;
    }
    return true;
  }

  /// new photo should not be null
  Future<bool> updateClubPhoto(
      {String? clubName, String? clubId, File? newPhoto}) async {
    try {
      await _firebaseStorage
          .ref('clubProfilePhotos/${clubName}.png')
          .putFile(newPhoto!)
          .then((p0) async {
        String tmp = await p0.ref.getDownloadURL();
        await _firebaseFirestore
            .collection('clubs')
            .doc(clubId)
            .update({'photoURL': tmp});
      });
    } catch (e) {
      print(e.toString());
      return false;
    }

    return true;
  }

  Future<bool> sendMessageToClubChat(
      {required Message message, required String clubId}) async {
    try {
      // check whether the user is signed in or not
      if (_firebaseAuth.currentUser == null) return false;

      _firebaseFirestore
          .collection("clubChats")
          .doc(clubId)
          .collection("messages")
          .add(message.toMap());
    } catch (e) {
      print(e.toString());
      return false;
    }
    return true;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? getClubChatMessages(
      {required String clubId}) {
    try {
      return _firebaseFirestore
          .collection('clubChats')
          .doc(clubId)
          .collection('messages')
          .snapshots();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>?> getEventPolls(
      {String? eventPostId}) async {
    try {
      return _firebaseFirestore
          .collection('eventPolls')
          .doc(eventPostId)
          .collection('polls')
          .snapshots();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>?> getEventMessages(
      {String? eventPostId}) async {
    try {
      return _firebaseFirestore
          .collection('eventMessages')
          .doc(eventPostId)
          .collection('messages')
          .snapshots();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> createEventMessage(
      {String? eventPostId, Map<String, dynamic>? messageData}) async {
    try {
      _firebaseFirestore
          .collection('eventMessages')
          .doc(eventPostId)
          .set(messageData!);
    } catch (e) {
      print(e.toString());
      return false;
    }

    return true;
  }

  Future<bool> createEventPoll(
      {String? eventPostId, Map<String, dynamic>? pollData}) async {
    try {
      _firebaseFirestore
          .collection('eventPolls')
          .doc(eventPostId)
          .set(pollData!);
    } catch (e) {
      print(e.toString());
      return false;
    }

    return true;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? getAllClubs() {
    try {
      return _firebaseFirestore.collection('clubs').snapshots();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  /// user must be logged in to pin a post
  /// otherwise a false is returned with no thrown exception
  Future<bool> pinPost({String? postId}) async {
    try {
      if (_firebaseAuth.currentUser == null) return false;

      String? uid = _firebaseAuth.currentUser?.uid;

      await _firebaseFirestore.collection('posts').doc(postId).update({
        "userPinned": FieldValue.arrayUnion([uid])
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  /// returns a list of post ids
  /// returns the users pinned posts as a list
  /// user must be logged in to pin a post
  /// otherwise a false is returned with no thrown exception
  Stream<QuerySnapshot<Map<String, dynamic>>>? getPinnedPosts() {
    try {
      List<String>? rtn;
      if (_firebaseAuth.currentUser == null) return null;

      String? uid = _firebaseAuth.currentUser?.uid;
      return _firebaseFirestore
          .collection('posts')
          .where("userPinned", arrayContains: uid)
          .snapshots();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  /// returns a list of posts
  Stream<QuerySnapshot<Map<String, dynamic>>>? getSubbedPosts() {
    try {
      if (_firebaseAuth.currentUser == null) return null;

      String? uid = _firebaseAuth.currentUser?.uid;

      return _firebaseFirestore
          .collection('posts')
          .where("members", arrayContains: uid)
          .snapshots();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  /// returns a list of suggested clubs
  Future<List<Club>> getSuggestedClubs() async {
    List<Club> clubs = [];
    try {
      await _firebaseFirestore
          .collection("users")
          .doc(_firebaseAuth.currentUser!.uid)
          .get()
          .then((value) {
        Future.forEach(value.data()!["suggestedClubs"], (String id) async {
          DocumentSnapshot<Map<String, dynamic>> club = await getClub(id);

          clubs.add(Club(
              club["id"],
              club["advisor"],
              club["clubPhoto"],
              club["enrollabe"],
              club["managers"],
              club["members"],
              club["mutedMembers"]));
        });
      });

      return clubs;
    } catch (e) {
      print(e.toString());
      return clubs as Future<List<Club>>;
    }
  }

  /// starts an event to the given [club]
  Future<bool> startEvent(Club club) async {
    try {
      await _firebaseFirestore.collection("events").add({
        "clubID": club.id,
        "participants": [],
        "managers": club.managers,
        "active": true
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> finishEvent(String id) async {
    try {
      await _firebaseFirestore
          .collection("events")
          .doc(id)
          .update({"active": false});

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> muteUser(String clubID, String userID) async {
    try {
      await _firebaseFirestore.collection("clubs").doc(clubID).update({
        "mutedUsers": FieldValue.arrayUnion([userID])
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> unmuteUser(String clubID, String userID) async {
    try {
      await _firebaseFirestore.collection("clubs").doc(clubID).update({
        "mutedUsers": FieldValue.arrayRemove([userID])
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateEnrollable(String clubID, bool enrollable) async {
    try {
      await _firebaseFirestore
          .collection("clubs")
          .doc(clubID)
          .update({"enrollable": enrollable});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> vetoPost(String postID) async {
    try {
      await _firebaseFirestore.collection("posts").doc(postID).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deletePost(String postID) async {
    try {
      await _firebaseFirestore.collection("posts").doc(postID).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> publishPost(Post post) async {
    try {
      await _firebaseFirestore.collection("posts").add(post.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<QuerySnapshot>> checkOverlap(DateTime begin, DateTime end) async {
    try {
      return await _firebaseFirestore
          .collection("posts")
          .startAfter([begin])
          .endAt([end])
          .orderBy("beginDate")
          .orderBy("endDate")
          .snapshots()
          .toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> updateUserData(Map<String, dynamic> data) async {
    try {
      await _firebaseFirestore
          .collection("users")
          .doc(_firebaseAuth.currentUser!.uid)
          .update(data);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteNotification(String notificationID) async {
    try {
      await _firebaseFirestore
          .collection("notifications")
          .doc(notificationID)
          .delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getNotifications() {
    return _firebaseFirestore
        .collection("notifications")
        .where("userID", isEqualTo: _firebaseAuth.currentUser!.uid)
        .snapshots();
  }
}
