// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:kurd_store/src/constants/assets.dart';
import 'package:kurd_store/src/helper/ks_widget.dart';

class AdminOrderView extends StatefulWidget {
  const AdminOrderView({super.key});

  @override
  State<AdminOrderView> createState() => _AdminOrderViewState();
}

class _AdminOrderViewState extends State<AdminOrderView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kurd Store"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            KSWidget.CartCheckOut(count: false),
            KSWidget.CartCheckOut(count: false),
            KSWidget.CartCheckOut(count: false),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    section1(
                        a: 'Products: ',
                        b: 'Quantity: ',
                        c: 'Total: ',
                        d: 'City: ',
                        e: 'Name: ',
                        f: 'Date: ',
                        g: 'Phone: '),
                    section1(
                        a: '2',
                        b: '4',
                        c: '60.000 IQD',
                        d: 'Duhok',
                        e: 'Niwar',
                        f: '2023/09/12 05:32 pm',
                        g: '+964 750 475 0434'),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        section1(a: "#123456789"),
                        Text(
                          'Pending',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 10),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            KSWidget.rachit(),
            SizedBox(
              height: 15,
            ),
            KSWidget.checkOutBtn(),
          ],
        ),
      ),
    );
  }

  Column section1({
    String? a,
    b,
    c,
    d,
    e,
    f,
    g,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          // 'Products'
          a ?? '',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
        ),
        Text(
          // 'Quantity'
          b ?? '',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
        ),
        Text(
          c ?? ''
          // 'Total'
          ,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
        ),
        Text(
          // 'City'
          d ?? '',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
        ),
        Text(
          // 'Name'
          e ?? '',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
        ),
        Text(
          // 'Date'
          f ?? '',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
        ),
        Text(
          // 'Phone'
          g ?? '',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
        ),
      ],
    );
  }
}
