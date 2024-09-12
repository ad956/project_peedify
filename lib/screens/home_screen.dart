import 'package:flutter/material.dart';
import 'package:peedify/widgets/app_header.dart';
import 'package:peedify/widgets/available_template.dart';
import 'package:peedify/widgets/empty_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const isEmpty = false;
    return Scaffold(
      appBar: const AppHeader(),
      body: const SafeArea(
        child: Column(
          children: [
            Expanded(
              // ignore: dead_code
              child: isEmpty ? EmptyStateWidget() : AvailableTemplates(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("hey");
        },
        child: const Icon(
          Icons.add_rounded,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
