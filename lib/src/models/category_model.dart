import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String? uid;
  String? categoryName;
  String? description;

  Timestamp? createAt;
  Timestamp? updateAt;

  CategoryModel({
    this.uid,
    this.categoryName,
    this.description,
    this.createAt,
    this.updateAt,
  });

  Map<String, dynamic> topMap() {
    return {
      'uid': uid,
      'categoryName': categoryName,
      'description': description,
      'createAt': createAt,
      'updateAt': updateAt,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      uid: map['uid'],
      categoryName: map['categoryName'],
      description: map['description'],
      createAt: map['createAt'],
      updateAt: map['updateAt'],
    );
  }
}
