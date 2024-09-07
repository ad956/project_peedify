import 'package:flutter/material.dart';
import 'bill_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Peedify"),
          centerTitle: true,
          // backgroundColor: Colors.deepPurple,
        ),
        body: BillDetailsForm());
  }
}
