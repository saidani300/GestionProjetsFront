import 'package:gestion_projets/routing/routes.dart';

class ProjectDetailsMenuItem {
  String name;
  String icon;
  String page;
  bool isActive;

  ProjectDetailsMenuItem(this.name, this.icon, this.page, this.isActive);
}

List<ProjectDetailsMenuItem> projectDetailsMenu = [
  ProjectDetailsMenuItem("Structure",
      "icons/Project_menu_icons/structure_icon.svg", overviewPageRoute, true),
  ProjectDetailsMenuItem("Tâches", "icons/Project_menu_icons/task_icon.svg",
      projectTasksPageRoute, false),
  ProjectDetailsMenuItem("Objectifs",
      "icons/Project_menu_icons/trophy_icon.svg", objectivesPageRoute, false),
  ProjectDetailsMenuItem("Risques / Opportunités",
      "icons/Project_menu_icons/event_icon.svg", eventsPageRoute, false),
  ProjectDetailsMenuItem("Réunions",
      "icons/Project_menu_icons/calendar_icon.svg", meetingsPageRoute, false),
  ProjectDetailsMenuItem("Documents",
      "icons/Project_menu_icons/documents_icon.svg", documentsPageRoute, false),
];
