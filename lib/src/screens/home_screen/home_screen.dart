// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kurd_store/src/constants/assets.dart';
import 'package:kurd_store/src/helper/ks_helper.dart';
import 'package:kurd_store/src/helper/ks_text_style.dart';
import 'package:kurd_store/src/helper/ks_widget.dart';
import 'package:kurd_store/src/models/category_model.dart';
import 'package:kurd_store/src/models/product_model.dart';
import 'package:kurd_store/src/providers/app_provider.dart';
import 'package:kurd_store/src/screens/cart_screen/cart_screen.dart';
import 'package:kurd_store/src/screens/drawer_screens/drawer_widget.dart';
import 'package:kurd_store/src/screens/product/product_see_all_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: MainDrawer(),
      appBar: appBar(),
      body: Stack(
        children: [
          body,
          AnimatedPositioned(
            curve: Curves.easeInOut,
            duration: Duration(milliseconds: 350),
            bottom: MediaQuery.of(context).padding.bottom +
                ((MediaQuery.of(context).padding.bottom > 0 ? 0 : 15)) +
                (Provider.of<AppProvider>(context).cart.isNotEmpty ? 0 : -150),
            left: 0,
            right: 0,
            child: NavigationBar(),
          ),
        ],
      ),
    );
  }

  get body => StreamBuilder<List<KSCategory>>(
      stream: KSCategory.streamAll(),
      builder: (_, snapshot) {
        if (snapshot.data == null) {
          return Center(child: CircularProgressIndicator());
        }

        List<KSCategory> mCategory = snapshot.data!;

        return ListView.builder(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom +
                  ((MediaQuery.of(context).padding.bottom > 0 ? 0 : 15)) +
                  60),
          itemCount: mCategory.length,
          itemBuilder: (context, index) {
            return itemRowWithCategory(mCategory[index]);
          },
        );
      });

  Column itemRowWithCategory(KSCategory ksCategory) {
    return Column(
      children: [
        CategoryTitele(ksCategory),
        SizedBox(
          height: 200,
          child: StreamBuilder<List<KSProduct>>(
            stream: ksCategory.streamProducts(),
            builder: (_, snapshot) {
              if (snapshot.data == null) {
                return Center(child: CircularProgressIndicator());
              }

              List<KSProduct> mProducts = snapshot.data!;

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: mProducts.length,
                itemBuilder: (context, index) {
                  return KSWidget.cardItems(mProducts[index]);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget CategoryTitele(KSCategory ksCategory) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CachedNetworkImage(
                imageUrl: ksCategory.iconImageUrl ?? "",
                width: 30,
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  ksCategory.name ?? "N/A",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SeeAllProduct(
                            category: ksCategory,
                          )));
            },
            child: Text(
              "See more",
              style: TextStyle(color: Colors.blue),
            ),
          )
        ],
      ),
    );
  }

  Widget NavigationBar() {
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
                            .cart
                            .length
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

  appBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(70),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 235, 242, 255),
        ),
        child: SafeArea(
          child: Container(
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    scaffoldKey.currentState?.openDrawer();
                  },
                  icon: KSWidget.iconFrame(Assets.assetsIconsMenu, size: 30),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Kurd Store',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Find anything what you want',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ),
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
                        Assets.assetsIconsFavorite,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
