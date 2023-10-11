// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kurd_store/src/admin/screens/category_screen/admin_category_screen.dart';
import 'package:kurd_store/src/admin/screens/order_screen/admin_order_screen.dart';
import 'package:kurd_store/src/admin/screens/products_screen/admin_product_screen.dart';
import 'package:kurd_store/src/constants/assets.dart';
import 'package:kurd_store/src/helper/ks_helper.dart';
import 'package:kurd_store/src/helper/ks_notify.dart';
import 'package:kurd_store/src/helper/ks_text_style.dart';
import 'package:kurd_store/src/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({super.key});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: _body,
    );
  }

  get _appBar => AppBar(
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Kurd Store",
            style: KSTextStyle.dark(24, fontFamily: "roboto"),
          ),
          Text(
            Provider.of<AuthProvider>(context).user?.username?.toString() ?? "",
            style: KSTextStyle.dark(17,
                fontWeight: FontWeight.w400, fontFamily: "roboto"),
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
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog.adaptive(
                              title: Text("Logout"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Cancel")),
                                TextButton(
                                    onPressed: () {
                                      Provider.of<AuthProvider>(context,
                                              listen: false)
                                          .signOut();
                                      Navigator.pop(context);
                                      Get.offAll(() => AdminMainScreen());
                                    },
                                    child: Text("Logout"))
                              ],
                            ));
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
                  hintStyle: KSTextStyle.dark(15,
                      fontWeight: FontWeight.w400, fontFamily: "roboto"),
                  border: InputBorder.none),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          mainCellCategory(),
          SizedBox(
            height: 15,
          ),
          Divider(
            thickness: 1,
            color: const Color.fromARGB(61, 0, 0, 0),
          ),
          mainCellProduct(),
          SizedBox(
            height: 15,
          ),
          Divider(
            thickness: 1,
            color: const Color.fromARGB(61, 0, 0, 0),
          ),
          mainCellOrder(),
          SizedBox(
            height: 15,
          ),
          Divider(
            thickness: 1,
            color: const Color.fromARGB(61, 0, 0, 0),
          ),
          ElevatedButton(
              onPressed: () {
                KSNotify.snedNotificatoinToTopic(
                    "Hello", "Im body", 'all_user');
              },
              child: Text("Send Notification")),
          ElevatedButton(
            onPressed: () async {
              String code = KSHelper.generateRandomString(6); //ABC123

              while (await FirebaseFirestore.instance
                  .collection('userCode')
                  .doc(code)
                  .get()
                  .then((value) => value.exists)) {
                code = KSHelper.generateRandomString(6);
              }

              await FirebaseFirestore.instance
                  .collection('userCode')
                  .doc(code)
                  .set({
                'used': false,
                'usedByUid': null,
                'usedDate': null,
                'createAt': DateTime.now(),
              });

              // ignore: use_build_context_synchronously
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        title: Text("User code"),
                        content: Text(code),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Clipboard.setData(ClipboardData(text: code));
                                Navigator.pop(context);
                                HapticFeedback.mediumImpact();
                                KSHelper.showSnackBar("$code Copied");
                              },
                              child: Text("Copy"))
                        ],
                      ));
            },
            child: Text("Make new User code"),
          ),
        ],
      ),
    );
  }

  GestureDetector mainCellOrder() {
    return GestureDetector(
      onTap: () {
        Get.to(() => AdminOrderScreen());
      },
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
              Assets.assetsIconsOrder,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            margin: EdgeInsets.only(top: 25),
            child: Text(
              "Order",
              style: KSTextStyle.dark(18,
                  fontWeight: FontWeight.w700, fontFamily: "roboto"),
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector mainCellProduct() {
    return GestureDetector(
      onTap: () {
        Get.to(() => AdminProductScreen());
      },
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
              Assets.assetsIconsProduct,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            margin: EdgeInsets.only(top: 25),
            child: Text(
              "Product",
              style: KSTextStyle.dark(18,
                  fontWeight: FontWeight.w700, fontFamily: "roboto"),
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector mainCellCategory() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AdminCategoryScreen()));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(left: 15),
            decoration: BoxDecoration(
                color: Color(0xffF0F0F0),
                borderRadius: BorderRadius.circular(12)),
            height: 170,
            width: 140,
            child: Image.asset(
              Assets.assetsIconsCatagory,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            child: Text(
              "Category",
              style: KSTextStyle.dark(18,
                  fontWeight: FontWeight.w700, fontFamily: "roboto"),
            ),
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
