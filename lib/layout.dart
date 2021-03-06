import 'package:flutter/material.dart';
import 'package:gestion_projets/routing/router.dart';
import 'package:gestion_projets/routing/routes.dart';
import 'package:gestion_projets/services/navigation_service.dart';
import 'package:gestion_projets/widgets/top_nav.dart';

import 'locator.dart';


class SiteLayout extends StatelessWidget {

  const SiteLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: topNavigationBar(context),
        body: Navigator(
          key: locator<NavigationService>().navigatorKey,
          initialRoute: projectsPageRoute,
          onGenerateRoute: generateRoute,
        ));
  }
}
