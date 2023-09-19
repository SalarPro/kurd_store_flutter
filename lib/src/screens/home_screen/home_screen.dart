// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:kurd_store/src/constants/assets.dart';
import 'package:kurd_store/src/helper/ks_widget.dart';
import 'package:kurd_store/src/screens/drawer_screens/drawer_widget.dart';
import 'package:kurd_store/src/screens/product/product_see_all_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

final GlobalKey<ScaffoldState> _key = GlobalKey();

class _HomeScreenState extends State<HomeScreen> {
  var isNavigationBarVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: NavBar(),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 110),
              child: Positioned.fill(
                child: ListView.builder(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).padding.bottom +
                            ((MediaQuery.of(context).padding.bottom > 0
                                ? 0
                                : 15)) +
                            60),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return itemRowWithCategory();
                    }),
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
            appBarHomeScreen(),
          ],
        ),
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
            itemCount: 3,
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
                      width: 40,
                      height: 40,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Badge(
                        label: Text(
                          '2',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        backgroundColor: Colors.red,
                        child: InkWell(
                          child: Image.asset(
                            Assets.assetsIconsCartAdd,
                          ),
                        ),
                      ),
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
  // Home AppBar

  Widget appBarHomeScreen() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.only(top: 20),
        color: Colors.white,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                _key.currentState!.openDrawer();
              },
              icon: Container(
                width: 40,
                height: 40,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(5),
                child: Image.asset(Assets.assetsIconsMenu),
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
                  'Kurd Store',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Find anything what you want!',
                    style: TextStyle(fontSize: 14, color: Colors.grey[400]),
                  ),
                ),
              ],
            ),
            Spacer(),
            Container(
              width: 40,
              height: 40,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(5),
              child: Image.asset(Assets.assetsIconsSearch),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey),
              ),
            ),
            Container(
              width: 40,
              height: 40,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey),
              ),
              child: Badge(
                textStyle: TextStyle(fontSize: 100),
                backgroundColor: Colors.red,
                child: InkWell(
                  child: Image.asset(
                    Assets.assetsIconsNotfication,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
