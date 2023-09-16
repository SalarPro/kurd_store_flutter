import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kurd_store/src/constants/assets.dart';

class KSWidget {
  static Widget cardItems({
    required String itemPath,
    required String price,
    required String itemName,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
      child: AspectRatio(
        aspectRatio: 0.8,
        child: Container(
          padding: EdgeInsets.all(10),
          height: 185,
          width: Get.width / 2.5,
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    itemPath,
                    height: 100,
                  ),
                  // SizedBox(
                  //   width: 15,
                  // ),
                  Spacer(),

                  iconFrame(Assets.assetsIconsFavorite)
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        itemName,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "$price IQD",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   width: 35,
                  // ),
                  Spacer(),
                  iconFrame(Assets.assetsIconsCart)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  static Container iconFrame(
    String? iconPath,
  ) {
    return Container(
      padding: EdgeInsets.all(5),
      height: 35,
      width: 35,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black)),
      child: Image.asset(iconPath!),
    );
  }
}
