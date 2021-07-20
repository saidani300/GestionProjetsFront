import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> navigatorKey2 = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> projectDetailsNavigatorKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> eventNavigatorKey =
      GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName);
  }

  Future<dynamic> projectNavigateTo(String routeName) {
    return navigatorKey2.currentState!.pushNamed(routeName);
  }

  Future<dynamic> projectDetailsNavigateTo(String routeName) {
    return projectDetailsNavigatorKey.currentState!
        .pushReplacementNamed(routeName);
  }

  Future<dynamic> eventNavigateTo(String routeName) {
    return eventNavigatorKey.currentState!.pushNamed(routeName);
  }

  void eventGoBack() {
    return eventNavigatorKey.currentState!.pop();
  }

  void projectDetailsGoBack() {
    return projectDetailsNavigatorKey.currentState!.pop();
  }

  void projectGoBack() {
    return navigatorKey2.currentState!.pop();
  }

  void goBack() {
    return navigatorKey.currentState!.pop();
  }
}
