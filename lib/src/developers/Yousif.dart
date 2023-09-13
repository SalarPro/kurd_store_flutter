import 'package:flutter/material.dart';

class YousifScreen extends StatefulWidget {
  const YousifScreen({super.key});

  @override
  State<YousifScreen> createState() => _YousifScreenState();
}

class _YousifScreenState extends State<YousifScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.grey,
      body: Center(child: Text("Yousif Screen")),

    );
  }
}
