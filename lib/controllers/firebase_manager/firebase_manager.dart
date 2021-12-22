import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

/// Methods:
///    Related to clubs: getClub, getClubMemberCount
///    Related to users:
///
class FirebaseManager {
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
      'interests': [],
      'uid': user!.uid
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
}
