// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:kurd_store/src/constants/assets.dart';

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
        child: Column(
          children: [
            appBar(),
            kstextfield(title: 'Search', icon: Icons.search),
            CartCheckOut(
                name: 'T-Shirt', images: Assets.assetsDummyImagesClothes1),
            CartCheckOut(
                name: 'Jlket Bchika', images: Assets.assetsDummyImagesClothes2),
            CartCheckOut(
                name: 'Qamis', images: Assets.assetsDummyImagesClothes3),
          ],
        ),
      ),
    );
  }

  //// AppBar
  Widget appBar() {
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
                  'Kurd Store',
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
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AdminProductScreen()));
              },
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
              child: Image.asset(
                Assets.assetsIconsAdd,
              ),
            ),
          ],
        ),
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
    required name,
    required images,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.asset(images),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
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
                  Container(
                    padding: EdgeInsets.all(5),
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black)),
                    child: Image.asset(Assets.assetsIconsRemove),
                  ),
                  SizedBox(height: 80),
                  Container(
                    padding: EdgeInsets.all(5),
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black)),
                    child: Image.asset(Assets.assetsIconsAdd),
                  ),
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
    );
  }
}
