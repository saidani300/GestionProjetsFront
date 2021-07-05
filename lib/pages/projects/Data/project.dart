import 'package:gestion_projets/pages/projects/widgets/project_item.dart';

class TeamLeader {
  final String name;
  final String picture;

  TeamLeader(this.name, this.picture);
}

class ProjectDataItem {
  final String name;
  final String type;
  final String deadline;
  final String deadlineDays;
  final TeamLeader teamLeader;
  final statusType status;

  ProjectDataItem(
    this.name,
    this.type,
    this.deadline,
    this.deadlineDays,
    this.teamLeader,
    this.status,
  );
}

class Data {
  static final List<ProjectDataItem> projectsList = [
   /* ProjectDataItem(
        "Développement d'une nouvelle interface utilisateur",
        "Développement",
        "10 juillet 2021",
        "Dans 12 jours",
        new TeamLeader("Saidani Wael", "3"),
        statusType.Completed),
    ProjectDataItem(
        "Créer un nouveau plan marketing",
        "Commercialisation ",
        "25 juillet 2021",
        "Dans 23 jours",
        new TeamLeader("Wael Saidani", "3"),
        statusType.InProgress),
    ProjectDataItem(
        "Développement d'une nouvelle interface utilisateur",
        "Développement",
        "10 juillet 2021",
        "",
        new TeamLeader("Saidani Wael", "6"),
        statusType.InProgress),
    ProjectDataItem(
        "Développement d'une nouvelle interface utilisateur",
        "Développement",
        "10 juillet 2021",
        "Dans 12 jours",
        new TeamLeader("Saidani Wael", "3"),
        statusType.Completed),

    ProjectDataItem(
        "Développement d'une nouvelle interface utilisateur",
        "Développement",
        "10 juillet 2021",
        "Dans 12 jours",
        new TeamLeader("Saidani Wael", "6"),
        statusType.Completed),
    ProjectDataItem(
        "Développement d'une nouvelle interface utilisateur",
        "Développement",
        "10 juillet 2021",
        "Dans 12 jours",
        new TeamLeader("Saidani Wael", "6"),
        statusType.Completed),

    ProjectDataItem(
        "Développement d'une nouvelle interface utilisateur",
        "Développement",
        "10 juillet 2021",
        "Dans 12 jours",
        new TeamLeader("Saidani Wael", "7"),
        statusType.Completed),
    ProjectDataItem(
        "Développement d'une nouvelle interface utilisateur",
        "Développement",
        "10 juillet 2021",
        "Dans 12 jours",
        new TeamLeader("Saidani Wael", "7"),
        statusType.Completed)*/
  ];
}
