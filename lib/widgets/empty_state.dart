import 'package:flutter/material.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.description,
              size: 64, color: Theme.of(context).colorScheme.secondary),
          const SizedBox(height: 16),
          Text('No templates here',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text('Tap on + to choose file',
              style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
