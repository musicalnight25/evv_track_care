import 'package:healthcare/config/routes/routes.dart';
import 'package:flutter/material.dart';

import '../../../src/splash/screens/splash_screens.dart';
import 'route_params.dart';

GlobalKey<NavigatorState> get rootNavigatorKey => _rootNavigatorKey;
final _rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  AppRouter._();

  static Route generateRoute(RouteSettings s) {
    int index = Routes.values.indexWhere((element) => element.path == s.name);
    if (index >= 0) {
      return ((s.arguments ?? SplashRoute()) as BaseRoute).route;
    } else {
      return MaterialPageRoute(builder: (context) => ErrorScreen(name: s.name ?? ""));
    }
  }
}

class ErrorScreen extends StatelessWidget {
  final String name;
  const ErrorScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Error 404")),
      body: Center(child: Text("No Screen found named : $name"),),
    );
  }
}
