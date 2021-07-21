import 'package:gestion_projets/pages/projects/project_details/overview/data/phase.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data/user.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Project {
  final int id;
  final String name;
  final String type;
  final DateTime startDate;
  final DateTime endDate;
  final User teamLeader;
  final Status status;

  Project(
    this.id,
    this.name,
    this.type,
    this.teamLeader,
    this.status,
    this.startDate,
    this.endDate,
  );

  Project.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        type = json['type'],
        startDate = DateTime.parse(json['startDate']),
        endDate = DateTime.parse(json['endDate']),
        teamLeader = User.fromJson(json['teamLeader']),
        status = Status.values.elementAt(json['status']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'type': type,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        'teamLeader': teamLeader.toJson(),
        'status': status.index,
      };
}

//TODO: Fix Dates Format use DataTime formats
List<Project> Projects = [
  Project(
      544,
      "Développement d'une nouvelle interface utilisateur",
      "Développement",
      User(23, "Saidani Wael", "3"),
      Status.inProgress,
      DateTime.now(),
      DateTime.now().add(Duration(days: 38))),
  Project(
      59898,
      "Développement d'une nouvelle interface utilisateur",
      "Développement",
      User(23, "Saidani Wael", "3"),
      Status.completed,
      DateTime.now().subtract(Duration(days: 38)),
      DateTime.now().add(Duration(days: 1))),
  Project(
      5,
      "Développement d'une nouvelle interface utilisateur",
      "Développement",
      User(23, "Saidani Wael", "3"),
      Status.inProgress,
      DateTime.now().subtract(Duration(days: 50)),
      DateTime.now().subtract(Duration(days: 38))),
  Project(
      447,
      "Développement d'une nouvelle interface utilisateur",
      "Développement",
      User(23, "Saidani Wael", "3"),
      Status.inProgress,
      DateTime.now(),
      DateTime.now().add(Duration(days: 38))),
  Project(
      87789,
      "Développement d'une nouvelle interface utilisateur",
      "Développement",
      User(23, "Saidani Wael", "3"),
      Status.completed,
      DateTime.now(),
      DateTime.now().add(Duration(days: 150))),
  Project(
      55558888,
      "Projet Qalitas",
      "Développement",
      User(23, "Saidani Wael", "3"),
      Status.completed,
      DateTime.now(),
      DateTime.now().add(Duration(days: 150))),
];
