import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:peedify/data/local/database.dart';
import 'package:peedify/routes/route_constants.dart';
import 'package:peedify/screens/bill_screen.dart';
import 'package:peedify/screens/error_screen.dart';
import 'package:peedify/screens/home_screen.dart';

class PeedifyNavigator {
  final GoRouter router = GoRouter(
      initialLocation: "/",
      navigatorKey: GlobalKey<NavigatorState>(),
      errorBuilder: ((context, state) => const ErrorScreen()),
      routes: [
        GoRoute(
          name: RouteNames.homeScreen,
          path: "/",
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          name: RouteNames.billScreen,
          path: "/bill",
          pageBuilder: (context, state) {
            final arguments = state.extra as Map<String, dynamic>;
            final template = arguments['template'] as Template;
            final columns = arguments['columns'] as List<TemplateColumn>;

            return CustomTransitionPage(
              key: state.pageKey,
              transitionDuration: const Duration(milliseconds: 1300),
              child: BillScreen(
                template: template,
                templateColumns: columns,
              ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: const Offset(0.0, 0.0),
                  ).animate(animation),
                  child: child,
                );
              },
            );
          },
        ),
      ]);
}
