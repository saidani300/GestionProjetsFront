import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/routing/router.dart';
import 'package:gestion_projets/routing/routes.dart';
import 'package:gestion_projets/services/navigation_service.dart';

import '../../../../locator.dart';

class ProjectObjectives extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      child: Navigator(
        key: locator<NavigationService>().objectiveNavigatorKey,
        initialRoute: objectivesListPageRoute,
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
