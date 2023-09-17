import 'package:flutter/material.dart';

class AppBarScreen extends StatelessWidget {
  const AppBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(top: 30),
        child: SingleChildScrollView(
          child: Row(
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(5),
                    child: Image.asset(
                      'assets/images/menu.png',
                    ),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kurd Store',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          'Find anything what you want!',
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[400]),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Container(
                width: 40,
                height: 40,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(5),
                child: Image.asset(
                  'assets/images/search.png',
                ),
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
                      'assets/images/notfication.png',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
