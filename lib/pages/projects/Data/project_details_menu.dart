import 'package:gestion_projets/routing/routes.dart';

class ProjectDetailsMenuItem {
  String name;
  String icon;
  String page;
  bool isActive;

  ProjectDetailsMenuItem(this.name, this.icon, this.page, this.isActive);
}

List<ProjectDetailsMenuItem> projectDetailsMenu = [
  ProjectDetailsMenuItem(
      "Aperçu", "icons/side_menu/cube.svg", overviewPageRoute, true),
  ProjectDetailsMenuItem(
      "Tâches", "icons/side_menu/task.svg", projectTasksPageRoute, false),
  ProjectDetailsMenuItem(
      "Objectifs", "icons/side_menu/cup.svg", objectivesPageRoute, false),
  ProjectDetailsMenuItem("Risques / Opportunités",
      "icons/side_menu/speedometer.svg", eventsPageRoute, false),
  ProjectDetailsMenuItem(
      "Réunions", "icons/side_menu/calendar.svg", meetingsPageRoute, false),
  ProjectDetailsMenuItem(
      "Documents", "icons/side_menu/file.svg", documentsPageRoute, false),
];
