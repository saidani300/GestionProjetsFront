import 'package:flutter/material.dart';
import 'package:gestion_projets/pages/activities/activities.dart';
import 'package:gestion_projets/pages/dashboard/dashboard.dart';
import 'package:gestion_projets/pages/projects/body/projects_body.dart';
import 'package:gestion_projets/pages/projects/project_details/project_details.dart';
import 'package:gestion_projets/pages/projects/projects.dart';
import 'package:gestion_projets/pages/tasks/tasks.dart';
import 'package:gestion_projets/routing/routes.dart';
//TODO: Fix routing and navigation with urls
Route<dynamic> generateRoute(RouteSettings settings){
  switch (settings.name) {
    case dashboardPageRoute:
      return _pageRoute(DashboardPage(),settings);
    case projectsPageRoute:
      return _pageRoute(ProjectsPage(), settings);
    case tasksPageRoute:
      return _pageRoute(TasksPage(), settings);
    case projectDetailsPageRoute :
      return _pageRoute(ProjectDetails(), settings);
    case activitiesPageRoute:
      return _pageRoute(ActivitiesPage(), settings);
    case projectListPageRoute:
      return _pageRoute(ProjectsPageBody(), settings);
    default:
      return _pageRoute(DashboardPage(),settings);

  }
}

PageRoute _pageRoute(Widget page , RouteSettings settings)
{
  return MaterialPageRoute(builder: (context) => page , settings:  settings);
}

class _GeneratePageRoute extends PageRouteBuilder {
  final Widget widget;
  final String routeName;
  _GeneratePageRoute({required this.widget, required this.routeName})
      : super(
      settings: RouteSettings(name: routeName),
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return widget;
      },
      transitionDuration: Duration(milliseconds: 300),
      transitionsBuilder: (BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child) {
        return SlideTransition(
          textDirection: TextDirection.rtl,
          position: Tween<Offset>(
            begin: Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      });
}