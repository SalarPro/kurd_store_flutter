// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kurd_store/src/constants/assets.dart';
import 'package:kurd_store/src/helper/ks_helper.dart';
import 'package:kurd_store/src/helper/ks_widget.dart';
import 'package:kurd_store/src/models/product_model.dart';
import 'package:kurd_store/src/providers/app_provider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Card Screen"),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: ListView.builder(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom +
                      ((MediaQuery.of(context).padding.bottom > 0 ? 0 : 15)) +
                      70 +
                      120),
              itemCount: Provider.of<AppProvider>(context).cart.length,
              itemBuilder: (_, index) {
                return CartCheckOut(
                    Provider.of<AppProvider>(context).cart[index]);
              },
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom +
                ((MediaQuery.of(context).padding.bottom > 0 ? 0 : 15)) +
                70,
            left: 0,
            right: 0,
            child: cartDetails(),
          ),
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom +
                ((MediaQuery.of(context).padding.bottom > 0 ? 0 : 15)),
            left: 0,
            right: 0,
            child: KSWidget.checkOutBtn(),
          ),
        ],
      ),
    );
  }

  Widget cartDetails(
      // String? iconPath,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        // height: 200,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Products',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  // SizedBox(
                  //   width: 200,
                  // ),
                  Text(
                    KSHelper.formatNumber(
                        Provider.of<AppProvider>(context).totalPrice,
                        postfix: " IQD"),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Discount',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  // SizedBox(
                  //   width: 200,
                  // ),
                  Text(
                    KSHelper.formatNumber(
                        Provider.of<AppProvider>(context).discountAmount,
                        postfix: " IQD"),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  // SizedBox(
                  //   width: 200,
                  // ),
                  Text(
                    KSHelper.formatNumber(
                        Provider.of<AppProvider>(context)
                            .totalPriceAfterDiscount,
                        postfix: " IQD"),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget CartCheckOut(KSProduct product) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: CachedNetworkImage(
                  imageUrl: product.imageUrl ?? "",
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name ?? "N/A",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (product.selectedColor != null)
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Color(product.selectedColor!),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white54, width: 3),
                        ),
                      ),
                    if (product.selectedSize != null)
                      Text(
                        product.selectedSize ?? "",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    if (product.isDiscounted)
                      Text(
                        KSHelper.formatNumber(product.price, postfix: " IQD"),
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Colors.red,
                            decorationThickness: 2,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                    if (!product.isDiscounted)
                      Text(
                        KSHelper.formatNumber(product.price, postfix: " IQD"),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    if (product.isDiscounted)
                      Text(
                        KSHelper.formatNumber(product.priceDiscount,
                            postfix: " IQD"),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    Text(
                      KSHelper.formatNumber(product.totalPriceAfterDiscount,
                          postfix: " IQD"),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Provider.of<AppProvider>(context, listen: false)
                          .removeFromCart(product);
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black)),
                      child: Image.asset(Assets.assetsIconsRemove),
                    ),
                  ),
                  const SizedBox(height: 30),
                  if (product.maxQuantity != 1) cartItemCounter(product),
                ],
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.grey,
          height: 2,
          endIndent: 10,
          indent: 10,
        ),
      ],
    );
  }

  Widget cartItemCounter(KSProduct product) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 50,
        ),
        GestureDetector(
          onTap: () {
            product.quantity = (product.quantity ?? 0) - 1;
            if (product.quantity! <= 0) {
              product.quantity = 1;
            }
            setState(() {});
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black),
            ),
            child: Image.asset(
              Assets.assetsDummyImagesMinus,
              scale: 18,
            ),
          ),
        ),
      SizedBox(
          width: 10,
        ),
        Text(
          product.quantity.toString(),
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 10,
        ),
        GestureDetector(
          onTap: () {
            product.quantity = (product.quantity ?? 0) + 1;
            if (product.quantity! > product.maxQuantity!) {
              product.quantity = product.maxQuantity!;
            }
            setState(() {});
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black),
            ),
            child: Image.asset(
              Assets.assetsDummyImagesPlus,
              scale: 18,
            ),
          ),
        ),
      ],
    );
  }
}
