import 'package:gestion_projets/pages/people/Data/user.dart';
import 'package:gestion_projets/pages/projects/Data/project.dart';
import 'package:gestion_projets/pages/projects/project_details/documents/data/document.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/data/indicator.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/data/measure.dart';

enum ObjectiveStatus {
  inProgress,
  achieved,
  notAchieved,
}

String objectiveStatusAsText(ObjectiveStatus status) {
  switch (status) {
    case ObjectiveStatus.inProgress:
      return 'En cours';
    case ObjectiveStatus.notAchieved:
      return 'Non atteint';
    case ObjectiveStatus.achieved:
      return 'Atteint';
  }
}

enum ObjectiveType {
  type1,
  type2,
  type3,
}

String objectiveTypeAsText(ObjectiveType type) {
  switch (type) {
    case ObjectiveType.type1:
      return 'Type 1';
    case ObjectiveType.type2:
      return 'Type 2';
    case ObjectiveType.type3:
      return 'Type 3';
  }
}

class Objective {
  int id;
  String name;
  ObjectiveType type;
  DateTime creationDate;
  DateTime endDate;
  ObjectiveStatus status;
  User user;
  List<Indicator> indicators;
  Priority priority;
  List<Document> documents;

  Objective(
    this.id,
    this.name,
    this.type,
    this.creationDate,
    this.status,
    this.user,
    this.indicators,
    this.priority,
    this.documents,
    this.endDate,
  );
}

List<Objective> objectives = [
  Objective(
      32,
      "Objectif de développement",
      ObjectiveType.type1,
      DateTime.now(),
      ObjectiveStatus.inProgress,
      User(1, "Saidani Wael", "3"),
      [
        Indicator(
            302,
            "Nombre d'actions terminées",
            User(6, "Saidani Wael", "7"),
            [],
            IndicatorType.type1,
            "ATerminé/ATotal*100",
            0,
            100,
            30,
            Nature.manual,
            "%",
            Frequency.monthly),
        Indicator(
            652,
            "Nombre d'actions terminées",
            User(1, "Saidani Wael", "7"),
            [],
            IndicatorType.type1,
            "ATerminé/ATotal*100",
            0,
            100,
            30,
            Nature.manual,
            "%",
            Frequency.monthly)
      ],
      Priority.Important,
      [],
      DateTime.now()),
  Objective(
      655,
      "Objectif de développement",
      ObjectiveType.type1,
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
                  DateTime.now().add(Duration(days: 90)), ""),
              Measure(
                  5548,
                  24,
                  DateTime.now().subtract(Duration(days: 30)),
                  DateTime.now().subtract(Duration(days: 30)),
                  DateTime.now(),
                  "")
            ],
            IndicatorType.type1,
            "ATerminé/ATotal*100",
            0,
            100,
            30,
            Nature.manual,
            "%",
            Frequency.monthly)
      ],
      Priority.Normal,
      [],
      DateTime.now())
];
