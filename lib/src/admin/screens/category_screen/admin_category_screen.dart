// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kurd_store/src/admin/screens/category_screen/admin_category_edit_screen.dart';
import 'package:kurd_store/src/constants/assets.dart';
import 'package:kurd_store/src/helper/ks_text_style.dart';
import 'package:kurd_store/src/models/category_model.dart';
import 'package:uuid/uuid.dart';

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
                  hintStyle: KSTextStyle.dark(15,
                      fontWeight: FontWeight.w400, fontFamily: "roboto"),
                  border: InputBorder.none),
            ),
          ),
          StreamBuilder<List<KSCategory>>(
            stream: KSCategory.streamAll(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Center(
                    child: CircularProgressIndicator(
                  color: Colors.red,
                ));
              }

              List<KSCategory> items = snapshot.data!;
              return ReorderableListView(
                onReorder: (oldIndex, newIndex) {
                  var nIndex = oldIndex > newIndex ? newIndex : newIndex - 1;
                  setState(() {
                    var fromIndex = items[oldIndex];
                    items.removeAt(oldIndex);

                    items.insert(nIndex, fromIndex);
                  });

                  var range = (oldIndex - nIndex).abs();
                  var startFrom = min(oldIndex, nIndex);

                  for (var i = startFrom; i <= (startFrom + range); i++) {
                    items[i].orderIndex = i + 1;
                    items[i].update();
                  }
                },
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: items.map((e) => itemCell(e)).toList(),
              );
            },
          )
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

  Widget itemCell(KSCategory ksCategory) {
    return GestureDetector(
      key: Key(ksCategory.uid ?? const Uuid().v4()),
      onTap: () {
        Get.to(() => AdminCategoryEditScreen(
              category: ksCategory,
            ));
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                      color: Color(0xffF0F0F0),
                      borderRadius: BorderRadius.circular(12)),
                  height: 140,
                  width: 140,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: ksCategory.iconImageUrl ?? "",
                      errorWidget: (context, url, error) => Icon(
                        Icons.error,
                        size: 50,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ksCategory.name ?? "",
                        style: KSTextStyle.dark(18,
                            fontWeight: FontWeight.w700, fontFamily: "roboto"),
                      ),
                      Text(
                        "${ksCategory.orderIndex}",
                        style: KSTextStyle.dark(12,
                            fontWeight: FontWeight.w700, fontFamily: "roboto"),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
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
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text("Delete Category!"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Do you want to remove This?"),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    ksCategory.delete();
                                  });
                                  Get.back();
                                },
                                child: Text(
                                  "Yes",
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text("NO"))
                            ],
                          ),
                        );
                      },
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
                const SizedBox(width: 10),
              ],
            ),
            Divider(
              thickness: 1,
              color: const Color.fromARGB(61, 0, 0, 0),
              endIndent: 16,
              indent: 16,
            )
          ],
        ),
      ),
    );
  }
}
