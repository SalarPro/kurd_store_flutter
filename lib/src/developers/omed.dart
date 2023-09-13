import 'package:flutter/material.dart';

class OmedScreen extends StatefulWidget {
  const OmedScreen({super.key});

  @override
  State<OmedScreen> createState() => _OmedScreenState();
}

class _OmedScreenState extends State<OmedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Omed Screen"),
      ),
    );
  }
}
