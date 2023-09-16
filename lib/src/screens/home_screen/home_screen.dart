// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:kurd_store/src/constants/assets.dart';
import 'package:kurd_store/src/screens/product/product_see_all_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kurd Store"),
        actions: [Icon(Icons.menu)],
      ),
      body: Stack(
        children: [
          Positioned(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            CategoryTitele(
                              title: "Clothes",
                              iconPath: Assets.assetsIconsClothesIcon,
                              // onTap: () {},
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  CardItems(
                                      itemName: "T-Shirt",
                                      itemPath: Assets.assetsDummyImagesClothes1,
                                      price: "30,000"),
                                  CardItems(
                                      itemName: "T-Shirt",
                                      itemPath: Assets.assetsDummyImagesClothes2,
                                      price: "15,000"),
                                  CardItems(
                                      itemName: "T-Shirt",
                                      itemPath: Assets.assetsDummyImagesClothes3,
                                      price: "200,000"),
                                  CardItems(
                                      itemName: "T-Shirt",
                                      itemPath: Assets.assetsDummyImagesClothes1,
                                      price: "22,000"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            CategoryTitele(
                              title: "Tech",
                              iconPath: Assets.assetsIconsElectronicIcon,
                              // onTap: () {},
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  CardItems(
                                      itemName: "T-Shirt",
                                      itemPath: Assets.assetsDummyImagesClothes1,
                                      price: "30,000"),
                                  CardItems(
                                      itemName: "T-Shirt",
                                      itemPath: Assets.assetsDummyImagesClothes2,
                                      price: "15,000"),
                                  CardItems(
                                      itemName: "T-Shirt",
                                      itemPath: Assets.assetsDummyImagesClothes3,
                                      price: "200,000"),
                                  CardItems(
                                      itemName: "T-Shirt",
                                      itemPath: Assets.assetsDummyImagesClothes1,
                                      price: "22,000"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            CategoryTitele(
                              title: "Clothes",
                              iconPath: Assets.assetsIconsClothesIcon,
                              // onTap: () {},
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  CardItems(
                                      itemName: "T-Shirt",
                                      itemPath: Assets.assetsDummyImagesClothes1,
                                      price: "30,000"),
                                  CardItems(
                                      itemName: "T-Shirt",
                                      itemPath: Assets.assetsDummyImagesClothes2,
                                      price: "15,000"),
                                  CardItems(
                                      itemName: "T-Shirt",
                                      itemPath: Assets.assetsDummyImagesClothes3,
                                      price: "200,000"),
                                  CardItems(
                                      itemName: "T-Shirt",
                                      itemPath: Assets.assetsDummyImagesClothes1,
                                      price: "22,000"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            CategoryTitele(
                              title: "Clothes",
                              iconPath: Assets.assetsIconsClothesIcon,
                              // onTap: () {},
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  CardItems(
                                      itemName: "T-Shirt",
                                      itemPath: Assets.assetsDummyImagesClothes1,
                                      price: "30,000"),
                                  CardItems(
                                      itemName: "T-Shirt",
                                      itemPath: Assets.assetsDummyImagesClothes2,
                                      price: "15,000"),
                                  CardItems(
                                      itemName: "T-Shirt",
                                      itemPath: Assets.assetsDummyImagesClothes3,
                                      price: "200,000"),
                                  CardItems(
                                      itemName: "T-Shirt",
                                      itemPath: Assets.assetsDummyImagesClothes1,
                                      price: "22,000"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 110,
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: NavigationBar(),
          ),
        ],
      ),
    );
  }

  Widget CardItems({
    required String itemPath,
    required String price,
    required String itemName,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Container(
        padding: EdgeInsets.all(10),
        height: 185,
        width: 170,
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  itemPath,
                  height: 100,
                ),
                // SizedBox(
                //   width: 15,
                // ),
                Spacer(),

                iconFrame(Assets.assetsIconsFavorite)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      itemName,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "$price IQD",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                // SizedBox(
                //   width: 35,
                // ),
                Spacer(),
                iconFrame(Assets.assetsIconsCart)
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget CategoryTitele({
    required final String title,
    required final String iconPath,
    final Function? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              iconFrame(
                iconPath,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              // onTap;
            },
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SeeAllProduct()));
              },
              child: Text(
                "See more",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container iconFrame(
    String? iconPath,
  ) {
    return Container(
      padding: EdgeInsets.all(5),
      height: 35,
      width: 35,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black)),
      child: Image.asset(iconPath!),
    );
  }

  Widget NavigationBar(
      // String? iconPath,
      ) {
    return Padding(
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
                    padding: EdgeInsets.symmetric(horizontal: 10),
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
                  Text(
                    "Cart",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )
                ],
              ),
              Text(
                "150,000 IQD",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              )
            ],
          )),
    );
  }
}
