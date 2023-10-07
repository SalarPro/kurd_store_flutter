// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kurd_store/src/constants/assets.dart';
import 'package:kurd_store/src/helper/ks_helper.dart';
import 'package:kurd_store/src/helper/ks_text_style.dart';
import 'package:kurd_store/src/models/order_model.dart';
import 'package:kurd_store/src/providers/app_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  var nameETC = TextEditingController();
  var phoneETC = TextEditingController(text: "+964 7");
  var cityETC = TextEditingController();
  var addressETC = TextEditingController();
  var noteETC = TextEditingController();

  int _selectedFruit = 0;

  double kItemExtent = 32.0;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Card Screen"),
      ),
      body: Stack(
        children: [
          body(),
          if (isLoading)
            Container(
              color: Colors.black38,
              width: Get.width,
              height: Get.height,
              child: Center(
                child: Lottie.asset(
                  Assets.assetsLottieLottieLoading2,
                  width: 200,
                ),
              ),
            ),
        ],
      ),
    );
  }

  SingleChildScrollView body() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            KSHelper.ksTextfield(
              hintText: 'Name',
              icon: Icons.email,
              controller: nameETC,
            ),
            KSHelper.ksTextfield(
              hintText: 'Phone',
              icon: Icons.phone,
              controller: phoneETC,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                MaskTextInputFormatter(
                    mask: '+964 (7##) ### ####',
                    filter: {"#": RegExp(r'[0-9]')},
                    type: MaskAutoCompletionType.lazy)
              ],
            ),
            GestureDetector(
              onTap: () {
                showDialog();
              },
              child: KSHelper.ksTextfield(
                  hintText: KSHelper.iraqCities[_selectedFruit],
                  icon: Icons.location_city,
                  isEnabled: false),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Delivery cost: ",
                  style: KSTextStyle.dark(12),
                ),
                Text(
                  KSHelper.formatNumber(
                      KSHelper
                          .iraqCitiesPrice[KSHelper.iraqCities[_selectedFruit]],
                      postfix: " IQD"),
                  style: KSTextStyle.dark(12),
                ),
                const SizedBox(
                  width: 16,
                )
              ],
            ),
            KSHelper.ksTextfield(
              hintText: 'Address',
              icon: Icons.location_on,
              controller: addressETC,
            ),
            KSHelper.ksTextfield(
              hintText: 'Note',
              icon: Icons.note_alt_outlined,
              controller: noteETC,
              isMultiLine: true,
            ),
            cartDetails(),
            SizedBox(
              height: 10,
            ),
            submitBtn(),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  Widget cartDetails() {
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
                  Text(
                    KSHelper.formatNumber(
                        Provider.of<AppProvider>(context).totalPrice,
                        postfix: " IQD"),
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
                    KSHelper.formatNumber(
                        Provider.of<AppProvider>(context).discountAmount,
                        postfix: " IQD"),
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
                    'Delivery',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    KSHelper.formatNumber(
                        KSHelper.iraqCitiesPrice[
                            KSHelper.iraqCities[_selectedFruit]],
                        postfix: " IQD"),
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
                    KSHelper.formatNumber(
                        Provider.of<AppProvider>(context)
                                .totalPriceAfterDiscount +
                            (KSHelper.iraqCitiesPrice[
                                    KSHelper.iraqCities[_selectedFruit]] ??
                                0),
                        postfix: " IQD"),
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

  Widget submitBtn() {
    return GestureDetector(
      onTap: () {
        submit();
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
                  padding: EdgeInsets.symmetric(horizontal: 0),
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
                const SizedBox(width: 10),
                Text(
                  "Confirm",
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

  void showDialog() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: CupertinoPicker(
            magnification: 1.22,
            squeeze: 1.2,
            useMagnifier: true,
            itemExtent: kItemExtent,
            // This sets the initial item.
            scrollController: FixedExtentScrollController(
              initialItem: _selectedFruit,
            ),
            // This is called when selected item is changed.
            onSelectedItemChanged: (int selectedItem) {
              setState(() {
                _selectedFruit = selectedItem;
              });
            },
            children:
                List<Widget>.generate(KSHelper.iraqCities.length, (int index) {
              return Center(child: Text(KSHelper.iraqCities[index]));
            }),
          ),
        ),
      ),
    );
  }

  void submit() async {
    //validate data

    if (nameETC.text.trim().isEmpty) {
      KSHelper.showSnackBar("Please enter your name");
      return;
    }

    var phoneNumber = phoneETC.text
        .trim()
        .replaceAll("(", "")
        .replaceAll(")", "")
        .replaceAll(" ", "");

    if (phoneNumber.length != 14) {
      KSHelper.showSnackBar("Please enter your phone, +964 750 123 4567");
      return;
    }

    if (addressETC.text.trim().isEmpty) {
      KSHelper.showSnackBar("Please enter your address");
      return;
    }

    setState(() {
      isLoading = true;
    });
    //send to server
    var order = KSOrder();

    order.uid = Uuid().v4();
    order.userName = nameETC.text;
    order.userPhone = phoneNumber;
    order.userCity = KSHelper.iraqCities[_selectedFruit];
    order.userAddress = addressETC.text;
    order.userNote = noteETC.text;
    order.products = Provider.of<AppProvider>(context, listen: false).cart;
    order.status = "pending";
    order.deliveryPrice =
        KSHelper.iraqCitiesPrice[KSHelper.iraqCities[_selectedFruit]];

    await order.save();

    setState(() {
      isLoading = true;
    });

    Provider.of<AppProvider>(context, listen: false).clearCart();

    Get.back(closeOverlays: true);
    Get.back(closeOverlays: true);
  }
}
