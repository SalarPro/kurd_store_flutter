import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Niwar extends StatefulWidget {
  const Niwar({super.key});

  @override
  State<Niwar> createState() => _NiwarState();
}

class _NiwarState extends State<Niwar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Niwar')),
    );
  }
}
