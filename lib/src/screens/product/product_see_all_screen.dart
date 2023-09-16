import 'package:flutter/material.dart';
import 'package:kurd_store/src/constants/assets.dart';
import 'package:kurd_store/src/helper/ks_widget.dart';

class SeeAllProduct extends StatefulWidget {
  const SeeAllProduct({super.key});

  @override
  State<SeeAllProduct> createState() => _SeeAllProductState();
}

class _SeeAllProductState extends State<SeeAllProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Clothes"),
        ),
        body: Container(
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              padding: EdgeInsets.all(10),
              itemCount: 11,
              itemBuilder: (BuildContext context, int index) {
                return KSWidget.cardItems2Grid(
                    itemPath: Assets.assetsDummyImagesClothes1,
                    price: '15,000',
                    itemName: 'T-Shirt');
              }),
        ));
  }

  Widget CategoryTitele({
    required final String title,
    required final String iconPath,
    final Function? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              KSWidget.iconFrame(
                iconPath,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              // onTap;
            },
            child: GestureDetector(
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => SeeAllProduct()));
              },
            ),
          )
        ],
      ),
    );
  }

  Widget CardItems({
    required String itemPath,
    required String price,
    required String itemName,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Container(
        padding: EdgeInsets.all(10),
        // height: 185,
        // width: 170,
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
                  height: 80,
                ),
                // SizedBox(
                //   width: 15,
                // ),
                Spacer(),

                KSWidget.iconFrame(Assets.assetsIconsFavorite)
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
                KSWidget.iconFrame(Assets.assetsIconsCart)
              ],
            )
          ],
        ),
      ),
    );
  }
}
