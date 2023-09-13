import 'package:flutter/material.dart';

class KaramScreen extends StatefulWidget {
  const KaramScreen({super.key});

  @override
  State<KaramScreen> createState() => _KaramScreenState();
}

class _KaramScreenState extends State<KaramScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Karam Zeway o"),
      ),
    );
  }
}
