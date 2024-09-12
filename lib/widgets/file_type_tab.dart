import 'package:flutter/material.dart';

class FileTypeTab extends StatelessWidget {
  final String label;
  final bool isSelected;

  const FileTypeTab({Key? key, required this.label, this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: isSelected
            ? Theme.of(context).colorScheme.primaryContainer
            : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected
              ? Theme.of(context).colorScheme.onPrimaryContainer
              : Theme.of(context).colorScheme.onSurface,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}

class FileTypesTabs extends StatelessWidget {
  const FileTypesTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: const [
          FileTypeTab(label: 'RECENTS', isSelected: true),
          FileTypeTab(label: 'DOC'),
          FileTypeTab(label: 'DOCX'),
          FileTypeTab(label: 'PDF'),
          FileTypeTab(label: 'JPG'),
          FileTypeTab(label: 'PNG'),
        ],
      ),
    );
  }
}
