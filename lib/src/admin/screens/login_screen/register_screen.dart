import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:kurd_store/src/admin/screens/main_screen/admin_main_screen.dart';
import 'package:kurd_store/src/constants/assets.dart';
import 'package:kurd_store/src/helper/ks_helper.dart';
import 'package:kurd_store/src/helper/ks_text_style.dart';
import 'package:kurd_store/src/helper/ks_widget.dart';
import 'package:kurd_store/src/models/user_model.dart';
import 'package:kurd_store/src/providers/auth_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.code});

  final String code;
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var nameETC = TextEditingController();
  var emailETC = TextEditingController();
  var passwordETC = TextEditingController();
  var confirmPasswordETC = TextEditingController();
  var phoneETC = TextEditingController();

  var isPasswordVisible = false;
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                KSHelper.ksTextfield(
                    hintText: 'Name', controller: nameETC, icon: Icons.person),
                KSHelper.ksTextfield(
                    hintText: 'Phone',
                    controller: phoneETC,
                    icon: Icons.phone,
                    keyboardType: TextInputType.phone),
                KSHelper.ksTextfield(
                    hintText: 'Email',
                    controller: emailETC,
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress),
                Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color.fromARGB(115, 0, 0, 0)),
                      borderRadius: BorderRadius.circular(13)),
                  margin: EdgeInsets.all(16),
                  child: TextField(
                    controller: passwordETC,
                    obscureText: !isPasswordVisible,
                    decoration: InputDecoration(
                        prefixIcon: KSWidget.iconFrame(
                            Assets.assetsIconsPassword,
                            size: 18,
                            hasBorder: false,
                            padding: EdgeInsets.all(10)),
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
                ),
                Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color.fromARGB(115, 0, 0, 0)),
                      borderRadius: BorderRadius.circular(13)),
                  margin: EdgeInsets.all(16),
                  child: TextField(
                    controller: confirmPasswordETC,
                    obscureText: !isPasswordVisible,
                    decoration: InputDecoration(
                        prefixIcon: KSWidget.iconFrame(
                            Assets.assetsIconsPassword,
                            size: 18,
                            hasBorder: false,
                            padding: EdgeInsets.all(10)),
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
                        hintText: "Confirm Password",
                        hintStyle: KSTextStyle.dark(14,
                            fontWeight: FontWeight.w400, fontFamily: "roboto"),
                        border: InputBorder.none),
                  ),
                ),
                registerBtn,
              ],
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black38,
              width: Get.width,
              height: Get.height,
              child: Center(
                child: Lottie.asset(
                  Assets.assetsLottieLottieLoading2,
                  width: 200,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget get registerBtn {
    return GestureDetector(
      onTap: () {
        register();
      },
      child: Center(
        child: Container(
          height: 65,
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
                "REGISTER",
                style: KSTextStyle.light(20,
                    fontWeight: FontWeight.bold, fontFamily: "roboto"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void register() async {
    var name = nameETC.text.trim();
    var email = emailETC.text.trim();
    var password = passwordETC.text;
    var confirmPassword = confirmPasswordETC.text;
    var phone = phoneETC.text.trim();

    if (name.isEmpty) {
      KSHelper.showSnackBar("Please enter your name");
      return;
    }

    if (phone.isEmpty) {
      KSHelper.showSnackBar("Please enter your phone");
      return;
    }

    if (!email.isEmail) {
      KSHelper.showSnackBar("Please enter your email");
      return;
    }

    if (password.length < 6) {
      KSHelper.showSnackBar("Please enter your password");
      return;
    }

    if (password != confirmPassword) {
      KSHelper.showSnackBar("Password and confirm password not match");
      return;
    }

    setState(() {
      isLoading = true;
    });

    var isRegister = await Provider.of<AuthProvider>(context, listen: false)
        .registerWithEmailPassword(email: email, password: password);

    if (isRegister) {
      var userUID =
          Provider.of<AuthProvider>(context, listen: false).fireUser?.uid;

      if (userUID == null) {
        Provider.of<AuthProvider>(context, listen: false).signOut();
      }

      var newUser = UserModel(
        email: email,
        username: name,
        phone: phone,
        uid: userUID,
      );

      await newUser.save();

      await FirebaseFirestore.instance
          .collection('userCode')
          .doc(widget.code)
          .update({
        'used': true,
        'usedByUid': userUID,
        'usedDate': FieldValue.serverTimestamp(),
      });

      Get.off(() => const AdminMainScreen());
    } else {
      print("error 6545");

      setState(() {
        isLoading = true;
      });
    }
  }
}
