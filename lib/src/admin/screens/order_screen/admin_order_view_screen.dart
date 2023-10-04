import 'package:flutter/material.dart';
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
            KSWidget.rachit(),
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
