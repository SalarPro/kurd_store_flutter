// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:kurd_store/src/admin/screens/category_screen/admin_category_edit_screen.dart';
import 'package:kurd_store/src/admin/screens/category_screen/admin_category_screen.dart';
import 'package:kurd_store/src/constants/assets.dart';
import 'package:kurd_store/src/screens/home_screen/home_screen.dart';

class AdminCategoryScreen extends StatefulWidget {
  const AdminCategoryScreen({super.key});

  @override
  State<AdminCategoryScreen> createState() => _AdminCategoryScreenState();
}

class _AdminCategoryScreenState extends State<AdminCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: _body,
    );
  }

  get _appBar => AppBar(
        title: Column(children: [
          Text(
            "Kurd Store",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            "Admin Name",
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Color(0xff8F8F8F)),
          ),
        ]),
        actions: [
          Container(
              height: 40,
              width: 40,
              margin: EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  border:
                      Border.all(color: const Color.fromARGB(122, 0, 0, 0))),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AdminCategoryEditScreen()));
                  },
                  icon: iconFrameAppBar(Assets.assetsIconsAdd)))
        ],
        leading: Container(
          height: 40,
          width: 40,
          margin: EdgeInsets.all(5),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: iconFrameAppBar(Assets.assetsIconsLeftArrow),
          ),
        ),
      );

  get _body {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5,
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: const Color.fromARGB(108, 0, 0, 0)),
                borderRadius: BorderRadius.circular(8)),
            margin: EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: iconFrame(Assets.assetsIconsSearch),
                  hintText: "Search...",
                  hintStyle: TextStyle(fontWeight: FontWeight.w400),
                  border: InputBorder.none),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => AdminCategoryScreen()));
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AdminCategoryEditScreen()));
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(left: 15),
                    decoration: BoxDecoration(
                        color: Color(0xffF0F0F0),
                        borderRadius: BorderRadius.circular(12)),
                    height: 170,
                    width: 140,
                    child: Image.asset(
                      Assets.assetsIconsClothesProduct,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Text(
                    "Clothes",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AdminCategoryEditScreen()));
                      },
                      child: Container(
                        padding: EdgeInsets.all(4),
                        margin: EdgeInsets.only(left: 80, top: 10),
                        height: 40,
                        width: 40,
                        child: Image.asset(
                          Assets.assetsIconsAdd,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.all(4),
                        margin: EdgeInsets.only(left: 80, top: 70),
                        height: 40,
                        width: 40,
                        child: Image.asset(Assets.assetsIconsRemove,
                            color: Colors.red),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Divider(
            thickness: 1,
            color: const Color.fromARGB(61, 0, 0, 0),
          ),
          GestureDetector(
            onTap: () {},
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(left: 15, top: 10),
                  decoration: BoxDecoration(
                      color: Color(0xffF0F0F0),
                      borderRadius: BorderRadius.circular(12)),
                  height: 170,
                  width: 140,
                  child: Image.asset(
                    Assets.assetsIconsElectronicProduct,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  margin: EdgeInsets.only(top: 25),
                  child: Text(
                    "Electronic",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.all(4),
                        margin: EdgeInsets.only(left: 60, top: 10),
                        height: 40,
                        width: 40,
                        child: Image.asset(
                          Assets.assetsIconsAdd,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.all(4),
                        margin: EdgeInsets.only(left: 60, top: 70),
                        height: 40,
                        width: 40,
                        child: Image.asset(
                          Assets.assetsIconsRemove,
                          color: Colors.red,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Divider(
            thickness: 1,
            color: const Color.fromARGB(61, 0, 0, 0),
          ),
          GestureDetector(
            onTap: () {},
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(left: 15, top: 10),
                  decoration: BoxDecoration(
                      color: Color(0xffF0F0F0),
                      borderRadius: BorderRadius.circular(12)),
                  height: 170,
                  width: 140,
                  child: Image.asset(
                    Assets.assetsIconsCosmeticProduct,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  margin: EdgeInsets.only(top: 25),
                  child: Text(
                    "Cosmetic",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(4),
                      margin: EdgeInsets.only(left: 70, top: 10),
                      height: 40,
                      width: 40,
                      child: Image.asset(
                        Assets.assetsIconsAdd,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.all(4),
                        margin: EdgeInsets.only(left: 70, top: 70),
                        height: 40,
                        width: 40,
                        child: Image.asset(Assets.assetsIconsRemove,
                            color: Colors.red),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Divider(
            thickness: 1,
            color: const Color.fromARGB(61, 0, 0, 0),
          ),
        ],
      ),
    );
  }

  Container iconFrame(
    String? iconPath,
  ) {
    return Container(
      padding: EdgeInsets.all(8),
      height: 20,
      width: 20,
      child: Image.asset(iconPath!),
    );
  }

  Container iconFrameAppBar(
    String? iconPath,
  ) {
    return Container(
      height: 25,
      width: 25,
      child: Image.asset(iconPath!),
    );
  }
}
