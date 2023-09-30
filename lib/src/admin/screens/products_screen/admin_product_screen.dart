// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kurd_store/src/admin/screens/products_screen/admin_product_edit_screen.dart';
import 'package:kurd_store/src/constants/assets.dart';
import 'package:kurd_store/src/helper/ks_widget.dart';
import 'package:kurd_store/src/models/product_model.dart';

class AdminProductScreen extends StatefulWidget {
  const AdminProductScreen({super.key});

  @override
  State<AdminProductScreen> createState() => _AdminProductScreenState();
}

class _AdminProductScreenState extends State<AdminProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              appBar(),
              kstextfield(title: 'Search', icon: Icons.search),
              StreamBuilder<List<KSProduct>>(
                  stream: KSProduct.streamAll(),
                  builder: (_, snapshot) {
                    if (snapshot.data == null) {
                      return CircularProgressIndicator.adaptive();
                    }

                    var products = snapshot.data!;

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
                'Products',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  'Niwar Admin',
                  style: TextStyle(fontSize: 14, color: Colors.grey[400]),
                ),
              ),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 40,
              height: 40,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(5),
              child: Image.asset(Assets.assetsIconsFillter),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey),
              ),
            ),
          ),
          KSWidget.iconFrame(Assets.assetsIconsAdd, size: 40, onTap: () {
            Get.to(() => AdminProductEditScreen());
          }),
          const SizedBox(width: 10),
        ],
      ),
    );
  }

  //Search TextField

  Widget kstextfield({
    required title,
    required icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: TextField(
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
        Get.to(() => AdminProductEditScreen(
              wProduct: product,
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
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text("Delete Product!"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Do you want to remove This?"),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    product.delete();
                                  });
                                  Get.back();
                                },
                                child: Text(
                                  "Yes",
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text("NO"))
                            ],
                          ),
                        );
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
                    SizedBox(height: 80),
                    KSWidget.iconFrame(Assets.assetsIconsAdd, size: 35,
                        onTap: () {
                      Get.to(() => AdminProductEditScreen(
                            wProduct: product,
                          ));
                    }),
                  ],
                ),
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
}
