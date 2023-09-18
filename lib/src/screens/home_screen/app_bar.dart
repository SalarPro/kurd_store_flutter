import 'package:flutter/material.dart';
import 'package:kurd_store/src/constants/assets.dart';

class AppBarScreen extends StatefulWidget {
  const AppBarScreen({super.key});

  @override
  State<AppBarScreen> createState() => _AppBarScreenState();
}

final GlobalKey<ScaffoldState> _key = GlobalKey();

class _AppBarScreenState extends State<AppBarScreen> {
  @override
  Widget build(BuildContext context) {
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
                  _key.currentState!.openDrawer();
                },
                icon: Image.asset(Assets.assetsIconsMenu)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kurd Store',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Find anything what you want!',
                    style: TextStyle(fontSize: 14, color: Colors.grey[400]),
                  ),
                ),
              ],
            ),
            Spacer(),
            Container(
              width: 40,
              height: 40,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(5),
              child: Image.asset(Assets.assetsIconsSearch),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey),
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
              child: Badge(
                textStyle: TextStyle(fontSize: 100),
                backgroundColor: Colors.red,
                child: InkWell(
                  child: Image.asset(
                    Assets.assetsIconsFavorite,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
