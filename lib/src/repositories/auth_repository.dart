import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/user.dart';

class AuthRepository {
  FirebaseAuth auth = FirebaseAuth.instance;
  final _users = FirebaseFirestore.instance.collection('userInfo');

  Future<UserCredential> logInWithCredentials(
      {required String email, required String password}) async {
    return await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> signUpWithCredentials(UserModel user,
      {required String email, required String password}) async {
    return await auth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .whenComplete(() {
      user.userId = FirebaseAuth.instance.currentUser!.uid;
      _users.doc(FirebaseAuth.instance.currentUser!.uid).set(user.toJson());
    });
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  Future<String> getUserId() async {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  Future<bool> isSignedIn() async {
    User? currentUser = auth.currentUser;
    currentUser ??= await FirebaseAuth.instance.authStateChanges().first;

    return currentUser != null;
  }

  Future<void> saveUserInfo(UserModel user, File? image) async {
    if (image != null) {
      var imageurl = await uploadUserImage(image);
      user.imageUrl = imageurl;
    }
    user.userId = FirebaseAuth.instance.currentUser!.uid;
    return _users
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(user.toJson());
  }

  Future<String> uploadUserImage(File image) async {
    UploadTask? uploadTask;
    final storageRef = FirebaseStorage.instance.ref();
    final pathRef = 'images/${FirebaseAuth.instance.currentUser!.uid}';
    final file = File(image.path);
    final ref = storageRef.child(pathRef);
    uploadTask = ref.putFile(file);
    final snapshot = await uploadTask.whenComplete(() => {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    return urlDownload;
  }

  Future<UserModel> getUserInfo() async {
    UserModel currentUser = await _users
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) => UserModel.fromSnapshot(value));
    return currentUser;
  }
}
