// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kurd_store/src/admin/screens/login_screen/admin_login_screen.dart';
import 'package:kurd_store/src/admin/screens/main_screen/admin_main_screen.dart';
import 'package:kurd_store/src/admin/screens/main_screen/test.dart';
import 'package:kurd_store/src/constants/assets.dart';
import 'package:kurd_store/src/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({super.key});

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

final GlobalKey<ScaffoldState> _key = GlobalKey();

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: Drawer(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 41, 41, 41).withOpacity(0.5),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 50, left: 20),
                  child: Row(
                    children: [
                      Text(
                        'Kurd Store',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Container(
                        width: 40,
                        height: 40,
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(5),
                        child: Image.asset(
                          Assets.assetsIconsRightArrow,
                          color: Colors.grey[300],
                        ),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50),
                ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(5),
                    child: Image.asset(
                      Assets.assetsIconsAbout,
                      color: Colors.grey[300],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey),
                    ),
                  ),
                  title: Text(
                    'About us',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {},
                ),
                SizedBox(height: 10),
                ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(5),
                    child: Image.asset(
                      Assets.assetsIconsAbout,
                      color: Colors.grey[300],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey),
                    ),
                  ),
                  title: Text(
                    'Contact us',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {},
                ),
                SizedBox(height: 10),
                ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(5),
                    child: Image.asset(
                      Assets.assetsIconsAbout,
                      color: Colors.grey[300],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey),
                    ),
                  ),
                  title: Text(
                    'F&Q',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Get.to(Tests());
                  },
                ),
                SizedBox(height: 50),
                ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(5),
                    child: Image.asset(
                      Assets.assetsIconsDarkmode,
                      color: Colors.grey[300],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey),
                    ),
                  ),
                  title: Text(
                    'Dark Mood',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {},
                ),
                SizedBox(height: 80),
                ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(5),
                    child: Image.asset(
                      Assets.assetsIconsName,
                      color: Colors.grey[300],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey),
                    ),
                  ),
                  title: Text(
                    'Admin',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    if (Provider.of<AuthProvider>(context, listen: false)
                        .isLogin) {
                      Get.to(() => AdminMainScreen());
                    } else {
                      Get.to(() => AdminLoginScreen());
                    }
                  },
                ),
                SizedBox(height: 80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 25,
                      height: 25,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(5),
                      child: Image.asset(
                        Assets.assetsIconsVersion,
                        color: Colors.grey,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.grey),
                      ),
                    ),
                    Text(
                      'Version 0.0.0 pre alpha',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
