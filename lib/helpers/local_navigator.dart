import 'package:flutter/cupertino.dart';
import 'package:gestion_projets/constants/controllers.dart';
import 'package:gestion_projets/routing/router.dart';
import 'package:gestion_projets/routing/routes.dart';

Navigator localNavigator() =>   Navigator(
  key: navigationController.navigatorKey,
  onGenerateRoute: generateRoute,
  initialRoute: dashboardPageRoute,
);