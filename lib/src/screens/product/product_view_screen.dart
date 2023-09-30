// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kurd_store/src/constants/assets.dart';
import 'package:kurd_store/src/helper/ks_widget.dart';
import 'package:kurd_store/src/screens/cart_screen/cart_screen.dart';

class ProductViewScreen extends StatefulWidget {
  const ProductViewScreen({super.key});

  @override
  State<ProductViewScreen> createState() => _ProductViewScreenState();
}

class _ProductViewScreenState extends State<ProductViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kurd Store"),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          imageView(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'T-Shitr',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  '25,000 IQD',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Nike Brand Full Quality',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
                Text(
                  '30,000 IQD',
                  style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      decorationColor: Colors.red,
                      decorationThickness: 2,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          itemCounter(),
          SizedBox(height: 40),
          KSWidget.itemSizes(
            [
              'S',
              'M',
              'L',
              'XL',
              'XXL',
            ],
          ),
          SizedBox(height: 30),
          itemColors(),
          SizedBox(height: 30),
          addToCartBtn(context),
        ],
      )),
    );
  }

  

  GestureDetector addToCartBtn(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(CartScreen());
      },
      child: Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom +
                ((MediaQuery.of(context).padding.bottom > 0 ? 0 : 15)) +
                20),
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            height: 60,
            // width: 250,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Image.asset(Assets.assetsIconsCartAdd),
                      ),
                    ),
                    Text(
                      "Add to card",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }

  Widget itemColors() {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      runSpacing: 4,
      spacing: 4,
      children: [
        colorCell(Colors.red),
        colorCell(Color.fromARGB(255, 96, 77, 243)),
        colorCell(Color.fromARGB(255, 202, 24, 173)),
        colorCell(Color.fromARGB(255, 119, 195, 13)),
        colorCell(Color.fromARGB(255, 96, 77, 243)),
        colorCell(Color.fromARGB(255, 13, 200, 85)),
      ],
    );
  }

  Widget colorCell(Color color) {
    return Container(
      height: 30,
      width: 30,
      padding: EdgeInsets.all(3),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color.withOpacity(1),
        border: Border.all(color: Colors.white54, width: 3),
      ),
    );
  }

  Padding itemCounter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
                alignment: Alignment.center,
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.amber.withOpacity(0),
                  border: Border.all(color: Colors.black),
                ),
                child: Image.asset(
                  Assets.assetsDummyImagesMinus,
                  scale: 12,
                )),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            '2',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 20,
          ),
          GestureDetector(
            onTap: () {
              Get.snackbar(
                'Hello',
                'message',
              );
              // Get.defaultDialog(title: 'hello diyalog');
            },
            child: Container(
                alignment: Alignment.center,
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.amber.withOpacity(0),
                  border: Border.all(color: Colors.black),
                ),
                child: Image.asset(
                  Assets.assetsDummyImagesPlus,
                  scale: 12,
                )),
          ),
        ],
      ),
    );
  }

  Widget imageView() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Image.asset(Assets.assetsDummyImagesClothes1),
      ),
    );
  }
}
