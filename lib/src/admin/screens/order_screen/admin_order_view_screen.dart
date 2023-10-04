import 'package:flutter/material.dart';
import 'package:kurd_store/src/helper/ks_helper.dart';
import 'package:kurd_store/src/helper/ks_widget.dart';

class AdminOrderViewScreen extends StatefulWidget {
  const AdminOrderViewScreen({super.key});

  @override
  State<AdminOrderViewScreen> createState() => _AdminOrderViewScreenState();
}

class _AdminOrderViewScreenState extends State<AdminOrderViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kurd Store"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // KSWidget.CartCheckOut(KSProduct()),
            // KSWidget.CartCheckOut(KSProduct()),
            // KSWidget.CartCheckOut(KSProduct()),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    rowTitleValue("ID", "#5645641"),
                    rowTitleValue("Products", "2"),
                    rowTitleValue("Quantity", "4"),
                    rowTitleValue("Total", "60,000 IQD"),
                    rowTitleValue("City", "Duhok"),
                    rowTitleValue("Name", "Niwar"),
                    rowTitleValue("Date", "2023/09/12 05/;32 pm"),
                    rowTitleValue("Phone", "+964 750 475 0434"),
                    rowTitleValue("Statuses", "Pending"),
                  ],
                ),
              ),
            ),
            cartDetails(),
            const SizedBox(
              height: 15,
            ),
            KSWidget.adminChangeOrderStateBtn(),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  Widget cartDetails(
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
                    KSHelper.formatNumber(123456, postfix: " IQD"),
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
                  // SizedBox(
                  //   width: 200,
                  // ),
                  Text(
                    KSHelper.formatNumber(123456, postfix: " IQD"),
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
                    KSHelper.formatNumber(123456, postfix: " IQD"),
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

  rowTitleValue(String title, String value) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          ),
        )
      ],
    );
  }
}
