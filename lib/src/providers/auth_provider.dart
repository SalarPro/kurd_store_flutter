import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:kurd_store/src/helper/ks_helper.dart';
import 'package:kurd_store/src/models/user_model.dart';
import 'package:kurd_store/src/screens/cart_screen/cart_screen.dart';
import 'package:kurd_store/src/screens/home_screen/home_screen.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    _listenToUser();

    initFirebaseMessaging();
  }

  FirebaseFirestore db = FirebaseFirestore.instance;
  User? get fireUser => FirebaseAuth.instance.currentUser;

  UserModel? _user;
  // user getter
  UserModel? get user => _user;
  // user setter
  set user(UserModel? user) {
    _user = user;
    notifyListeners();
  }

  bool get isLogin => fireUser != null;

  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _userStream;

  Future<bool> registerWithEmailPassword(
      {required String email, required String password}) async {
    UserCredential userCredential;

    try {
      userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        KSHelper.showSnackBar('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        KSHelper.showSnackBar('The account already exists for that email.');
      } else if (e.code == 'invalid-email') {
        KSHelper.showSnackBar('The email address is not valid.');
      } else if (e.code == 'operation-not-allowed') {
        KSHelper.showSnackBar(
            'The email/password accounts are not enabled. Enable them in the Auth section of the Firebase console.');
      } else {
        KSHelper.showSnackBar("Error 6261:${e.code}: ${e.message}");
      }
      notifyListeners();
      return false;
    }

    if (userCredential.user == null) {
      KSHelper.showSnackBar("Something went wrong please try again");
      await FirebaseAuth.instance.signOut();
      notifyListeners();
      return false;
    }

    await _crateProfileForUser();
    debugPrint("User Created");

    _listenToUser();

    notifyListeners();
    return true;
  }

  Future<bool> loginWithEmailPassword(
      {required String email, required String password}) async {
    UserCredential userCredential;

    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        KSHelper.showSnackBar('No user found for that email.');
      } else if (e.code == 'invalid-email') {
        KSHelper.showSnackBar('The email address is not valid.');
      } else if (e.code == 'user-disabled') {
        KSHelper.showSnackBar('The user is disabled.');
      } else if (e.code == 'wrong-password') {
        KSHelper.showSnackBar('The password is wrong.');
      } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        KSHelper.showSnackBar('The password or email are wrong. ');
      } else {
        KSHelper.showSnackBar("${e.code}: ${e.message}");
        print(e.code);
      }
      notifyListeners();
      return false;
    }

    if (userCredential.user == null) {
      KSHelper.showSnackBar("Something went wrong please try again");
      await FirebaseAuth.instance.signOut();
      notifyListeners();
      return false;
    }

    debugPrint("User Logged in");
    _listenToUser();
    notifyListeners();
    return true;
  }

  _crateProfileForUser() async {
    if (fireUser == null) {
      debugPrint("User is null");
      return;
    }

    user = await UserModel(
      uid: fireUser!.uid,
      email: fireUser!.email,
    );

    user?.save();

    notifyListeners();
  }

  _listenToUser() {
    if (fireUser?.uid == null) {
      print("User is null 4654");
      return;
    }

    _userStream?.cancel();
    _userStream = null;

    _userStream = FirebaseFirestore.instance
        .collection('users')
        .doc(fireUser!.uid)
        .snapshots()
        .listen((event) {
      if (!event.exists) {
        signOut();
        return;
      }
      if (event.data() == null) return;
      user = UserModel.fromMap(event.data() as Map<String, dynamic>);
      notifyListeners();
    });

    print("Listening to user");
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await _userStream?.cancel();
    _userStream = null;
    user = null;
    notifyListeners();
    scaffoldKey = GlobalKey<ScaffoldState>();
    Get.offAll(() => const HomeScreen());
    print("User Signed out");
  }

  Future<bool> checkUserIsLoggedIn() async {
    if (fireUser == null) {
      return false;
    }
    _listenToUser();
    return true;
  }

  void initFirebaseMessaging() async {
    print("Firebase Messaging Called");
    var firebaseMessaging = FirebaseMessaging.instance;
    await firebaseMessaging.requestPermission();

    firebaseMessaging
        .subscribeToTopic("all_user")
        .then((value) => print("Firebase Messaging subscriped to all_user"));

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      var title = event.notification!.title;
      var body = event.notification!.body;

      print("Firebase Messaging local $title");
      print("Firebase Messaging local $body");
      print("Firebase Messaging local ${event.data}");

      KSHelper.showSnackBar("$title\n$body");
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage event) async {
      var title = event.notification!.title;
      var body = event.notification!.body;
      print("Firebase Messaging $title");
      print("Firebase Messaging $body");
      print("Firebase Messaging ${event.data}");
      print("Firebase Messaging notification clicked");

      await 1.delay();

      if (event.data['open_page'] == "cart_screen") {
        Get.to(CartScreen());
      }
    });

    var token = await firebaseMessaging.getToken();

    firebaseMessaging.onTokenRefresh.listen((String cToken) {
      if (fireUser?.uid != null) {
        UserModel.updatePushToken(cToken, fireUser!.uid);
      }
    });

    print("Firebase Messaging Token: $token");
    if (fireUser?.uid != null && token != null) {
      UserModel.updatePushToken(token, fireUser!.uid);
    }
  }
}
