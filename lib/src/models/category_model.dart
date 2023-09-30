import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kurd_store/src/models/product_model.dart';

class KSCategory {
  String? uid;
  String? name;
  String? iconImageUrl;

  int? orderIndex;
  Timestamp? createAt;
  Timestamp? updateAt;

  KSCategory({
    this.uid,
    this.name,
    this.iconImageUrl,
    this.orderIndex,
    this.createAt,
    this.updateAt,
  });

  Map<String, dynamic> topMap() {
    return {
      'uid': uid,
      'categoryName': name,
      'iconImageUrl': iconImageUrl,
      'orderIndex': orderIndex ?? 100,
      'createAt': createAt,
      'updateAt': updateAt,
    };
  }

  factory KSCategory.fromMap(Map<String, dynamic> map) {
    return KSCategory(
      uid: map['uid'],
      name: map['categoryName'],
      iconImageUrl: map['iconImageUrl'],
      orderIndex: map['orderIndex'],
      createAt: map['createAt'],
      updateAt: map['updateAt'],
    );
  }

  // save
  Future<void> save() {
    return FirebaseFirestore.instance.collection('categories').doc(uid).set({
      ...topMap(),
      'createAt': FieldValue.serverTimestamp(),
      'updateAt': FieldValue.serverTimestamp(),
    });
  }

  // update
  Future<void> update() {
    return FirebaseFirestore.instance.collection('categories').doc(uid).update({
      ...topMap(),
      'updateAt': FieldValue.serverTimestamp(),
    });
  }

  // delete
  Future<void> delete() {
    return FirebaseFirestore.instance
        .collection('categories')
        .doc(uid)
        .delete();
  }

  //stream all
  static Stream<List<KSCategory>> streamAll() {
    return FirebaseFirestore.instance
        .collection('categories')
        .orderBy('orderIndex', descending: false)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => KSCategory.fromMap(e.data())).toList());
  }

  Future<List<KSProduct>> getProducts() async {
    var response = await FirebaseFirestore.instance
        .collection('products')
        .where('categoriesIds', arrayContains: [uid]).get();

    return response.docs
        .map((e) => KSProduct.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  static Future<KSCategory> getByUID(String uid) async {
    var firebaseQuery = await FirebaseFirestore.instance
        .collection('categories')
        .doc(uid)
        .get();

    return KSCategory.fromMap(firebaseQuery.data() ?? {});
  }

  static Future<List<KSCategory>> getAll() {
    return FirebaseFirestore.instance.collection('categories').get().then(
        (value) => value.docs
            .map((e) => KSCategory.fromMap(e.data() as Map<String, dynamic>))
            .toList());
  }
}
