import 'package:flutter/material.dart';
import 'package:peedify/widgets/empty_state.dart';
import 'package:peedify/widgets/file_type_tab.dart';

class MainContent extends StatelessWidget {
  const MainContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        FileTypesTabs(),
        Expanded(
          child: EmptyStateWidget(),
        ),
      ],
    );
  }
}
