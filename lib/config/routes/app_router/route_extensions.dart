
import 'package:healthcare/config/routes/app_router/route_params.dart';
import 'package:flutter/cupertino.dart';

extension RouteExtensions on BuildContext {
  @optionalTypeArgs
  Future<T?> pushNamed<T extends Object?>(
    BaseRoute route,
  ) {
    return Navigator.of(this).pushNamed<T>(route.routeName.path, arguments: route);
  }

  @optionalTypeArgs
  String restorablePushNamed<T extends Object?>(
    BaseRoute route,
  ) {
    return Navigator.of(this).restorablePushNamed<T>(route.routeName.path, arguments: route);
  }

  @optionalTypeArgs
  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    BaseRoute route, {
    TO? result,
  }) {
    return Navigator.of(this).pushReplacementNamed<T, TO>(route.routeName.path, arguments: route, result: result);
  }

  @optionalTypeArgs
  String restorablePushReplacementNamed<T extends Object?, TO extends Object?>(
    BaseRoute route, {
    TO? result,
  }) {
    return Navigator.of(this).restorablePushReplacementNamed<T, TO>(route.routeName.path, arguments: route, result: result);
  }

  @optionalTypeArgs
  Future<T?> popAndPushNamed<T extends Object?, TO extends Object?>(
    BaseRoute route, {
    TO? result,
  }) {
    return Navigator.of(this).popAndPushNamed<T, TO>(route.routeName.path, arguments: route, result: result);
  }

  @optionalTypeArgs
  String restorablePopAndPushNamed<T extends Object?, TO extends Object?>(
    BaseRoute route, {
    TO? result,
  }) {
    return Navigator.of(this).restorablePopAndPushNamed<T, TO>(route.routeName.path, arguments: route, result: result);
  }

  @optionalTypeArgs
  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(BaseRoute route, RoutePredicate predicate) {
    return Navigator.of(this).pushNamedAndRemoveUntil<T>(route.routeName.path, predicate, arguments: route);
  }

  @optionalTypeArgs
  String restorablePushNamedAndRemoveUntil<T extends Object?>(BaseRoute route, RoutePredicate predicate) {
    return Navigator.of(this).restorablePushNamedAndRemoveUntil<T>(route.routeName.path, predicate, arguments: route);
  }

  @optionalTypeArgs
  Future<T?> push<T extends Object?>(Route<T> route) {
    return Navigator.of(this).push(route);
  }

  @optionalTypeArgs
  String restorablePush<T extends Object?>(RestorableRouteBuilder<T> routeBuilder, {required BaseRoute route}) {
    return Navigator.of(this).restorablePush(routeBuilder, arguments: route);
  }

  @optionalTypeArgs
  Future<T?> pushReplacement<T extends Object?, TO extends Object?>(BaseRoute<T> route, {TO? result}) {
    return Navigator.of(this).pushReplacement<T, TO>(route.route, result: result);
  }

  @optionalTypeArgs
  String restorablePushReplacement<T extends Object?, TO extends Object?>(RestorableRouteBuilder<T> routeBuilder, {TO? result, required BaseRoute route}) {
    return Navigator.of(this).restorablePushReplacement<T, TO>(routeBuilder, result: result, arguments: route);
  }

  @optionalTypeArgs
  Future<T?> pushAndRemoveUntil<T extends Object?>(BaseRoute<T> newRoute, RoutePredicate predicate) {
    return Navigator.of(this).pushAndRemoveUntil<T>(newRoute.route, predicate);
  }

  @optionalTypeArgs
  String restorablePushAndRemoveUntil<T extends Object?>(RestorableRouteBuilder<T> newRouteBuilder, RoutePredicate predicate, {required BaseRoute route}) {
    return Navigator.of(this).restorablePushAndRemoveUntil<T>(newRouteBuilder, predicate, arguments: route);
  }

  @optionalTypeArgs
  void replace<T extends Object?>({required Route<dynamic> oldRoute, required Route<T> newRoute}) {
    return Navigator.of(this).replace<T>(oldRoute: oldRoute, newRoute: newRoute);
  }

  @optionalTypeArgs
  String restorableReplace<T extends Object?>({required RestorableRouteBuilder<T> newRouteBuilder, required BaseRoute route}) {
    return Navigator.of(this).restorableReplace<T>(oldRoute: route.route, newRouteBuilder: newRouteBuilder, arguments: route);
  }

  @optionalTypeArgs
  void replaceRouteBelow<T extends Object?>({
    required Route<dynamic> anchorRoute,
    required Route<T> newRoute,
  }) {
    return Navigator.of(this).replaceRouteBelow<T>(
      anchorRoute: anchorRoute,
      newRoute: newRoute,
    );
  }

  @optionalTypeArgs
  String restorableReplaceRouteBelow<T extends Object?>({
    required Route<dynamic> anchorRoute,
    required RestorableRouteBuilder<T> newRouteBuilder,
    required BaseRoute route,
  }) {
    return Navigator.of(this).restorableReplaceRouteBelow<T>(
      anchorRoute: anchorRoute,
      newRouteBuilder: newRouteBuilder,
      arguments: route,
    );
  }

  bool get canPop {
    final NavigatorState? navigator = Navigator.maybeOf(this);
    return navigator != null && navigator.canPop();
  }

  @optionalTypeArgs
  Future<bool> maybePop<T extends Object?>([T? result]) {
    return Navigator.of(this).maybePop<T>(result);
  }

  @optionalTypeArgs
  void pop<T extends Object?>([T? result]) {
    Navigator.of(this).pop<T>(result);
  }

  void popUntil(RoutePredicate predicate) {
    Navigator.of(this).popUntil(predicate);
  }

  void removeRoute(BaseRoute route) {
    return Navigator.of(this).removeRoute(route.route);
  }

  void removeRouteBelow(BaseRoute anchorRoute) {
    return Navigator.of(this).removeRouteBelow(anchorRoute.route);
  }
}
