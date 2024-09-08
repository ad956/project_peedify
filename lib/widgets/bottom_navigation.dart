import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add file'),
        BottomNavigationBarItem(icon: Icon(Icons.build), label: 'Tools'),
      ],
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.grey,
    );
  }
}
