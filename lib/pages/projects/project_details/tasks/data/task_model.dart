import 'dart:math';

import 'package:gestion_projets/pages/people/Data/user.dart';
import 'package:gestion_projets/pages/projects/Data/project.dart';
import 'package:gestion_projets/pages/projects/project_details/documents/data/document.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data/phase.dart'
    as Model;

class TaskModel {
  final int id;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  Model.Status status;
  final User user;
  final List<Document> documents;
  final Priority priority;
  final List<TaskModel> subTasks;

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
    User(30, "Saidani Wael", "5"),
    [],
    Priority.Important,
    []);

List<TaskModel> Tasks = [
  TaskModel(
      212,
      "Développement d'une nouvelle interface utilisateur",
      DateTime.now(),
      DateTime.now().add(Duration(days: 30)),
      Model.Status.completed,
      User(1, "Saidani Wael", "https://i.imgur.com/01lxY0W.jpeg"),
      [],
      Priority.Normal,
      [
        TaskModel(
            987,
            "Développement d'une nouvelle interface utilisateur",
            DateTime.now(),
            DateTime.now().add(Duration(days: 30)),
            Model.Status.completed,
            User(1, "Saidani Wael", "3"),
            [],
            Priority.Normal,
            []),
        TaskModel(
            265,
            "Développement d'une nouvelle interface utilisateur",
            DateTime.now(),
            DateTime.now().add(Duration(days: 20)),
            Model.Status.inProgress,
            User(1, "Saidani Wael", "6"),
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
      User(1, "Saidani Wael", "6"),
      [],
      Priority.Normal,
      [
        TaskModel(
            785,
            "Développement d'une nouvelle interface utilisateur",
            DateTime.now(),
            DateTime.now().add(Duration(days: 17)),
            Model.Status.completed,
            User(1, "Saidani Wael", "https://i.imgur.com/kieKRFZ.jpeg"),
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
      User(1, "Saidani Wael", "3"),
      [],
      Priority.Normal,
      [
        TaskModel(
            444,
            "Développement d'une nouvelle interface utilisateur",
            DateTime.now(),
            DateTime.now().add(Duration(days: 120)),
            Model.Status.completed,
            User(1, "Saidani Wael", "https://i.imgur.com/01lxY0W.jpeg"),
            [],
            Priority.Normal,
            []),
      ])
];
