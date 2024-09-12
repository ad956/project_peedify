import 'package:flutter/material.dart';
import 'package:peedify/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          elevation: Theme.of(context).appBarTheme.elevation,
          leading: Icon(Icons.settings,
              color: Theme.of(context).appBarTheme.foregroundColor),
          title: Text(
            'Peedify',
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(
                themeProvider.themeMode == ThemeMode.dark
                    ? Icons.light_mode
                    : Icons.dark_mode,
                color: Theme.of(context).appBarTheme.foregroundColor,
              ),
              onPressed: () {
                themeProvider.toggleTheme();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
