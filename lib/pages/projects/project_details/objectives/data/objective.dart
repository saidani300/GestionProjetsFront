import 'package:gestion_projets/pages/people/Data/user.dart';
import 'package:gestion_projets/pages/projects/Data/project.dart';
import 'package:gestion_projets/pages/projects/project_details/documents/data/document.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/data/indicator.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/data/measure.dart';

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
  final Priority priority;
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
    Priority.Normal,
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
      Priority.Important,
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
              Measure(5548, 24, DateTime.now().subtract(Duration(days: 30)),
                  DateTime.now().subtract(Duration(days: 30)), DateTime.now(), [
                Document(
                    55,
                    "Développement d'une nouvelle interface utilisateur",
                    "url",
                    "PDF",
                    User(12, "Saidani Wael", "3"),
                    DateTime.now(),
                    656848),
              ])
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
      Priority.Normal,
      "Développement",
      [],
      DateTime.now())
];
