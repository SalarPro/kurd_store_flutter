import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kurd_store/src/models/product_model.dart';

class KSOrder {
  String? uid;
  String? userName;
  String? userPhone;
  String? userCity;
  String? userAddress;
  String? userNote;
  List<KSProduct>? products;

  int? deliveryPrice;

  String? status; //pending, preparing, delivering, completed, canceled

  Timestamp? createAt;
  Timestamp? updateAt;

  int get productQuantity => products?.length ?? 0;

  int get itemsQuantity {
    var tempQuantity = 0;
    for (KSProduct item in products ?? []) {
      tempQuantity += item.quantity;
    }
    return tempQuantity;
  }

  double get totalPrice {
    //100,000
    var price = 0.0;
    for (KSProduct item in products ?? []) {
      price += item.totalPrice;
    }
    return price;
  }

  double get totalDiscounted {
    //40,000
    var tempPrice = 0.0;
    for (KSProduct item in products ?? []) {
      tempPrice += item.priceDiscount ?? 0;
    }
    return tempPrice;
  }

  double get totalPriceAfterDiscount {
    //60,000
    var price = 0.0;
    for (KSProduct item in products ?? []) {
      if (item.priceDiscount != null) {
        price += item.totalPriceAfterDiscount;
      } else {
        price += item.totalPrice;
      }
    }
    return price;
  }

  double get totalWithDiscountAndDelivery {
    return totalPriceAfterDiscount + (deliveryPrice ?? 0);
  }

  KSOrder({
    this.uid,
    this.userName,
    this.userPhone,
    this.userCity,
    this.userAddress,
    this.userNote,
    this.products,
    this.status,
    this.createAt,
    this.updateAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'userName': userName,
      'userPhone': userPhone,
      'userCity': userCity,
      'userAddress': userAddress,
      'userNote': userNote,
      'products': products?.map((product) => product.toMap()).toList(),
      'status': status,
      'createAt': createAt,
      'updateAt': updateAt,
    };
  }

  factory KSOrder.fromMap(Map<String, dynamic> map) {
    return KSOrder(
      uid: map['uid'],
      userName: map['userName'],
      userPhone: map['userPhone'],
      userCity: map['userCity'],
      userAddress: map['userAddress'],
      userNote: map['userNote'],
      products: List<KSProduct>.from(
          map['products']?.map((x) => KSProduct.fromMap(x))),
      status: map['status'],
      createAt: map['createAt'],
      updateAt: map['updateAt'],
    );
  }

  // save
  Future<void> save() {
    return FirebaseFirestore.instance
        .collection('orders')
        .doc(uid)
        .set(toMap());
  }

  // update
  Future<void> update() {
    return FirebaseFirestore.instance
        .collection('orders')
        .doc(uid)
        .update(toMap());
  }

  // delete
  Future<void> delete() {
    return FirebaseFirestore.instance.collection('orders').doc(uid).delete();
  }

  //stream all
  static Stream<List<KSOrder>> streamAll() {
    return FirebaseFirestore.instance
        .collection('orders')
        .orderBy('createAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((document) => KSOrder.fromMap(document.data()))
            .toList());
  }

  static Future<KSOrder> getByUID(String uid) async {
    var firebaseQuery =
        await FirebaseFirestore.instance.collection('orders').doc(uid).get();

    return KSOrder.fromMap(firebaseQuery.data() ?? {});
  }
}
