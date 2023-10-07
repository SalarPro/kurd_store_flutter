//TODO: create user model to use in firebase

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? uid;
  final String? username;
  final String? email;
  final String? phone;
  final String? address;
  final Timestamp? createAt;
  final Timestamp? updateAt;

  UserModel({
    this.uid,
    this.username,
    this.email,
    this.phone,
    this.address,
    this.createAt,
    this.updateAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'phone': phone,
      'address': address,
      'createAt': createAt,
      'updateAt': updateAt,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      username: map['username'],
      email: map['email'],
      phone: map['phone'],
      address: map['address'],
      createAt: map['createAt'],
      updateAt: map['updateAt'],
    );
  }

  Future save() async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      ...toMap(),
      'createAt': FieldValue.serverTimestamp(),
      'updateAt': FieldValue.serverTimestamp(),
    });
  }

  Future update() async {
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      ...toMap(),
      'updateAt': FieldValue.serverTimestamp(),
    });
  }

  Future delete() async {
    await FirebaseFirestore.instance.collection('users').doc(uid).delete();
  }

  Stream<List<UserModel>> streamAll() {
    return FirebaseFirestore.instance
        .collection('users')
        .orderBy('createAt', descending: true)
        .snapshots()
        .map((event) {
      return event.docs.map((e) => UserModel.fromMap(e.data())).toList();
    });
  }

  // stream one
  static Stream<UserModel> streamOne(String uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
  }

  // get one
  static Future<UserModel> getOne(String uid) async {
    var doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return UserModel.fromMap(doc.data() as Map<String, dynamic>);
  }
}
