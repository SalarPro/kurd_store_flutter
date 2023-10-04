import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kurd_store/src/constants/assets.dart';
import 'package:kurd_store/src/helper/ks_helper.dart';
import 'package:kurd_store/src/helper/ks_text_style.dart';
import 'package:kurd_store/src/models/product_model.dart';
import 'package:kurd_store/src/providers/app_provider.dart';
import 'package:kurd_store/src/screens/checkout_screen/checkout_screen.dart';
import 'package:kurd_store/src/screens/product/product_view_screen.dart';
import 'package:provider/provider.dart';

class KSWidget {
  static Widget cardItems(
    KSProduct product,
  ) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductViewScreen(product: product));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        child: AspectRatio(
          aspectRatio: 0.8,
          child: Container(
            padding: EdgeInsets.all(10),
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
                          padding: const EdgeInsets.only(right: 25),
                          child: CachedNetworkImage(
                              imageUrl: product.imageUrl ?? ""),
                        ),
                      ),
                    ),
                    const SizedBox(
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
                                product.name ?? "N/A",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                KSHelper.formatNumber(product.price,
                                    postfix: " IQD"),
                                maxLines: 1,
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        iconFrame(
                          Assets.assetsIconsPlus,
                          onTap: () {
                            if ((product.sizes?.length ?? 0) > 1 ||
                                (product.colors?.length ?? 0) > 1) {
                              Get.to(() => ProductViewScreen(product: product));
                            } else {
                              product.quantity = 1;

                              // null or ["red"]
                              product.selectedColor =
                                  product.colors?.firstOrNull;
                              product.selectedSize = product.sizes?.firstOrNull;

                              Provider.of<AppProvider>(Get.context!,
                                      listen: false)
                                  .addToCart(product);
                            }
                          },
                        )
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

  static Widget cardItems2Grid(KSProduct ksProduct) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ProductViewScreen(product: ksProduct));
      },
      child: Container(
        height: double.infinity,
        padding: const EdgeInsets.all(8),
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
                      padding: const EdgeInsets.only(right: 25),
                      child: CachedNetworkImage(
                        imageUrl: ksProduct.imageUrl ?? "",
                        height: 100,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
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
                            ksProduct.name ?? "N/A",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            KSHelper.formatNumber(ksProduct.price),
                            maxLines: 1,
                            style: const TextStyle(
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

  static Widget iconFrame(String? iconPath,
      {double size = 30,
      bool hasBorder = true,
      EdgeInsets? padding,
      EdgeInsets? margin,
      Function()? onTap,
      Color? color}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? EdgeInsets.all(5),
        margin: margin,
        height: size,
        width: size,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0),
            borderRadius: BorderRadius.circular(10),
            border:
                hasBorder ? Border.all(color: color ?? Colors.black) : null),
        child: Image.asset(
          iconPath!,
          color: color,
        ),
      ),
    );
  }

  static Widget itemSizes(List<String> sizes,
      {Function(String)? onSizeSelected, String? selectedValue}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (String sizeText in sizes)
          GestureDetector(
              onTap: () {
                if (onSizeSelected != null) {
                  onSizeSelected(sizeText);
                }
              },
              child: sizeCell(sizeText, selectedValue)),
      ],
    );
  }

  static Padding sizeCell(String sizeString, String? selectedValue) {
    var isSelected = sizeString == selectedValue;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        constraints: const BoxConstraints(minWidth: 35),
        padding: const EdgeInsets.all(6),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.green.withOpacity(isSelected ? 0.5 : 0),
          border: Border.all(color: Colors.black),
        ),
        child: Text(
          sizeString,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  static Widget checkOutBtn() {
    return GestureDetector(
      onTap: () {
        Get.to(CheckOutScreen());
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
                    child: Image.asset(Assets.assetsIconsCartConfirm),
                  ),
                ),
                Text(
                  "Check Out",
                  style: KSTextStyle.light(15, fontWeight: FontWeight.bold),
                )
              ],
            )),
      ),
    );
  }

  static Widget adminChangeOrderStateBtn() {
    return Container(
      width: Get.width / 1.5,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Change",
                    style: KSTextStyle.light(14),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: Get.width / 2.1,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Center(
                  child: Text(
                    "Pending",
                    style: KSTextStyle.light(20),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
