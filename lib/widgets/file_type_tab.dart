import 'package:flutter/material.dart';

class FileTypeTab extends StatelessWidget {
  final String label;
  final bool isSelected;

  const FileTypeTab({Key? key, required this.label, this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.red[100] : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.red : Colors.grey,
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
        padding: const EdgeInsets.symmetric(horizontal: 5),
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
