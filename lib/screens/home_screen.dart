import 'package:flutter/material.dart';
import 'package:peedify/widgets/app_header.dart';
import 'package:peedify/widgets/bottom_navigation.dart';
import 'package:peedify/widgets/main_content.dart';
import 'bill_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const isEmpty = true;
    return Scaffold(
      appBar: const AppHeader(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              // ignore: dead_code
              child: isEmpty ? const MainContent() : BillDetailsForm(),
            ),
            const BottomNavBar(),
          ],
        ),
      ),
    );
  }
}
