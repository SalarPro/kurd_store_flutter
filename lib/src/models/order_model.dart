import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kurd_store/src/helper/ks_helper.dart';
import 'package:kurd_store/src/models/product_model.dart';

class KSOrder {
  String? uid;
  String? trackingNumber;
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
      tempQuantity += item.quantity ?? 1;
    }
    return tempQuantity;
  }

  //START

  double get totalPrice {
    var price = 0.0;
    for (KSProduct item in products ?? []) {
      price += item.totalPrice;
    }
    return price;
  }

  double get totalPriceAfterDiscount {
    var price = 0.0;
    for (KSProduct item in products ?? []) {
      price += item.totalPriceAfterDiscount;
    }
    return price;
  }

  double get discountAmount {
    return totalPrice - totalPriceAfterDiscount;
  }

  //END
  double get totalWithDiscountAndDelivery {
    return totalPriceAfterDiscount + (deliveryPrice ?? 0);
  }

  KSOrder({
    this.uid,
    this.trackingNumber,
    this.userName,
    this.userPhone,
    this.userCity,
    this.userAddress,
    this.userNote,
    this.products,
    this.status,
    this.deliveryPrice,
    this.createAt,
    this.updateAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'trackingNumber': trackingNumber,
      'userName': userName,
      'userPhone': userPhone,
      'userCity': userCity,
      'userAddress': userAddress,
      'userNote': userNote,
      'products': products?.map((product) => product.toMap()).toList(),
      'status': status,
      'deliveryPrice': deliveryPrice,
      'createAt': createAt,
      'updateAt': updateAt,
    };
  }

  factory KSOrder.fromMap(Map<String, dynamic> map) {
    return KSOrder(
      uid: map['uid'],
      trackingNumber: map['trackingNumber'],
      userName: map['userName'],
      userPhone: map['userPhone'],
      userCity: map['userCity'],
      userAddress: map['userAddress'],
      userNote: map['userNote'],
      products: List<KSProduct>.from(
          map['products']?.map((x) => KSProduct.fromMap(x))),
      status: map['status'],
      deliveryPrice: map['deliveryPrice'],
      createAt: map['createAt'],
      updateAt: map['updateAt'],
    );
  }

  // save
  Future<void> save() async {
    trackingNumber = KSHelper.generateRandomString(6);
    for (KSProduct item in products ?? []) {
      await item.decrementQuantity();
    }
    return FirebaseFirestore.instance.collection('orders').doc(uid).set({
      ...toMap(),
      'createAt': FieldValue.serverTimestamp(),
      'updateAt': FieldValue.serverTimestamp(),
    });
  }

  // update
  Future<void> update() {
    return FirebaseFirestore.instance.collection('orders').doc(uid).update({
      ...toMap(),
      'updateAt': FieldValue.serverTimestamp(),
    });
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

  static Stream<KSOrder> streamByUID(String? uid) {
    return FirebaseFirestore.instance
        .collection('orders')
        .doc(uid)
        .snapshots()
        .map((document) => KSOrder.fromMap(document.data() ?? {}));
  }
}
