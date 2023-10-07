import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kurd_store/src/admin/screens/order_screen/admin_order_view_screen.dart';
import 'package:kurd_store/src/admin/screens/products_screen/admin_product_screen.dart';
import 'package:kurd_store/src/constants/assets.dart';
import 'package:kurd_store/src/helper/ks_helper.dart';
import 'package:kurd_store/src/models/order_model.dart';

class AdminOrderScreen extends StatefulWidget {
  const AdminOrderScreen({super.key});

  @override
  State<AdminOrderScreen> createState() => _AdminOrderScreenState();
}

final GlobalKey<ScaffoldState> _key = GlobalKey();

class _AdminOrderScreenState extends State<AdminOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 75),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      KSHelper.ksTextfield(
                          hintText: 'Search', icon: Icons.search),
                      StreamBuilder<List<KSOrder>>(
                          stream: KSOrder.streamAll(),
                          builder: (_, snapshot) {
                            if (snapshot.data == null) {
                              return Center(child: CircularProgressIndicator());
                            }

                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (_, index) {
                                  KSOrder ksOrder = snapshot.data![index];
                                  return orderCellWidget(ksOrder);
                                });
                          })
                    ],
                  ),
                ),
              ),
            ),
          ),
          appBar()
        ],
      ),
    );
  }

  //// AppBar
  Widget appBar() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.only(top: 20),
        color: Colors.white,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Container(
                width: 40,
                height: 40,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(5),
                child: Image.asset(Assets.assetsIconsLeftArrow),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Orders',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Niwar Admin',
                    style: TextStyle(fontSize: 14, color: Colors.grey[400]),
                  ),
                ),
              ],
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AdminProductScreen()));
              },
              child: Container(
                width: 40,
                height: 40,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(5),
                child: Image.asset(Assets.assetsIconsFillter),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey),
                ),
              ),
            ),
            Container(
              width: 40,
              height: 40,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey),
              ),
              child: Image.asset(
                Assets.assetsIconsAdd,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget orderCellWidget(KSOrder ksOrder) {
    return GestureDetector(
      onTap: () {
        Get.to(() => AdminOrderViewScreen(
              order: ksOrder,
            ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.8),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Stack(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: [
                    orderCellProperty(
                        'Order Date', KSHelper.formatDate(ksOrder.createAt)),
                    const SizedBox(height: 6),
                    orderCellProperty(
                        'products', ksOrder.productQuantity.toString()),
                    orderCellProperty(
                        'Quantity', ksOrder.itemsQuantity.toString()),
                    const SizedBox(height: 6),

                    //price
                    orderCellProperty(
                      'Total Products',
                      KSHelper.formatNumber(ksOrder.totalPrice,
                          postfix: " IQD"),
                    ),
                    orderCellProperty(
                      'Total Discounted',
                      KSHelper.formatNumber(ksOrder.discountAmount,
                          postfix: " IQD"),
                    ),
                    orderCellProperty(
                      'After Discount',
                      KSHelper.formatNumber(ksOrder.totalPriceAfterDiscount,
                          postfix: " IQD"),
                    ),
                    orderCellProperty(
                      'Delivery',
                      KSHelper.formatNumber(ksOrder.deliveryPrice ?? 0,
                          postfix: " IQD"),
                    ),
                    orderCellProperty(
                      'Total',
                      KSHelper.formatNumber(
                          ksOrder.totalWithDiscountAndDelivery,
                          postfix: " IQD"),
                    ),
                    const SizedBox(height: 6),
                    orderCellProperty('City', ksOrder.userCity),
                    orderCellProperty('Address', ksOrder.userAddress),
                    orderCellProperty('Name', ksOrder.userName),
                    orderCellProperty('Phone', ksOrder.userPhone),
                    orderCellProperty('Note', ksOrder.userNote),
                  ],
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(14),
                      bottomLeft: Radius.circular(14),
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Text(
                    ksOrder.status ?? 'N/A',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget orderCellProperty(String title, String? value) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                value ?? 'N/A',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        Container(
          height: 0.7,
          color: Colors.white24,
        )
      ],
    );
  }
}
