import 'package:cloud_firestore/cloud_firestore.dart';

class KSProduct {
  String? uid;
  String? name;
  String? description;
  int? price;
  int? priceDiscount;
  int? maxQuantity; //available quantity in stock
  String? imageUrl;
  List<String>? sizes; //
  List<int>? colors; // 0xFF000000

  List<String>? categoriesIds; // ['fglzdh'. 'dsgsdhfgb']

  Timestamp? createAt;
  Timestamp? updateAt;

  int? quantity;
  String? selectedSize;
  int? selectedColor;

  
  String get searchText {
    return "$name $description $uid $price".toLowerCase();
  }

  bool get isDiscounted => priceDiscount != null;

  double get totalPrice {
    var tempPrice = 0.0;

    tempPrice += (price ?? 0) * (quantity ?? 1);
    return tempPrice;
  }

  double get totalPriceAfterDiscount {
    var tempPrice = 0.0;
    if (priceDiscount != null) {
      tempPrice += (priceDiscount ?? 0) * (quantity ?? 1);
    } else {
      tempPrice += (price ?? 0) * (quantity ?? 1);
    }
    return tempPrice;
  }

  double get discountAmount {
    return totalPrice - totalPriceAfterDiscount;
  }

  bool get isOutOfStock => maxQuantity == 0 || maxQuantity == null;

  KSProduct({
    this.uid,
    this.name,
    this.description,
    this.price,
    this.priceDiscount,
    this.maxQuantity,
    this.imageUrl,
    this.sizes,
    this.colors,
    this.categoriesIds,
    this.createAt,
    this.updateAt,
    this.quantity,
    this.selectedSize,
    this.selectedColor,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'description': description,
      'price': price,
      'priceDiscount': priceDiscount,
      'maxQuantity': maxQuantity,
      'imageUrl': imageUrl,
      'sizes': sizes,
      'colors': colors,
      'categoriesIds': categoriesIds,
      'createAt': createAt,
      'updateAt': updateAt,
      'quantity': quantity,
      'selectedSize': selectedSize,
      'selectedColor': selectedColor,
    };
  }

  factory KSProduct.fromMap(Map<String, dynamic> map) {
    return KSProduct(
      uid: map['uid'],
      name: map['name'],
      description: map['description'],
      price: map['price'],
      priceDiscount: map['priceDiscount'],
      maxQuantity: map['maxQuantity'],
      imageUrl: map['imageUrl'],
      sizes: List<String>.from(map['sizes'] ?? []),
      colors: List<int>.from(map['colors'] ?? []),
      categoriesIds: List<String>.from(map['categoriesIds'] ?? []),
      createAt: map['createAt'],
      updateAt: map['updateAt'],
      quantity: map['quantity'],
      selectedSize: map['selectedSize'],
      selectedColor: map['selectedColor'],
    );
  }

  // save
  Future<void> save() {
    return FirebaseFirestore.instance.collection('products').doc(uid).set({
      ...toMap(),
      "createAt": FieldValue.serverTimestamp(),
      "updateAt": FieldValue.serverTimestamp(),
    });
  }

  // update
  Future<void> update() {
    return FirebaseFirestore.instance.collection('products').doc(uid).update({
      ...toMap(),
      "updateAt": FieldValue.serverTimestamp(),
    });
  }

  // delete
  Future<void> delete() {
    return FirebaseFirestore.instance.collection('products').doc(uid).delete();
  }

  //stream all
  static Stream<List<KSProduct>> streamAll() {
    return FirebaseFirestore.instance.collection('products').snapshots().map(
        (event) => event.docs.map((e) => KSProduct.fromMap(e.data())).toList());
  }

  static Future<KSProduct> getByUID(String uid) async {
    var firebaseQuery =
        await FirebaseFirestore.instance.collection('products').doc(uid).get();

    return KSProduct.fromMap(firebaseQuery.data() ?? {});
  }

  static Stream<KSProduct> streamByUID(String uid) {
    return FirebaseFirestore.instance
        .collection('products')
        .doc(uid)
        .snapshots()
        .map((event) => KSProduct.fromMap(event.data() ?? {}));
  }

  Future deleteCategoryUID(String? categoryUID) async {
    //right way
    await FirebaseFirestore.instance.collection('products').doc(uid).update({
      'categoriesIds': FieldValue.arrayRemove([categoryUID]),
    });
  }

  // function to dicrement quantity of product
  Future<void> decrementQuantity() {
    return FirebaseFirestore.instance.collection('products').doc(uid).update({
      'maxQuantity': FieldValue.increment(-(quantity ?? 1)),
    });
  }
}
