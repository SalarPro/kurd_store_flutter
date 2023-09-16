// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

// import 'dart:ui_web';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kurd_store/src/admin/screens/main_screen/admin_main_screen.dart';
import 'package:kurd_store/src/constants/assets.dart';
import 'package:kurd_store/src/helper/ks_widget_omed.dart';
import 'package:kurd_store/src/screens/home_screen/home_screen.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: _body,
    );
  }

  get _appBar => AppBar(
      title: Text(
        "Kurd Store",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [
        Container(
            height: 40,
            width: 40,
            margin: EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                border: Border.all(color: Color.fromARGB(101, 14, 1, 1))),
            child: IconButton(
                onPressed: () {},
                icon: iconFrameAppBar(Assets.assetsIconsUser)))
      ],
      leading: Container(
        margin: EdgeInsets.all(5),
        child: IconButton(
          onPressed: () {},
          icon: iconFrameAppBar(Assets.assetsIconsLeftArrow),
        ),
      ));

  Widget get _body {
    return (SingleChildScrollView(
      child: Column(children: [
        SizedBox(
          height: 20,
        ),
        Center(
          child: Text(
            "Welcome Admin",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 150,
        ),
        emailTextField,
        passwordTextField,
        SizedBox(
          height: 100,
        ),
        loginBtn,
      ]),
    ));
  }

  Widget get emailTextField {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(13)),
      margin: EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
            prefixIcon: iconFrame(Assets.assetsIconsEmail),
            hintText: "Email",
            hintStyle: TextStyle(fontWeight: FontWeight.w400),
            border: InputBorder.none),
      ),
    );
  }

  Widget get passwordTextField {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(13)),
      margin: EdgeInsets.all(16),
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
            prefixIcon: iconFrame(Assets.assetsIconsPassword),
            suffixIcon: iconFrame(Assets.assetsIconsHidePassword),
            hintText: "Password",
            hintStyle: TextStyle(
              fontWeight: FontWeight.w400,
            ),
            border: InputBorder.none),
      ),
    );
  }

  Widget get loginBtn {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AdminMainScreen()));
      },
      child: Center(
        child: Container(
          height: 70,
          width: 170,
          decoration: BoxDecoration(
              color: Color.fromARGB(163, 49, 49, 49),
              borderRadius: BorderRadius.circular(20)),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(4),
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Image.asset(
                  Assets.assetsIconsUserLogin,
                  height: 25,
                  width: 25,
                ),
              ),
              SizedBox(
                width: 25,
              ),
              Text(
                "LOGIN",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              )
            ],
          ),
        ),
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
