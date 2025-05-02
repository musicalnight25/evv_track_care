import 'package:flutter/material.dart';

import '../routes.dart';

abstract interface class BaseRoute<T> {
  final Widget screen;
  final Routes routeName;
  final TransitionType type;

  BaseRoute(this.screen, this.routeName, this.type);
}

enum TransitionType {
  fade,
  slideUp,
  slideLeft,
}

extension GenerateRoute<T> on BaseRoute<T> {
  /// SLIDE UP TRANSITION
  ///
  Route<T> get route => switch (type) {
        TransitionType.fade => PageRouteBuilder<T>(
          settings: RouteSettings(name: routeName.path),
          transitionDuration: const Duration(milliseconds: 400),
            pageBuilder: (context, animation, secondaryAnimation) => FadeTransition(
              opacity: animation,
              child: screen,
            ),
          ),
        TransitionType.slideUp => PageRouteBuilder<T>(
          settings: RouteSettings(name: routeName.path),
          transitionDuration: const Duration(milliseconds: 400),
            pageBuilder: (context, animation, secondaryAnimation) => screen,
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              const begin = Offset(0.0, 1.0); // slide from the bottom
              const end = Offset.zero;
              const curve = Curves.ease;

              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
          ),
        TransitionType.slideLeft => PageRouteBuilder<T>(
          settings: RouteSettings(name: routeName.path),
          transitionDuration: const Duration(milliseconds: 400),
            pageBuilder: (context, animation, secondaryAnimation) => screen,
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0); // slide from the right
              const end = Offset.zero;
              const curve = Curves.easeInOut;

              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
          ),
      };

  /// SIZE TRANSITION
  ///
  Route<T> get route4 => PageRouteBuilder<T>(
    settings: RouteSettings(name: routeName.path),
    transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
            ),
          );
        },
      );

  /// SCALE TRANSITION
  ///
  Route<T> get route5 => PageRouteBuilder<T>(
    settings: RouteSettings(name: routeName.path),
    transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var tween = Tween<double>(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.easeInOut));

          return ScaleTransition(
            scale: animation.drive(tween),
            child: child,
          );
        },
      );
}

class CustomRoute implements BaseRoute {
  final Widget page;
  final Routes routename;
  final TransitionType transition;

  CustomRoute({required this.routename, required this.page, required this.transition});

  @override
  Widget get screen => page;

  @override
  Routes get routeName => routename;

  @override
  TransitionType get type => transition;
}
