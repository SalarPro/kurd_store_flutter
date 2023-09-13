import 'package:flutter/material.dart';

class SalarScreen extends StatefulWidget {
  const SalarScreen({super.key});

  @override
  State<SalarScreen> createState() => _SalarScreenState();
}

class _SalarScreenState extends State<SalarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text('Salar Screen'),
    ));
  }
}
