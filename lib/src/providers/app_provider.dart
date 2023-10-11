import 'package:flutter/material.dart';
import 'package:kurd_store/src/models/product_model.dart';

class AppProvider extends ChangeNotifier {
  List<KSProduct> cart = [];

  void addToCart(KSProduct product) {
    // new items
    // uid
    // color
    // size

    var isExist = false;

    for (var cCart in cart) {
      if (cCart.uid == product.uid &&
          cCart.selectedColor == product.selectedColor &&
          cCart.selectedSize == product.selectedSize) {
        cCart.quantity = (cCart.quantity ?? 1) + (product.quantity ?? 1);

        if ((cCart.quantity ?? 0) > (product.maxQuantity ?? 0)) {
          cCart.quantity = product.maxQuantity;
        }

        isExist = true;
      }
    }
    if (!isExist) {
      cart.add(product);
    }
    notifyListeners();
  }

  void removeFromCart(KSProduct product) {
    cart.remove(product);
    notifyListeners();
  }

  double get totalPriceAfterDiscount {
    var price = 0.0;
    for (KSProduct item in cart) {
      price += item.totalPriceAfterDiscount;
    }
    return price;
  }

  double get totalPrice {
    var price = 0.0;
    for (KSProduct item in cart) {
      price += item.totalPrice;
    }
    return price;
  }

  double get discountAmount {
    return totalPrice - totalPriceAfterDiscount;
  }

  int get totalQuantity {
    var quantity = 0;
    for (KSProduct item in cart) {
      quantity += item.quantity ?? 1;
    }
    return quantity;
  }

  void clearCart() {
    cart.clear();
    notifyListeners();
  }
}
