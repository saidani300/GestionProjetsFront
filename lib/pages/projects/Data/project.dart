import 'package:gestion_projets/pages/people/Data/user.dart';
import 'package:gestion_projets/pages/projects/Data/project_type.dart';
import 'package:gestion_projets/pages/projects/project_details/documents/data/document.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data/phase.dart';
import 'package:json_annotation/json_annotation.dart';

enum Priority { Important, Normal, Low }

@JsonSerializable()
class Project {
  int id;
  String name;
  ProjectType type;
  DateTime startDate;
  DateTime endDate;
  User teamLeader;
  Status status;
  Priority priority;
  List<Document> documents;

  Project(
    this.id,
    this.name,
    this.type,
    this.teamLeader,
    this.status,
    this.startDate,
    this.endDate,
    this.priority,
    this.documents,
  );

  Project.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        type = ProjectType.fromJson(json['type']),
        startDate = DateTime.parse(json['startDate']),
        endDate = DateTime.parse(json['endDate']),
        teamLeader = User.fromJson(json['teamLeader']),
        status = Status.values.elementAt(json['status']),
        priority = Priority.values.elementAt(json['priority']),
        documents = List<Document>.from(
            json["documents"].map((x) => Document.fromJson(x))).toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'type': type.toJson(),
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        'teamLeader': teamLeader.toJson(),
        'status': status.index,
        'priority': priority.index,
        'documents': documents.map((x) => x.toJson()).toList(),
      };
}

String priorityAsText(Priority priority) {
  switch (priority) {
    case Priority.Low:
      return "Basse";
    case Priority.Normal:
      return "Normale";
    case Priority.Important:
      return "Élevée";
  }
}

//TODO: Fix Dates Format use DataTime formats
List<Project> projects = [
  Project(
      544,
      "Développement d'une nouvelle interface utilisateur",
      projectTypesList.first,
      users.elementAt(3),
      Status.inProgress,
      DateTime.now(),
      DateTime.now().add(Duration(days: 38)),
      Priority.Normal, []),
  Project(
      59898,
      "Développement d'une nouvelle interface utilisateur",
      projectTypesList.first,
      users.elementAt(6),
      Status.completed,
      DateTime.now().subtract(Duration(days: 38)),
      DateTime.now().add(Duration(days: 1)),
      Priority.Normal, []),
  Project(
      5,
      "Développement d'une nouvelle interface utilisateur",
      projectTypesList.first,
      users.elementAt(5),
      Status.inProgress,
      DateTime.now().subtract(Duration(days: 50)),
      DateTime.now().subtract(Duration(days: 38)),
      Priority.Important, []),
  Project(
      447,
      "Développement d'une nouvelle interface utilisateur",
      projectTypesList.first,
      users.elementAt(4),
      Status.inProgress,
      DateTime.now(),
      DateTime.now().add(Duration(days: 38)),
      Priority.Low, []),
  Project(
      87789,
      "Développement d'une nouvelle interface utilisateur",
      projectTypesList.first,
      users.elementAt(3),
      Status.completed,
      DateTime.now(),
      DateTime.now().add(Duration(days: 150)),
      Priority.Normal, []),
  Project(
      55558888,
      "Projet Qalitas",
      projectTypesList.first,
      users.first,
      Status.completed,
      DateTime.now(),
      DateTime.now().add(Duration(days: 150)),
      Priority.Normal, []),
];
