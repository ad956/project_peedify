import 'package:flutter/material.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.description, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text('No files here', style: TextStyle(color: Colors.grey)),
          SizedBox(height: 8),
          Text('Tap on + to choose file', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
