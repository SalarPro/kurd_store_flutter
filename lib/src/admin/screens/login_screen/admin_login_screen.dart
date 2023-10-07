// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kurd_store/src/admin/screens/login_screen/register_screen.dart';
import 'package:kurd_store/src/admin/screens/main_screen/admin_main_screen.dart';
import 'package:kurd_store/src/constants/assets.dart';
import 'package:kurd_store/src/helper/ks_helper.dart';
import 'package:kurd_store/src/helper/ks_text_style.dart';
import 'package:kurd_store/src/helper/ks_widget.dart';
import 'package:kurd_store/src/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  bool isPasswordVisible = false;

  var emailETC = TextEditingController();
  var passwordETC = TextEditingController();

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
        style: KSTextStyle.dark(24, fontFamily: "roboto"),
      ),
      actions: [
        KSWidget.iconFrame(Assets.assetsIconsUser,
            size: 35, onTap: () {}, margin: EdgeInsets.all(8))
      ],
      leading:
          KSWidget.iconFrame(Assets.assetsIconsLeftArrow, size: 35, onTap: () {
        Get.back();
      }, margin: EdgeInsets.all(8), padding: EdgeInsets.all(8)));

  Widget get _body {
    return (SingleChildScrollView(
      child: Column(children: [
        SizedBox(
          height: 20,
        ),
        Center(
          child: Text(
            "Welcome Admin",
            style: KSTextStyle.dark(40,
                fontWeight: FontWeight.bold, fontFamily: "roboto"),
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
          border: Border.all(color: const Color.fromARGB(113, 0, 0, 0)),
          borderRadius: BorderRadius.circular(13)),
      margin: EdgeInsets.all(16),
      child: TextField(
        controller: emailETC,
        decoration: InputDecoration(
            prefixIcon: KSWidget.iconFrame(Assets.assetsIconsEmail,
                hasBorder: false, padding: EdgeInsets.all(10)),
            hintText: "Email",
            hintStyle: KSTextStyle.dark(14,
                fontWeight: FontWeight.w400, fontFamily: "roboto"),
            border: InputBorder.none),
      ),
    );
  }

  Widget get passwordTextField {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(115, 0, 0, 0)),
          borderRadius: BorderRadius.circular(13)),
      margin: EdgeInsets.all(16),
      child: TextField(
        controller: passwordETC,
        obscureText: !isPasswordVisible,
        decoration: InputDecoration(
            prefixIcon: KSWidget.iconFrame(Assets.assetsIconsPassword,
                size: 18, hasBorder: false, padding: EdgeInsets.all(10)),
            suffixIcon: KSWidget.iconFrame(
              Assets.assetsIconsHidePassword,
              size: 18,
              hasBorder: false,
              padding: EdgeInsets.all(10),
              onTap: () {
                setState(
                  () {
                    isPasswordVisible = !isPasswordVisible;
                  },
                );
              },
              color: isPasswordVisible ? Colors.red : null,
            ),
            hintText: "Password",
            hintStyle: KSTextStyle.dark(14,
                fontWeight: FontWeight.w400, fontFamily: "roboto"),
            border: InputBorder.none),
      ),
    );
  }

  Widget get loginBtn {
    return GestureDetector(
      onTap: () {
        login();
      },
      child: Center(
        child: Container(
          height: 65,
          width: 170,
          decoration: BoxDecoration(
              color: Color.fromARGB(187, 49, 49, 49),
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
                style: KSTextStyle.light(20,
                    fontWeight: FontWeight.bold, fontFamily: "roboto"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login() async {
    if (emailETC.text == "admin@admin.admin") {
      checkTheCodeToRegister(passwordETC.text);
      return;
    }

    var email = emailETC.text;
    var password = passwordETC.text;
    if (!email.isEmail) {
      KSHelper.showSnackBar("Wrong Email");
      return;
    }
    if (password.length < 6) {
      KSHelper.showSnackBar("Wrong Password");
      return;
    }

    var isLoggedIn = await Provider.of<AuthProvider>(context, listen: false)
        .loginWithEmailPassword(email: email, password: password);

    if (isLoggedIn) {
      Get.off(() => AdminMainScreen());
    } else {}
  }

  checkTheCodeToRegister(String code) async {
    var docs =
        await FirebaseFirestore.instance.collection('userCode').doc(code).get();

    if (docs.exists && docs.data() != null && docs.data()!['used'] == false) {
      //register screen
      Get.off(() => RegisterScreen(code: code));
    } else {
      KSHelper.showSnackBar("Wrong Code");
    }
  }
}
