import 'dart:ui';

import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Drawer(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                  topLeft: Radius.circular(40))),
          backgroundColor: Color.fromARGB(255, 54, 54, 54).withOpacity(0.5),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10, top: 20),
                child: Row(
                  children: [
                    Text(
                      'Kurd Store',
                      style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[300]),
                    ),
                    Spacer(),
                    Container(
                      width: 40,
                      height: 40,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(5),
                      child: Image.asset(
                        'assets/images/right_arrow.png',
                        color: Colors.grey[300],
                      ),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(5),
                          child: Image.asset(
                            'assets/images/about.png',
                            color: Colors.grey[300],
                          ),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey),
                          ),
                        ),
                        Text(
                          'About us',
                          style: TextStyle(
                              color: Colors.grey[300],
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(5),
                          child: Image.asset(
                            'assets/images/contact.png',
                            color: Colors.grey[300],
                          ),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey),
                          ),
                        ),
                        Text(
                          'Contact us',
                          style: TextStyle(
                              color: Colors.grey[300],
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(5),
                          child: Image.asset(
                            'assets/images/fq.png',
                            color: Colors.grey[300],
                          ),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey),
                          ),
                        ),
                        Text(
                          'F&Q',
                          style: TextStyle(
                              color: Colors.grey[300],
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(height: 50),
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(5),
                          child: Image.asset(
                            'assets/images/darkmode.png',
                            color: Colors.grey[300],
                          ),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey),
                          ),
                        ),
                        Text(
                          'Dark Mood',
                          style: TextStyle(
                              color: Colors.grey[300],
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(5),
                          child: Image.asset(
                            'assets/images/admin.png',
                            color: Colors.grey[300],
                          ),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey),
                          ),
                        ),
                        Text(
                          'Admin',
                          style: TextStyle(
                              color: Colors.grey[300],
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(height: 100),
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(5),
                          child: Image.asset(
                            'assets/images/version.png',
                            color: Colors.grey[300],
                          ),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey),
                          ),
                        ),
                        Text(
                          'Version 0.0.0 pre alpha',
                          style: TextStyle(
                              color: Colors.grey[300],
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
