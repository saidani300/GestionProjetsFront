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
      "Aperçu",
      /*Icons.account_tree_rounded*/ "icons/structure.svg",
      overviewPageRoute,
      true),
  ProjectDetailsMenuItem("Tâches", /*Icons.task_alt*/ "icons/clipboard.svg",
      projectTasksPageRoute, false),
  ProjectDetailsMenuItem("Objectifs", /*Icons.settings*/ "icons/goal.svg",
      objectivesPageRoute, false),
  ProjectDetailsMenuItem(
      "Risques / Opportunités",
      /*Icons.compare_arrows_rounded*/
      "icons/speedometer.svg",
      eventsPageRoute,
      false),
  ProjectDetailsMenuItem(
      "Réunions",
      /*Icons.group_work_outlined*/ "icons/calendar.svg",
      meetingsPageRoute,
      false),
  ProjectDetailsMenuItem(
      "Documents",
      /*Icons.file_copy_outlined*/ "icons/file.svg",
      projectTasksPageRoute,
      false),
];
