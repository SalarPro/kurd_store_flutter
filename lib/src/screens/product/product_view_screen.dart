// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:kurd_store/src/constants/assets.dart';
import 'package:kurd_store/src/screens/cart_screen/cart_screen.dart';

class ProductViewScreen extends StatefulWidget {
  const ProductViewScreen({super.key});

  @override
  State<ProductViewScreen> createState() => _ProductViewScreenState();
}

class _ProductViewScreenState extends State<ProductViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kurd Store"),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          imageView(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'T-Shitr',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  '25,000 IQD',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Nike Brand Full Quality',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
                Text(
                  '30,000 IQD',
                  style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      decorationColor: Colors.red,
                      decorationThickness: 2,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          itemCounter(),
          SizedBox(height: 40),
          itemSizes(),
          SizedBox(height: 25),
          itemColors(),
          itemColorsV2(),
          SizedBox(height: 15),
          addToCartBtn(context)
        ],
      )),
    );
  }

  GestureDetector addToCartBtn(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CartScreen()));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            height: 60,
            width: 250,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
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
                        child: Image.asset(Assets.assetsIconsCartAdd),
                      ),
                    ),
                    Text(
                      "Add to card",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )
                  ],
                ),
              ],
            )),
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
        colorCell(Color.fromARGB(255, 119, 195, 13)),
        colorCell(Color.fromARGB(255, 96, 77, 243)),
        colorCell(Color.fromARGB(255, 96, 77, 243)),
        colorCell(Color.fromARGB(255, 202, 24, 173)),
        colorCell(Color.fromARGB(255, 13, 200, 85)),
        colorCell(Color.fromARGB(255, 119, 195, 13)),
        colorCell(Color.fromARGB(255, 96, 77, 243)),
        colorCell(Color.fromARGB(255, 96, 77, 243)),
        colorCell(Color.fromARGB(255, 202, 24, 173)),
        colorCell(Color.fromARGB(255, 13, 200, 85)),
      ],
    );
  }

  Widget itemColorsV2() {
    var colors = [
      Colors.red,
      Color.fromARGB(255, 119, 195, 13),
      Color.fromARGB(255, 96, 77, 243),
      Color.fromARGB(255, 96, 77, 243),
      Color.fromARGB(255, 202, 24, 173),
      Color.fromARGB(255, 13, 200, 85),
      Color.fromARGB(255, 119, 195, 13),
      Color.fromARGB(255, 96, 77, 243),
      Color.fromARGB(255, 96, 77, 243),
      Color.fromARGB(255, 202, 24, 173),
      Color.fromARGB(255, 13, 200, 85),
    ];

    return SizedBox(
      height: 45,
      child: ListView.builder(
          itemCount: colors.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Center(child: colorCell(colors[index])),
            );
          }),
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

  Row itemSizes() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            // height: 40,
            // width: 40,
            padding: EdgeInsets.all(6),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.amber.withOpacity(0),
              border: Border.all(color: Colors.black),
            ),
            child: Text(
              '250 GB',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            height: 40,
            width: 40,
            padding: EdgeInsets.all(3),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.amber.withOpacity(0),
              border: Border.all(color: Colors.red),
            ),
            child: Text(
              'S',
              style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            height: 40,
            width: 40,
            padding: EdgeInsets.all(3),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.amber.withOpacity(0),
              border: Border.all(color: Colors.black),
            ),
            child: Text(
              'M',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Padding itemCounter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.amber.withOpacity(0),
              border: Border.all(color: Colors.black),
            ),
            child: Text(
              '-',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            '2',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            alignment: Alignment.center,
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.amber.withOpacity(0),
              border: Border.all(color: Colors.black),
            ),
            child: Text(
              '+',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget imageView() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Image.asset(Assets.assetsDummyImagesClothes1),
      ),
    );
  }
}
