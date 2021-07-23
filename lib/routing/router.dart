import 'package:flutter/material.dart';
import 'package:gestion_projets/pages/activities/activities.dart';
import 'package:gestion_projets/pages/dashboard/dashboard.dart';
import 'package:gestion_projets/pages/projects/body/projects_body.dart';
import 'package:gestion_projets/pages/projects/project_details/documents/documents.dart';
import 'package:gestion_projets/pages/projects/project_details/meetings/meetings.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/body/indicator_body.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/objectives.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/project_overview.dart';
import 'package:gestion_projets/pages/projects/project_details/project_details.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/body/calculations.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/body/evaluations.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/body/risks_opportunities.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/risks_opportunities.dart';
import 'package:gestion_projets/pages/projects/project_details/tasks/tasks.dart';
import 'package:gestion_projets/pages/projects/projects.dart';
import 'package:gestion_projets/pages/tasks/tasks.dart';
import 'package:gestion_projets/routing/routes.dart';

//TODO: Fix routing and navigation with urls
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case dashboardPageRoute:
      return _pageRoute(DashboardPage(), settings);
    case projectsPageRoute:
      return _pageRoute(ProjectsPage(), settings);
    case tasksPageRoute:
      return _pageRoute(TasksPage(), settings);
    case projectDetailsPageRoute:
      return _pageRoute(ProjectDetails(), settings);
    case activitiesPageRoute:
      return _pageRoute(ActivitiesPage(), settings);
    case projectListPageRoute:
      return _pageRoute(ProjectsPageBody(), settings);
    case overviewPageRoute:
      return _pageRoute(ProjectOverview(), settings);
    case projectTasksPageRoute:
      return _pageRoute(ProjectTasks(), settings);
    case objectivesPageRoute:
      return _pageRoute(ProjectObjectives(), settings);
    case indicatorPageRoute:
      return _pageRoute(IndicatorBody(), settings);
    case eventsPageRoute:
      return _pageRoute(ProjectRisksOpportunities(), settings);
    case eventEvaluationsPageRoute:
      return _pageRoute(EvaluationsBody(), settings);
    case eventsListPageRoute:
      return _pageRoute(ProjectRisksOpportunitiesBody(), settings);
    case evaluationCalculationsPageRoute:
      return _pageRoute(CalculationsBody(), settings);
    case meetingsPageRoute:
      return _pageRoute(ProjectMeetings(), settings);
    case documentsPageRoute:
      return _pageRoute(ProjectDocuments(), settings);
    default:
      return _pageRoute(DashboardPage(), settings);
  }
}

PageRoute _pageRoute(Widget page, RouteSettings settings) {
  return _GeneratePageRoute(
    settings: settings,
    widget: page,
  );

  //MaterialPageRoute(builder: (context) => page, settings: settings);
}

class _GeneratePageRoute extends PageRouteBuilder {
  final Widget widget;
  final RouteSettings settings;

  _GeneratePageRoute({required this.widget, required this.settings})
      : super(
            settings: settings,
            pageBuilder: (BuildContext context, _, __) {
              return widget;
            },
            // transitionDuration: Duration(milliseconds: 200),
            transitionsBuilder: (BuildContext context, _, __, Widget child) {
              return /*SlideTransition(
                textDirection: TextDirection.rtl,
                position: Tween<Offset>(
                  begin: Offset(-0.2, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child:FadeTransition(opacity: animation, child: */
                  child;
              //  ));
            });
}
