import 'package:flutter/material.dart';
import 'package:peedify/providers/theme_provider.dart';
import 'package:peedify/routes/router_config.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp.router(
          title: 'Peedify',
          theme: themeProvider.theme,
          themeMode: themeProvider.themeMode,
          debugShowCheckedModeBanner: false,
          routerConfig: PeedifyNavigator().router,
        );
      },
    );
  }
}
