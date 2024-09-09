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
      selectedItemColor: const Color.fromRGBO(30, 90, 255, 0.5),
      unselectedItemColor: Colors.grey,
    );
  }
}
