import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const ActionButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(16),
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          ),
          child: Icon(icon,
              color: Theme.of(context).colorScheme.onSecondaryContainer),
        ),
        const SizedBox(height: 8),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ActionButton(
              icon: Icons.file_open, label: 'Open file', onPressed: () {}),
          ActionButton(
              icon: Icons.camera_alt, label: 'Open camera', onPressed: () {}),
          ActionButton(
              icon: Icons.photo_library,
              label: 'Open gallery',
              onPressed: () {}),
        ],
      ),
    );
  }
}
