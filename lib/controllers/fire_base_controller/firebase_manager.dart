import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart'; /*kullanmak nasip olmadı*/
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

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
   * Example: FirebaseManager = await FirebaseManager.getInstance();
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

  /**
   * Returns a future containing the club member count
   * Example:
   *      var manager = await FirebaseManager.getInstance();
   *      print(await manager.getClubMemberCount('ACM'));
   */
  Future<int> getClubMemberCount(String clubName) async {
    var club = await getClub(clubName);

    return Future(() {
      return club['clubInfo']['memberCount'];
    });
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
  Future<void> registerUser(
      {String? email, String? password, String userName = ""}) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);

    User? user = FirebaseAuth.instance.currentUser;
    // send the verification mail
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }

    // create a user document in the users collection
    if (user != null) {
      print('inside user firestore');
      Map<String, dynamic> userData = new Map<String, dynamic>();
      userData['clubs'] = [];
      userData['userName'] = userName;
      userData['photoURL'] = "";
      userData['pinnedPosts'] = [];
      userData['events'] = [];
      userData['interests'] = [];

      await _createUserInFirestore(user.uid, userData);
    }
  }

  Future<void> _createUserInFirestore(
      String uid, Map<String, dynamic> userData) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.doc(uid).set({'userInfo': userData});
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
    }, photos: [
      File(""),
      File(""),
    ]);
   */
  Future<void> createPost(
      {String? clubName,
      Map<String, dynamic>? postData,
      List<File>? files}) async {
    // Add post document id to clubs->clubName->posts array
    String postId = await _createPostInFirestore(clubName!, postData!);

    // Add post to posts collection
    // await _addPostPhotosToStorage(postId, files!);
  }

  /**
   * Returns the document id which will be used as post id
   */
  Future<String> _createPostInFirestore(
      String clubName, Map<String, dynamic> postData) async {
    String postId = "";
    CollectionReference posts = FirebaseFirestore.instance.collection('posts');

    posts
        .doc(clubName)
        .collection('clubPosts')
        .add({'postInfo': postData}).then((value) => (postId = value.id));

    return postId;
  }

  Future<void> _addPostPhotosToStorage(String postId, List<File> files) async {}

  /**
   * Returns a map that can be accessed like json format
   * Example: 
   *      var manager = await FirebaseManager.getInstance();
          var json = await manager.getPost('ACM', 'd55cD092RflhpUpn15nF');
          print(json['postInfo']['postMessage']); 
   */
  Future<DocumentSnapshot<Map<String, dynamic>>> getPost(
      String clubName, String postId) async {
    CollectionReference<Map<String, dynamic>> posts =
        await FirebaseFirestore.instance.collection('posts');
    return posts.doc(clubName).collection('clubPosts').doc(postId).get();
  }
}
