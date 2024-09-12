import 'package:flutter/material.dart';
import 'package:peedify/widgets/empty_state.dart';

class MainContent extends StatelessWidget {
  const MainContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 16),
        Expanded(
          child: EmptyStateWidget(),
        ),
      ],
    );
  }
}
