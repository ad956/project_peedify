import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline,
                size: 64, color: Theme.of(context).colorScheme.error),
            const SizedBox(height: 16),
            Text("404 Page Not Found",
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pushReplacementNamed('/'),
              child: const Text('Go to Home Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
