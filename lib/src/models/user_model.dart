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
}
