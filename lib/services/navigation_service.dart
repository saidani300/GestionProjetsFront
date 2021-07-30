import 'package:flutter/material.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/data/event.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> navigatorKey2 = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> projectDetailsNavigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> eventNavigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> objectiveNavigatorKey = GlobalKey<NavigatorState>();


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

  Future<dynamic> eventNavigateTo(String routeName , Object event) {
    return eventNavigatorKey.currentState!.pushNamed(routeName , arguments: event );
  }

  Future<dynamic> objectiveNavigateTo(String routeName , Object indicator) {
    return objectiveNavigatorKey.currentState!.pushNamed(routeName , arguments: indicator );
  }
  void objectiveGoBack() {
    return objectiveNavigatorKey.currentState!.pop();
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
