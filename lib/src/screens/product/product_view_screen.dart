// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kurd_store/src/constants/assets.dart';
import 'package:kurd_store/src/helper/ks_helper.dart';
import 'package:kurd_store/src/helper/ks_widget.dart';
import 'package:kurd_store/src/models/product_model.dart';
import 'package:kurd_store/src/providers/app_provider.dart';
import 'package:provider/provider.dart';

class ProductViewScreen extends StatefulWidget {
  const ProductViewScreen({super.key, required this.product});

  final KSProduct product;

  @override
  State<ProductViewScreen> createState() => _ProductViewScreenState();
}

class _ProductViewScreenState extends State<ProductViewScreen> {
  int itemQuantity = 1;
  String? selectedSize;
  int? selectedColor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kurd Store"),
      ),
      body: StreamBuilder(
          stream: KSProduct.streamByUID(widget.product.uid!),
          builder: (_, snapshot) {
            if (snapshot.data == null) {
              return Center(child: CircularProgressIndicator());
            }

            KSProduct cProduct = snapshot.data!;

            return SingleChildScrollView(
                child: Column(
              children: [
                imageView(cProduct),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        cProduct.name ?? 'N/A',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      if (cProduct.isDiscounted)
                        Text(
                          KSHelper.formatNumber(cProduct.priceDiscount,
                              postfix: " IQD"),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
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
                        cProduct.description ?? 'N/A',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400),
                      ),
                      if (cProduct.isDiscounted)
                        Text(
                          KSHelper.formatNumber(cProduct.price,
                              postfix: " IQD"),
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Colors.red,
                              decorationThickness: 2,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                      if (!cProduct.isDiscounted)
                        Text(
                          KSHelper.formatNumber(cProduct.price,
                              postfix: " IQD"),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                itemCounter(cProduct),
                SizedBox(height: 40),
                KSWidget.itemSizes(
                  cProduct.sizes ?? [],
                  selectedValue: selectedSize,
                  onSizeSelected: (String size) {
                    setState(
                      () {
                        selectedSize = size;
                      },
                    );
                  },
                ),
                SizedBox(height: 30),
                itemColors(
                  cProduct.colors ?? [],
                ),
                SizedBox(height: 30),
                addToCartBtn(cProduct),
              ],
            ));
          }),
    );
  }

  GestureDetector addToCartBtn(KSProduct product) {
    return GestureDetector(
      onTap: () {

        product.quantity = itemQuantity;
        product.selectedSize = selectedSize;
        product.selectedColor = selectedColor;
        Provider.of<AppProvider>(context, listen: false).addToCart(product);
        Get.back(closeOverlays: true);
        KSHelper.showSnackBar("Added to cart");
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

  Widget itemColors(List<int> colors) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      runSpacing: 4,
      spacing: 4,
      children: [
        for (int colorCode in colors)
          GestureDetector(
            onTap: () {
              selectedColor = colorCode;
              setState(() {});
            },
            child: colorCell(
              Color(
                colorCode,
              ),
            ),
          ),
      ],
    );
  }

  Widget colorCell(Color color) {
    var isSelected = color.value == selectedColor;
    return Stack(
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: color.withOpacity(1),
            border: Border.all(color: Colors.white54, width: 3),
          ),
        ),
        if (isSelected)
          Positioned.fill(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              Assets.assetsIconsPlus,
              color: Colors.white,
            ),
          ))
      ],
    );
  }

  Padding itemCounter(KSProduct cProduct) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              itemQuantity--;
              if (itemQuantity < 0) {
                itemQuantity = 0;
              }
              setState(() {});
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
                  Assets.assetsDummyImagesMinus,
                  scale: 12,
                )),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            itemQuantity.toString(),
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 20,
          ),
          GestureDetector(
            onTap: () {
              itemQuantity++;
              if (itemQuantity > cProduct.maxQuantity!) {
                itemQuantity = cProduct.maxQuantity!;
              }
              setState(() {});
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

  Widget imageView(KSProduct ksProduct) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
          ),
          child: CachedNetworkImage(
            imageUrl: ksProduct.imageUrl ?? "",
          ),
        ),
      ),
    );
  }
}
