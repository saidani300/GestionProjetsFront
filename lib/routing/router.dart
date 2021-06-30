import 'package:flutter/material.dart';
import 'package:gestion_projets/pages/activities/activities.dart';
import 'package:gestion_projets/pages/dashboard/dashboard.dart';
import 'package:gestion_projets/pages/projects/projects.dart';
import 'package:gestion_projets/pages/tasks/tasks.dart';
import 'package:gestion_projets/routing/routes.dart';

Route<dynamic> generateRoute(RouteSettings settings){
  switch (settings.name) {
    case dashboardPageRoute:
      return _getPageRoute(DashboardPage());
    case projectsPageRoute:
      return _getPageRoute(ProjectsPage());
    case tasksPageRoute:
      return _getPageRoute(TasksPage());
    case activitiesPageRoute:
      return _getPageRoute(ActivitiesPage());
    default:
      return _getPageRoute(DashboardPage());

  }
}

PageRoute _getPageRoute(Widget child){
  return MaterialPageRoute(builder: (context) => child);
}