// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kurd_store/src/admin/screens/order_screen/admin_order_view_screen.dart';
import 'package:kurd_store/src/constants/assets.dart';
import 'package:kurd_store/src/helper/ks_widget.dart';
import 'package:kurd_store/src/screens/product/product_see_all_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var isNavigationBarVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kurd Store"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isNavigationBarVisible = !isNavigationBarVisible;
              });
            },
            icon: Icon(Icons.menu),
          ),
          IconButton(
            onPressed: () {
              Get.to(AdminOrderView());
            },
            icon: Icon(Icons.admin_panel_settings),
          )
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: ListView.builder(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom +
                      ((MediaQuery.of(context).padding.bottom > 0 ? 0 : 15)) +
                      60),
              itemCount: 10,
              itemBuilder: (context, index) {
                return itemRowWithCategory();
              },
            ),
          ),
          AnimatedPositioned(
            curve: Curves.easeInOut,
            duration: Duration(milliseconds: 350),
            bottom: MediaQuery.of(context).padding.bottom +
                ((MediaQuery.of(context).padding.bottom > 0 ? 0 : 15)) +
                (isNavigationBarVisible ? 0 : -150),
            left: 0,
            right: 0,
            child: NavigationBar(),
          ),
        ],
      ),
    );
  }

  Column itemRowWithCategory() {
    return Column(
      children: [
        CategoryTitele(
          title: "Clothes",
          iconPath: Assets.assetsIconsClothesIcon,
          // onTap: () {},
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return KSWidget.cardItems(
                  itemName: "T-Shirt Adidas", //odd even
                  itemPath: [
                    Assets.assetsDummyImagesClothes1,
                    Assets.assetsDummyImagesClothes2,
                    Assets.assetsDummyImagesClothes3,
                  ][index % 3],
                  price: "30,000");
            },
          ),
        ),
      ],
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
              KSWidget.iconFrame(
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
