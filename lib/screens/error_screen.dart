import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("404 Page Not Found !!!"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => {},
              child: const Text('Go  to Home Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
