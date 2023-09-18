// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kurd_store/src/constants/assets.dart';
import 'package:kurd_store/src/helper/ks_widget.dart';

class AdminProductEditScreen extends StatefulWidget {
  const AdminProductEditScreen({super.key});

  @override
  State<AdminProductEditScreen> createState() => _AdminProductEditScreenState();
}

class _AdminProductEditScreenState extends State<AdminProductEditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Card Screen"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom +
                  ((MediaQuery.of(context).padding.bottom > 0 ? 0 : 15)) +
                  60),
          child: Column(
            children: [
              imageSelect(),
              selectImageBTN(),
              kstextfield(title: 'Name', icon: Icons.text_fields_rounded),
              kstextfield(
                  title: 'Description', icon: Icons.description_outlined),
              kstextfield(title: 'Price', icon: Icons.price_change_rounded),
              kstextfield(
                  title: 'Discount Price', icon: Icons.price_change_rounded),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 30,
              ),
              itemColors(),
              Divider(),
              SizedBox(
                height: 30,
              ),
              KSWidget.itemSizes(),
              SizedBox(
                height: 30,
              ),
              DropdownMenuExample(),
              SizedBox(
                height: 30,
              ),
              navigationBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget imageSelect() {
    return Container(
      height: 250,
      width: 250,
      decoration: BoxDecoration(
          color: Color.fromARGB(67, 139, 139, 139),
          borderRadius: BorderRadius.circular(15)),
      child: Center(
          child: Image.asset(
        Assets.assetsIconsSelectImage,
        scale: 5,
      )),
    );
  }

  Widget kstextfield({
    required title,
    required icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 50,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
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

  Widget navigationBar(
      // String? iconPath,
      ) {
    return GestureDetector(
      onTap: () {
        // TODO: SEND DATA TO SERVER
        Get.back();
      },
      child: Center(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            height: 60,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.8),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
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
                    child: Image.asset(Assets.assetsIconsSave),
                  ),
                ),
                Text(
                  "Save",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                )
              ],
            )),
      ),
    );
  }

  Widget selectImageBTN(
      // String? iconPath,
      ) {
    return GestureDetector(
      onTap: () {
        // TODO: SEND DATA TO SERVER
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
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
                      child: Image.asset(Assets.assetsIconsSelectImage),
                    ),
                  ),
                  Text(
                    "Select Image",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  )
                ],
              )),
        ),
      ),
    );
  }

  Widget rachit(
      // String? iconPath,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        // height: 200,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Products',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  // SizedBox(
                  //   width: 200,
                  // ),
                  Text(
                    '100,000 IQD',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Discount',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    '40,000 IQD',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  // SizedBox(
                  //   width: 200,
                  // ),
                  Text(
                    '60,000 IQD',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemColors() {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      runSpacing: 4,
      spacing: 4,
      children: [
        colorCell(Colors.red),
        colorCell(Color.fromARGB(255, 96, 77, 243)),
        colorCell(Color.fromARGB(255, 202, 24, 173)),
        colorCell(Color.fromARGB(255, 119, 195, 13)),
        colorCell(Color.fromARGB(255, 96, 77, 243)),
        colorCell(Color.fromARGB(255, 13, 200, 85)),
        SizedBox(
          width: 25,
        ),
        GestureDetector(
          onTap: () {},
          child: KSWidget.iconFrame(Assets.assetsDummyImagesPlus, size: 25),
        )
      ],
    );
  }

  Widget colorCell(Color color) {
    return Container(
      height: 30,
      width: 30,
      padding: EdgeInsets.all(3),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color.withOpacity(1),
        border: Border.all(color: Colors.white54, width: 3),
      ),
    );
  }
}
