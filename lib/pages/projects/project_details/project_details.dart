import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/project_details/components/side_menu.dart';
import 'package:gestion_projets/routing/router.dart';
import 'package:gestion_projets/routing/routes.dart';
import 'package:gestion_projets/services/navigation_service.dart';

import '../../../locator.dart';

class ProjectDetails extends StatelessWidget {
  const ProjectDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: [
        SideMenu(),
        Container(
          width: 1,
          color: dividerColor,
        ),
        Expanded(
            child: Container(
          color: backgroundColor,
          child: Navigator(
            key: locator<NavigationService>().projectDetailsNavigatorKey,
            initialRoute: overviewPageRoute,
            onGenerateRoute: generateRoute,
          ),
        ))
      ],
    ));
  }
}
