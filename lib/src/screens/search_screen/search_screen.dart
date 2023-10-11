// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kurd_store/src/constants/assets.dart';
import 'package:kurd_store/src/helper/ks_helper.dart';
import 'package:kurd_store/src/helper/ks_text_style.dart';
import 'package:kurd_store/src/helper/ks_widget.dart';
import 'package:kurd_store/src/models/product_model.dart';
import 'package:kurd_store/src/providers/app_provider.dart';
import 'package:kurd_store/src/screens/cart_screen/cart_screen.dart';
import 'package:kurd_store/src/screens/product/product_view_screen.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchETC = TextEditingController();

  var focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(height: Get.height),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  appBar(),
                  searchTextField(title: 'Search', icon: Icons.search),
                  StreamBuilder<List<KSProduct>>(
                      stream: KSProduct.streamAll(),
                      builder: (_, snapshot) {
                        if (snapshot.data == null) {
                          return CircularProgressIndicator.adaptive();
                        }

                        var products = snapshot.data!;

                        products = products
                            .where((element) => element.searchText
                                .toLowerCase()
                                .contains(searchETC.text.toLowerCase()))
                            .toList();

                        return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: products.length,
                            itemBuilder: (_, index) {
                              var product = products[index];

                              return CartCheckOut(product: product);
                            });
                      })
                ],
              ),
            ),
          ),
          AnimatedPositioned(
            curve: Curves.easeInOut,
            duration: Duration(milliseconds: 350),
            bottom: MediaQuery.of(context).padding.bottom +
                ((MediaQuery.of(context).padding.bottom > 0 ? 0 : 15)) +
                (Provider.of<AppProvider>(context).cart.isNotEmpty ? 0 : -150),
            left: 0,
            right: 0,
            child: cartInfo(),
          ),
        ],
      ),
    );
  }

  //// AppBar
  Widget appBar() {
    return Container(
      padding: EdgeInsets.only(top: 20),
      color: Colors.white,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Container(
              width: 40,
              height: 40,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(5),
              child: Image.asset(Assets.assetsIconsLeftArrow),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Search',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }

  //Search TextField

  Widget searchTextField({required title, required icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: TextField(
            focusNode: focusNode,
            controller: searchETC,
            onChanged: (value) {
              setState(() {});
            },
            decoration: InputDecoration(
              label: Text(title),
              prefixIcon: Icon(icon),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // CartScreen

  Widget CartCheckOut({
    required KSProduct product,
  }) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductViewScreen(
              product: product,
            ));
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      imageUrl: product.imageUrl ?? "",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name ?? "N/A",
                        style: TextStyle(
                          fontSize: 16,
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
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                      if (!product.isDiscounted)
                        Text(
                          KSHelper.formatNumber(product.price, postfix: " IQD"),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      if (product.isDiscounted)
                        Text(
                          KSHelper.formatNumber(product.priceDiscount,
                              postfix: " IQD"),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      Text(
                        product.description ?? "N/A",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                KSWidget.iconFrame(Assets.assetsIconsPlus, onTap: () {
                  if (product.isOutOfStock) {
                    return;
                  }
                  if ((product.sizes?.length ?? 0) > 1 ||
                      (product.colors?.length ?? 0) > 1) {
                    Get.to(() => ProductViewScreen(product: product));
                  } else {
                    product.quantity = 1;

                    // null or ["red"]
                    product.selectedColor = product.colors?.firstOrNull;
                    product.selectedSize = product.sizes?.firstOrNull;

                    Provider.of<AppProvider>(Get.context!, listen: false)
                        .addToCart(product);
                  }
                })
              ],
            ),
          ),
          SizedBox(height: 10),
          Divider(
            color: Colors.grey,
            height: 2,
            endIndent: 10,
            indent: 10,
          ),
        ],
      ),
    );
  }

  Widget cartInfo() {
    return GestureDetector(
      onTap: () {
        Get.to(() => CartScreen());
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          height: 60,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.8),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: Badge(
                      label: Text(
                        Provider.of<AppProvider>(context)
                            .totalQuantity
                            .toString(),
                      ),
                      offset: Offset(10, -8),
                      textStyle: KSTextStyle.light(12),
                      alignment: Alignment.topRight,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Image.asset(Assets.assetsIconsCart),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Cart",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
              Text(
                KSHelper.formatNumber(
                    Provider.of<AppProvider>(context).totalPriceAfterDiscount,
                    postfix: " IQD"),
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
