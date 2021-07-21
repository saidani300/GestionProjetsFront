import 'package:gestion_projets/pages/projects/project_details/objectives/data/indicator.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/data/measure.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data/document.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data/phase.dart'
    as Model;
import 'package:gestion_projets/pages/projects/project_details/overview/data/user.dart';

enum ObjectiveStatus {
  inProgress,
  awaitingApproval,
  achieved,
  notAchieved,
}

class Objective {
  final int id;
  final String name;
  final String type;
  final DateTime creationDate;
  final DateTime endDate;
  final ObjectiveStatus status;
  final User user;
  final List<Indicator> indicators;
  final Model.Priority priority;
  final List<Document> documents;

  Objective(
    this.id,
    this.name,
    this.creationDate,
    this.status,
    this.user,
    this.indicators,
    this.priority,
    this.type,
    this.documents,
    this.endDate,
  );
}

Objective objective = new Objective(
    655,
    "Objectif de développement",
    DateTime.now(),
    ObjectiveStatus.achieved,
    User(1, "Saidani Wael", "3"),
    [],
    Model.Priority.Normal,
    "Développement",
    [],
    DateTime.now());

List<Objective> Objectives = [
  Objective(
      32,
      "Objectif de développement",
      DateTime.now(),
      ObjectiveStatus.inProgress,
      User(1, "Saidani Wael", "3"),
      [
        Indicator(
            302,
            "Nombre d'actions terminées",
            User(6, "Saidani Wael", "7"),
            [],
            "Avancement",
            "ATerminé/ATotal*100",
            0,
            100,
            30,
            false,
            "%",
            Frequency.monthly),
        Indicator(
            652,
            "Nombre d'actions terminées",
            User(1, "Saidani Wael", "7"),
            [],
            "Avancement",
            "ATerminé/ATotal*100",
            0,
            100,
            30,
            false,
            "%",
            Frequency.monthly)
      ],
      Model.Priority.Important,
      "Développement",
      [],
      DateTime.now()),
  Objective(
      655,
      "Objectif de développement",
      DateTime.now(),
      ObjectiveStatus.achieved,
      User(1, "Saidani Wael", "3"),
      [
        Indicator(
            302,
            "Nombre d'actions terminées",
            User(6, "Saidani Wael", "7"),
            [
              Measure(5487, 55, DateTime.now(), DateTime.now(),
                  DateTime.now().add(Duration(days: 90)), []),
              Measure(
                  5548,
                  24,
                  DateTime.now().subtract(Duration(days: 30)),
                  DateTime.now().subtract(Duration(days: 30)),
                  DateTime.now(),
                  [Document(1, "document1")])
            ],
            "Avancement",
            "ATerminé/ATotal*100",
            0,
            100,
            30,
            false,
            "%",
            Frequency.monthly)
      ],
      Model.Priority.Normal,
      "Développement",
      [],
      DateTime.now())
];