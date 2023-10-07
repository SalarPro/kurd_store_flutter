import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kurd_store/src/admin/screens/login_screen/admin_login_screen.dart';
import 'package:kurd_store/src/admin/screens/products_screen/admin_product_screen.dart';

class Tests extends StatefulWidget {
  const Tests({super.key});

  @override
  State<Tests> createState() => _TestsState();
}

class _TestsState extends State<Tests> {
  PageController controller = PageController(
    initialPage: 0,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              /// [PageView.scrollDirection] defaults to [Axis.horizontal].
              /// Use [Axis.vertical] to scroll vertically.
              controller: controller,
              children: const <Widget>[
                AdminLoginScreen(),
                AdminProductScreen(),
                Center(
                  child: Text('Third Page'),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  controller.previousPage(
                      duration: Duration(milliseconds: 100),
                      curve: Curves.ease);
                },
                child: Text('Previous'),
              ),
              ElevatedButton(
                onPressed: () {
                  controller.animateToPage(0,
                      duration: 0.5.seconds, curve: Curves.easeInOut);
                },
                child: Text('Previous'),
              ),
              ElevatedButton(
                onPressed: () {
                  controller.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease);
                },
                child: Text('Next'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
