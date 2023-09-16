import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kurd_store/src/constants/assets.dart';
import 'package:kurd_store/src/screens/product/product_view_screen.dart';

class KSWidget {
  static Widget cardItems({
    required String itemPath,
    required String price,
    required String itemName,
  }) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductViewScreen());
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        child: AspectRatio(
          aspectRatio: 0.8,
          child: Container(
            padding: EdgeInsets.all(10),
            // height: 185,
            // width: Get.width / 2.5,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(right: 25),
                          child: Image.asset(
                            itemPath,
                            // width: Get.width / 4,
                            // height: Get.width / 4,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                itemName,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "$price IQD",
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        iconFrame(Assets.assetsIconsCart)
                      ],
                    )
                  ],
                ),
                Positioned(
                    right: 0,
                    top: 0,
                    child: iconFrame(Assets.assetsIconsFavorite, size: 30))
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget cardItems2Grid({
    required String itemPath,
    required String price,
    required String itemName,
  }) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductViewScreen());
      },
      child: Container(
        height: double.infinity,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(right: 25),
                      child: Image.asset(
                        itemPath,
                        height: 100,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            itemName,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "$price IQD",
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    iconFrame(Assets.assetsIconsCart)
                  ],
                )
              ],
            ),
            Positioned(
                right: 0,
                top: 0,
                child: iconFrame(Assets.assetsIconsFavorite, size: 30))
          ],
        ),
      ),
    );
  }

  static Container iconFrame(String? iconPath, {double size = 30}) {
    return Container(
      padding: EdgeInsets.all(5),
      height: size,
      width: size,
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black)),
      child: Image.asset(iconPath!),
    );
  }
}
