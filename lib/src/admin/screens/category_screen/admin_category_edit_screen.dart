// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kurd_store/src/constants/assets.dart';

class AdminCategoryEditScreen extends StatefulWidget {
  const AdminCategoryEditScreen({super.key});

  @override
  State<AdminCategoryEditScreen> createState() =>
      _AdminCategoryEditScreenState();
}

class _AdminCategoryEditScreenState extends State<AdminCategoryEditScreen> {
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
              ),
              child: IconButton(
                  onPressed: () {},
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
            icon: iconFrameAppBar(
              Assets.assetsIconsLeftArrow,
            ),
          ),
        ),
      );

  get _body {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.all(35),
              margin: EdgeInsets.only(top: 20),
              height: 280,
              width: 280,
              child: Image.asset(
                Assets.assetsIconsSelectImage,
                scale: 8,
              ),
              decoration: BoxDecoration(
                  color: Color(0xffF0F0F0),
                  borderRadius: BorderRadius.circular(20)),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          selectImageBtn,
          SizedBox(
            height: 15,
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: const Color.fromARGB(96, 0, 0, 0)),
                borderRadius: BorderRadius.circular(13)),
            margin: EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: iconFrame(Assets.assetsIconsName),
                  hintText: "Catagory Name...",
                  hintStyle: TextStyle(fontWeight: FontWeight.w400),
                  border: InputBorder.none),
            ),
          ),
          SizedBox(
            height: 90,
          ),
          saveBtn,
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

  Widget iconFrameAppBar(
    String? iconPath,
  ) {
    return Container(
      height: 20,
      width: 20,
      child: Image.asset(iconPath!),
    );
  }

  Widget get selectImageBtn {
    return GestureDetector(
      onTap: () {},
      child: Center(
        child: Container(
          height: 65,
          width: 220,
          decoration: BoxDecoration(
              color: Color.fromARGB(187, 49, 49, 49),
              borderRadius: BorderRadius.circular(25)),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(4),
                height: 35,
                width: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Image.asset(
                  Assets.assetsIconsSelectImageBottun,
                  height: 25,
                  width: 25,
                ),
              ),
              SizedBox(
                width: 25,
              ),
              Text(
                "Select Image",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get saveBtn {
    return GestureDetector(
      onTap: () {},
      child: Center(
        child: Container(
          height: 65,
          width: 180,
          decoration: BoxDecoration(
              color: Color.fromARGB(187, 49, 49, 49),
              borderRadius: BorderRadius.circular(25)),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(4),
                height: 35,
                width: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Image.asset(
                  Assets.assetsIconsSave,
                  height: 25,
                  width: 25,
                ),
              ),
              SizedBox(
                width: 25,
              ),
              Text(
                " Save",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
