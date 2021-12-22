import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart'; /*kullanmak nasip olmadı*/
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

/**
 * Methods:
 *    Related to clubs: getClub, getClubMemberCount
 *    Related to users:   
 *
 */

class FirebaseManager {
  static bool _isInit = false;
  static FirebaseManager instance = new FirebaseManager();

  /**
   * The constructor of a FirebaseManager should never be called
   * An instance can be obtained using getInstance() method
   * Example: FirebaseManager f = await FirebaseManager.getInstance();
   */
  static Future<FirebaseManager> getInstance() async {
    if (!_isInit) {
      await instance._init();
      _isInit = true;
    }
    return Future(() {
      return instance;
    });
  }

  Future<void> _init() async {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
          options: FirebaseOptions(
              apiKey: "AIzaSyBPFKxM9MsxTQGEaQr6Q4G-PTuD4K3GdS8",
              appId: "1:336218459715:web:77d0188c6263488d6e0ef6",
              messagingSenderId: "336218459715",
              storageBucket: "yacm-c626b.appspot.com",
              projectId: "yacm-c626b"));
    }
  }

  /**
   * Returns a map that can be accessed like json format
   * Example: 
   *      var manager = await FirebaseManager.getInstance();
          var json = await manager.getClub('ACM');
          print(json['clubInfo']['memberCount']); 
   */
  Future<DocumentSnapshot<Map<String, dynamic>>> getClub(
      String clubName) async {
    var clubs = await FirebaseFirestore.instance.collection('clubs');
    return clubs.doc(clubName).get();
  }

  /*
    try {
        manager.registerUser(email: 'enis.ozer@ug.bilkent.edu.tr', password: '123456');
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  */
  Future<String> registerUser(
      {String? email, String? password, String userName = ""}) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);

    User? user = userCredential.user;

    // create a user document in the users collection
    Map<String, dynamic> userData = {
      'clubs': [],
      'userName': userName,
      'photoURL': 'URL',
      'pinnedPosts': [],
      'events': [],
      'interests': []
    };

    await createUserInFirestore(user!.uid, userData);

    // send the verification mail
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
    return user.uid;
  }

  /**
   * CollectionReference posts = FirebaseFirestore.instance.collection('posts');

    await posts
        .doc(clubName)
        .collection('clubPosts')
        .add({'postInfo': postData})
   */

  Future<void> createUserInFirestore(
      String uid, Map<String, dynamic> userData) async {
    try {
      print("_createUserInFirestore top");
      print(Firebase.apps);

      Map<String, dynamic> userData2 = userData;
      print("uid: " + uid);

      userData2['uid'] = uid;
      print(userData2);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set(userData2);

      print("_createUserInFirestore bottom");
    } catch (e) {
      print(e.toString());
    }
  }

  /*
    try {
      manager.signIn(email: 'enis.ozer@ug.bilkent.edu.tr', password: '123456')
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  */
  Future<void> signIn({String? email, String? password}) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }

  /**
   * signs out current authenticated user
   * FirebaseManager manager = await FirebaseManager.getInstance();
   * manager.signOut();
  */
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  /**
    manager.createPost(clubName: 'ACM', postData: {
      'postType:': 'poll',
      'postMessage': 'test',
      'beginDate': '2.12.2021',
      'endDate': '8.12.2021',
      'publishDate': '2.12.2021',
      'commentsOn': false,
      'commentsId': 'no',
    }, 
    files: [ 
      File(""), 
      File(""),
    ]);
   */
  Future<bool> createEventPost(
      {String? clubName,
      Map<String, dynamic>? postData,
      List<File>? photos}) async {
    try {
      if (photos == null)
        postData!["numberOfPhotos"] = 0;
      else
        postData!["numberOfPhotos"] = photos.length;

      postData['postType'] = 'event';
      // Add post to posts collection
      String? postId = await _createPostInFirestore(clubName!, postData);

      // Add postId to club's posts field
      var tmp = [postId];
      await FirebaseFirestore.instance
          .collection('clubs')
          .doc(clubName)
          .update({"posts": FieldValue.arrayUnion(tmp)});

      // Add post photos to storage
      if (photos != null && postId != null) {
        await _addPostPhotosToStorage(postId, postData["clubName"], photos);
      }
    } catch (e) {
      return false;
    }

    return true;
  }

  /**
   * Returns a map that can be accessed like json format
   * Example: 
   *      var manager = await FirebaseManager.getInstance();
          var json = await manager.getPost('ACM', 'd55cD092RflhpUpn15nF');
          print(json['postInfo']['postMessage']); 
   */

  /// Return a document snapshot containing post metadata
  /// club name is not required
  /// var json = await manager.getPost(clubName:'ACM',
  ///     postId: 'd55cD092RflhpUpn15nF');
  Future<DocumentSnapshot<Map<String, dynamic>>> getPost(
      {String? clubName, String? postId}) async {
    CollectionReference<Map<String, dynamic>> posts =
        await FirebaseFirestore.instance.collection('posts');
    return posts.doc(postId).get();
  }

  Future<List<QuerySnapshot>> getPosts() async {
    return FirebaseFirestore.instance.collection('posts').snapshots().toList();
  }
/*
  Future<File> getPostPhoto({String? postId, int? photoNumber}) async {
    String path = 
  }*/

  /**
   * Returns the document id which will be used as post id
   */
  Future<String?> _createPostInFirestore(
      String clubName, Map<String, dynamic> postData) async {
    String postId = "";
    postData["clubName"] = clubName;
    CollectionReference posts = FirebaseFirestore.instance.collection('posts');

    await posts.add(postData).then((value) => (postId = value.id));
    return postId;
  }

  /*
    This must the be tested with the real application
    Can't read files directly from OS
  */
  Future<void> _addPostPhotosToStorage(
      String postId, String clubName, List<File> files) async {
    String basePath = "postPhotos/${clubName}/${postId}";

    for (var i = 0; i < files.length; i++) {
      String destination = basePath + "photo" + i.toString();
      await FirebaseStorage.instance.ref(destination).putFile(files[i]);
    }
  }

  Future<bool> createPollPost(
      {String? clubName, Map<String, dynamic>? pollPostData}) async {
    try {
      pollPostData!['clubName'] = clubName;
      pollPostData['postType'] = 'poll';
      pollPostData['voterUIDs'] = [];

      // add to posts collection
      CollectionReference posts =
          FirebaseFirestore.instance.collection('posts');

      String? postId;
      await posts.add(pollPostData).then((value) => postId = value.id);

      // add to clubs posts collection
      var tmp = [postId];
      await FirebaseFirestore.instance
          .collection('clubs')
          .doc(clubName)
          .update({"posts": FieldValue.arrayUnion(tmp)});
    } catch (e) {
      return false;
    }

    return true;
  }

  /// Writes the given commentData to comm
  Future<bool> sendCommentToPost(
      {String? postId, Map<String, dynamic>? commentData}) async {
    try {
      CollectionReference posts =
          FirebaseFirestore.instance.collection('postComments');

      await posts.doc(postId).collection("comments").add(commentData!);
    } catch (e) {
      print(e.toString());
      return false;
    }
    return true;
  }

  /// enrols current user to event
  /// user must be signed in
  Future<bool> enrollToEvent({String? postId}) async {
    try {
      // check whether the user is signed in or not
      if (FirebaseAuth.instance.currentUser == null) return false;

      var tmp = [postId];
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update({"events": FieldValue.arrayUnion(tmp)});
    } catch (e) {
      print(e.toString());
      return false;
    }
    return true;
  }

  /// user must be signed in otherwise
  /// a false will be returned
  Future<bool> enrollToClub({String? clubName}) async {
    try {
      // check whether the user is signed in or not
      if (FirebaseAuth.instance.currentUser == null) return false;

      String? uid = FirebaseAuth.instance.currentUser!.uid;

      // add user id to clubs members array
      var tmp1 = [uid];
      await FirebaseFirestore.instance
          .collection('clubs')
          .doc(clubName)
          .update({"members": FieldValue.arrayUnion(tmp1)});

      // add clubName to users clubs array
      var tmp2 = [clubName];
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update({"events": FieldValue.arrayUnion(tmp2)});
    } catch (e) {
      print(e.toString());
      return false;
    }
    return true;
  }

  /// user must be signed in otherwise
  /// a false will be returned
  Future<bool> leaveClub({String? clubName}) async {
    try {
      // check whether the user is signed in or not
      if (FirebaseAuth.instance.currentUser == null) return false;

      String? uid = FirebaseAuth.instance.currentUser!.uid;

      // delete user id from clubs members array
      var tmp1 = [uid];
      await FirebaseFirestore.instance
          .collection('clubs')
          .doc(clubName)
          .update({"members": FieldValue.arrayRemove(tmp1)});

      // delete clubName from users clubs array
      var tmp2 = [clubName];
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .update({"events": FieldValue.arrayRemove(tmp2)});
    } catch (e) {
      print(e.toString());
      return false;
    }
    return true;
  }

  /// new photo should not be null
  Future<bool> updateClubPhoto({String? clubName, File? newPhoto}) async {
    try {
      await FirebaseStorage.instance
          .ref('clubProfilePhotos/${clubName}.png')
          .putFile(newPhoto!);
    } catch (e) {
      print(e.toString());
      return false;
    }

    return true;
  }

  Future<bool> sendMessageToClubChat(
      {Map<String, dynamic>? data, String? clubName}) async {
    try {
      // check whether the user is signed in or not
      if (FirebaseAuth.instance.currentUser == null) return false;

      String? uid = FirebaseAuth.instance.currentUser!.uid;

      data!["sender"] = uid;

      FirebaseFirestore.instance
          .collection("clubChats")
          .doc(clubName)
          .collection("messages")
          .add(data);
    } catch (e) {
      print(e.toString());
      return false;
    }
    return true;
  }

  Future<File?> getClubPhoto({String? clubName}) async {
    String path = "clubProfilePhotos/${clubName}.png";
    Directory appDocDir = await getApplicationDocumentsDirectory();
    File downloadToFile = File('${appDocDir.path}/download-logo.png');

    try {
      await FirebaseStorage.instance.ref(path).writeToFile(downloadToFile);
    } catch (e) {
      print(e.toString());
      return null;
    }

    return downloadToFile;
  }

  Future<Stream<DocumentSnapshot>?> getClubChatMessages(
      {String? clubName}) async {
    try {
      return FirebaseFirestore.instance
          .collection('clubChats')
          .doc('messages')
          .snapshots();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
// posts/ACM/clubPosts/postID wrong
// posts/postID right
