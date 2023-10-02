import 'package:flutter/material.dart';
import 'package:kurd_store/src/models/product_model.dart';

class AppProvider extends ChangeNotifier {
  List<KSProduct> cart = [];

  void addToCart(KSProduct product) {
    cart.add(product);
    notifyListeners();
  }

  void removeFromCart(KSProduct product) {
    cart.remove(product);
    notifyListeners();
  }

}
