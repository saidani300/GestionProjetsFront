import 'dart:math';

import 'package:gestion_projets/pages/people/Data/user.dart';
import 'package:gestion_projets/pages/projects/Data/project.dart';
import 'package:gestion_projets/pages/projects/project_details/documents/data/document.dart';
import 'package:gestion_projets/pages/projects/project_details/structure/data/phase.dart'
    as Model;

class TaskModel {
  int id;
  String name;
  DateTime startDate;
  DateTime endDate;
  Model.Status status;
  User user;
  List<Document> documents;
  Priority priority;
  List<TaskModel> subTasks;

  TaskModel(this.id, this.name, this.startDate, this.endDate, this.status,
      this.user, this.documents, this.priority, this.subTasks);

  TaskModel.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        startDate = json['startDate'],
        endDate = json['endDate'],
        status = /*Model.Status.values[*/ json['status'],
        user = User.fromJson(json["user"]),
        documents = List<Document>.from(
            json["documents"].map((x) => Document.fromJson(x))),
        priority = /*Model.Priority.values[*/ json['priority'],
        subTasks = List<TaskModel>.from(
            json["subTasks"].map((x) => TaskModel.fromJson(x)));

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'startDate': startDate,
        'endDate': endDate,
        //'status': status,
        'User': user.toJson(),
        'documents': List<dynamic>.from(documents.map((x) => x.toJson())),
        //'priority': priority,
        'subTasks': List<dynamic>.from(subTasks.map((x) => x.toJson())),
      };
}

TaskModel myTask = new TaskModel(
    new Random().nextInt(99999),
    "Développement d'une nouvelle interface utilisateur",
    DateTime.now(),
    DateTime.now().add(Duration(days: 17)),
    Model.Status.inProgress,
    users.elementAt(1),
    [],
    Priority.Important,
    []);

List<TaskModel> tasks = [
  TaskModel(
      212,
      "Développement d'une nouvelle interface utilisateur",
      DateTime.now(),
      DateTime.now().add(Duration(days: 30)),
      Model.Status.completed,
      users.first,
      [
        Document(
            15454, "File.txt", "", "text", users.last, DateTime.now(), 55487),
        Document(12, "File.txt", "", "text", users.last, DateTime.now(), 55487),
        Document(21, "File.txt", "", "text", users.last, DateTime.now(), 55487),
        Document(22, "File.txt", "", "text", users.last, DateTime.now(), 55487),
      ],
      Priority.Normal,
      [
        TaskModel(
            987,
            "Développement d'une nouvelle interface utilisateur",
            DateTime.now(),
            DateTime.now().add(Duration(days: 30)),
            Model.Status.completed,
            users.elementAt(5),
            [],
            Priority.Normal,
            []),
        TaskModel(
            265,
            "Développement d'une nouvelle interface utilisateur",
            DateTime.now(),
            DateTime.now().add(Duration(days: 20)),
            Model.Status.inProgress,
            users.elementAt(4),
            [],
            Priority.Normal,
            []),
      ]),
  TaskModel(
      45,
      "Développement d'une nouvelle interface utilisateur",
      DateTime.now(),
      DateTime.now().add(Duration(days: 68)),
      Model.Status.completed,
      users.elementAt(1),
      [],
      Priority.Normal,
      [
        TaskModel(
            785,
            "Développement d'une nouvelle interface utilisateur",
            DateTime.now(),
            DateTime.now().add(Duration(days: 17)),
            Model.Status.completed,
            users.elementAt(6),
            [],
            Priority.Normal,
            []),
      ]),
  TaskModel(
      957,
      "Développement d'une nouvelle interface utilisateur",
      DateTime.now(),
      DateTime.now().add(Duration(days: 1)),
      Model.Status.completed,
      users.elementAt(0),
      [],
      Priority.Normal,
      [
        TaskModel(
            444,
            "Développement d'une nouvelle interface utilisateur",
            DateTime.now(),
            DateTime.now().add(Duration(days: 120)),
            Model.Status.completed,
            users.elementAt(4),
            [],
            Priority.Normal,
            []),
      ])
];
