import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kurd_store/src/helper/ks_helper.dart';
import 'package:kurd_store/src/helper/ks_text_style.dart';
import 'package:kurd_store/src/models/order_model.dart';
import 'package:kurd_store/src/models/product_model.dart';

class AdminOrderViewScreen extends StatefulWidget {
  const AdminOrderViewScreen({super.key, required this.order});

  final KSOrder order;

  @override
  State<AdminOrderViewScreen> createState() => _AdminOrderViewScreenState();
}

class _AdminOrderViewScreenState extends State<AdminOrderViewScreen> {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kurd Store"),
      ),
      body: StreamBuilder<KSOrder>(
        stream: KSOrder.streamByUID(widget.order.uid),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          }
          var ksOrder = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      children: [
                        rowTitleValue(
                          'Tracking number',
                          KSHelper.formatTracingNumber(ksOrder.trackingNumber),
                        ),
                        rowTitleValue('Order Date',
                            KSHelper.formatDate(ksOrder.createAt)),
                        rowTitleValue('Last update',
                            KSHelper.formatDate(ksOrder.updateAt)),
                        const SizedBox(height: 6),
                        rowTitleValue(
                            'products', ksOrder.productQuantity.toString()),
                        rowTitleValue(
                            'Quantity', ksOrder.itemsQuantity.toString()),
                        const SizedBox(height: 6),
                        rowTitleValue('City', ksOrder.userCity),
                        rowTitleValue('Address', ksOrder.userAddress),
                        rowTitleValue('Name', ksOrder.userName),
                        rowTitleValue('Phone', ksOrder.userPhone),
                        rowTitleValue('Note', ksOrder.userNote),
                      ],
                    ),
                  ),
                ),
                cartDetails(ksOrder),
                const SizedBox(
                  height: 15,
                ),
                adminChangeOrderStateBtn(ksOrder),
                const SizedBox(
                  height: 15,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).padding.bottom +
                          ((MediaQuery.of(context).padding.bottom > 0
                              ? 0
                              : 15)) +
                          70 +
                          120),
                  itemCount: ksOrder.products?.length ?? 0,
                  itemBuilder: (_, index) {
                    return CartCheckOut(ksOrder.products![index]);
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget CartCheckOut(KSProduct product) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: CachedNetworkImage(
                  imageUrl: product.imageUrl ?? "",
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name ?? "N/A",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (product.selectedColor != null)
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Color(product.selectedColor!),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white54, width: 3),
                        ),
                      ),
                    if (product.selectedSize != null)
                      Text(
                        product.selectedSize ?? "",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    if (product.isDiscounted)
                      Text(
                        KSHelper.formatNumber(product.price, postfix: " IQD"),
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Colors.red,
                            decorationThickness: 2,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                    if (!product.isDiscounted)
                      Text(
                        KSHelper.formatNumber(product.price, postfix: " IQD"),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    if (product.isDiscounted)
                      Text(
                        KSHelper.formatNumber(product.priceDiscount,
                            postfix: " IQD"),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    Text(
                      KSHelper.formatNumber(product.totalPriceAfterDiscount,
                          postfix: " IQD"),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "x${product.quantity}",
                    style: KSTextStyle.dark(30),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ],
          ),
        ),
        Divider(
          color: Colors.grey,
          height: 2,
          endIndent: 10,
          indent: 10,
        ),
      ],
    );
  }

  Widget adminChangeOrderStateBtn(KSOrder ksOrder) {
    return GestureDetector(
      onTap: () {
        showStatusDialog(ksOrder);
      },
      child: Container(
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
                    const SizedBox(
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
                    ksOrder.status?.toString().capitalize ?? "N/A",
                    style: KSTextStyle.light(20),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget cartDetails(KSOrder ksOrder) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
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
                  const Text(
                    'Total Products',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    KSHelper.formatNumber(ksOrder.totalPrice, postfix: " IQD"),
                    style: const TextStyle(
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
                  const Text(
                    'Total Discounted',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    KSHelper.formatNumber(ksOrder.discountAmount,
                        postfix: " IQD"),
                    style: const TextStyle(
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
                  const Text(
                    'After Discount',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    KSHelper.formatNumber(ksOrder.totalPriceAfterDiscount,
                        postfix: " IQD"),
                    style: const TextStyle(
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
                  const Text(
                    'Delivery',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    KSHelper.formatNumber(ksOrder.deliveryPrice ?? 0,
                        postfix: " IQD"),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    KSHelper.formatNumber(ksOrder.totalWithDiscountAndDelivery,
                        postfix: " IQD"),
                    style: const TextStyle(
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

  rowTitleValue(String title, String? value) {
    return GestureDetector(
      onTap: () {
        if (value != null) {
          HapticFeedback.mediumImpact();
          Clipboard.setData(ClipboardData(text: value));

          KSHelper.showSnackBar("$title copied");
        }
      },
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              value ?? "N/A",
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
            ),
          )
        ],
      ),
    );
  }

  void showStatusDialog(KSOrder ksOrder) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog.adaptive(
              title: const Text("Change order status"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ksOrder.status = "pending";
                    ksOrder.update();
                    setState(() {});
                  },
                  child: const Text("Pending"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ksOrder.status = "processing";
                    ksOrder.update();
                    setState(() {});
                  },
                  child: const Text("Processing"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ksOrder.status = "delivering";
                    ksOrder.update();
                    setState(() {});
                  },
                  child: const Text("Delivering"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ksOrder.status = "completed";
                    ksOrder.update();
                    setState(() {});
                  },
                  child: const Text("Completed"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ksOrder.status = "canceled";
                    ksOrder.update();
                    setState(() {});
                  },
                  child: const Text("Canceled"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Back"),
                ),
              ],
            ));
  }
}
