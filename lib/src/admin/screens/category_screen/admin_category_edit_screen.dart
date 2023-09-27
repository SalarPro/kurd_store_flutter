// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kurd_store/src/constants/assets.dart';
import 'package:kurd_store/src/helper/ks_helper.dart';
import 'package:kurd_store/src/helper/ks_text_style.dart';
import 'package:kurd_store/src/models/category_model.dart';
import 'package:uuid/uuid.dart';

class AdminCategoryEditScreen extends StatefulWidget {
  const AdminCategoryEditScreen({super.key, this.category});

  final KSCategory? category;

  @override
  State<AdminCategoryEditScreen> createState() =>
      _AdminCategoryEditScreenState();
}

class _AdminCategoryEditScreenState extends State<AdminCategoryEditScreen> {
  KSCategory? category;

  bool isLoading = false;

  var nameETC = TextEditingController();

  File? imageFile;
  String? imageUrl;

  bool isUpdate = false;

  @override
  void initState() {
    super.initState();
    if (widget.category != null) {
      category = widget.category;
      nameETC.text = category!.name ?? "";
      isUpdate = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: _bodyLayout,
    );
  }

  get _bodyLayout => Stack(
        children: [
          _body,
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              width: Get.width,
              height: Get.height,
              child: Center(
                child: CircularProgressIndicator(color: Colors.amber),
              ),
            ),
        ],
      );

  get _appBar => AppBar(
        title: Column(children: [
          Text(
            "Kurd Store",
            style: KSTextStyle.dark(24, fontFamily: "roboto"),
          ),
          Text(
            "Admin Name",
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
    Widget? imageWidget;
    if (imageFile != null) {
      imageWidget = Image.file(imageFile!);
    } else if (category?.iconImageUrl != null) {
      imageWidget = CachedNetworkImage(
        imageUrl: category!.iconImageUrl!,
      );
    } else {
      imageWidget = Image.asset(
        Assets.assetsIconsSelectImage,
        scale: 8,
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          Center(
            child: Container(
              height: 280,
              width: 280,
              decoration: BoxDecoration(
                  color: Color(0xffF0F0F0),
                  borderRadius: BorderRadius.circular(20)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: imageWidget,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          selectImageBtn,
          SizedBox(
            height: 15,
          ),
          nameTextField(),
          SizedBox(
            height: 90,
          ),
          saveBtn,
        ],
      ),
    );
  }

  Container nameTextField() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(96, 0, 0, 0)),
          borderRadius: BorderRadius.circular(13)),
      margin: EdgeInsets.all(16),
      child: TextField(
        controller: nameETC,
        decoration: InputDecoration(
            prefixIcon: iconFrame(Assets.assetsIconsName),
            hintText: "Name...",
            hintStyle: KSTextStyle.dark(15,
                fontWeight: FontWeight.w400, fontFamily: "roboto"),
            border: InputBorder.none),
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
      onTap: () {
        pickImage();
      },
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
                style: KSTextStyle.light(18,
                    fontWeight: FontWeight.bold, fontFamily: "roboto"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get saveBtn {
    return GestureDetector(
      onTap: () {
        if (isUpdate) {
          update();
        } else {
          save();
        }
      },
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
                style: KSTextStyle.light(18,
                    fontWeight: FontWeight.bold, fontFamily: "roboto"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void pickImage() async {
    var tempFile = await KSHelper.pickImageFromGallery(cropTheImage: true);
    if (tempFile != null) {
      setState(() {
        imageFile = tempFile;
      });
    }
  }

  save() async {
    //create new
    category = KSCategory();

    if (imageFile == null && category?.iconImageUrl == null) {
      KSHelper.showSnackBar("Please select category image");
      return;
    }

    var categoryName = nameETC.text.trim();
    if (categoryName.isEmpty) {
      KSHelper.showSnackBar("Please enter category name");
      return;
    }

    setState(() {
      isLoading = true;
    });

    if (imageFile != null) {
      category!.iconImageUrl =
          await KSHelper.uploadMedia(imageFile!, 'categories');
    }

    category!.uid = const Uuid().v4();
    category!.name = categoryName;

    await category!.save();

    setState(() {
      isLoading = false;
    });

    Get.back();
  }

  update() async {
    if (imageFile == null && category?.iconImageUrl == null) {
      KSHelper.showSnackBar("Please select category image");
      return;
    }

    var categoryName = nameETC.text.trim();
    if (categoryName.isEmpty) {
      KSHelper.showSnackBar("Please enter category name");
      return;
    }

    setState(() {
      isLoading = true;
    });

    if (imageFile != null) {
      category!.iconImageUrl =
          await KSHelper.uploadMedia(imageFile!, 'categories');
    }

    category!.name = categoryName;

    await category!.update();

    setState(() {
      isLoading = false;
    });

    Get.back();
  }
}
