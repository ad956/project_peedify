import 'package:flutter/material.dart';
import 'package:peedify/data/local/database_provider.dart';
import 'package:peedify/data/local/template_repository.dart';
import 'package:peedify/providers/template_provider.dart';
import 'package:peedify/providers/theme_provider.dart';
import 'package:peedify/routes/router_config.dart';
import 'package:provider/provider.dart';

void main() {
  final database = constructDb();
  final repository = TemplateRepository(database);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => TemplateNotifier(repository)),
      ],
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
          theme: themeProvider.lightTheme,
          darkTheme: themeProvider.darkTheme,
          themeMode: themeProvider.themeMode,
          debugShowCheckedModeBanner: false,
          routerConfig: PeedifyNavigator().router,
          builder: (context, child) {
            themeProvider.setSystemUIOverlayStyle(context);
            return child!;
          },
        );
      },
    );
  }
}
