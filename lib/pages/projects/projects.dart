import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/body/projects_body.dart';
import 'package:gestion_projets/routing/router.dart';
import 'package:gestion_projets/routing/routes.dart';
import 'package:gestion_projets/services/navigation_service.dart';

import '../../locator.dart';



class ProjectsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Navigator(
        key: locator<NavigationService>().navigatorKey2,

        initialRoute: projectListPageRoute,
        onGenerateRoute: generateRoute,
      /* ProjectsPageBody(),*/
    );
  }
}
