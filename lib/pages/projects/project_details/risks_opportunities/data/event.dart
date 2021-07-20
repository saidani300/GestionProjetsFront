import 'package:gestion_projets/pages/projects/project_details/overview/data/document.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data/user.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/data/calculation.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/data/evaluation.dart';

enum EventType {
  Risk,
  Opportunity,
}

enum EventLevel {
  low,
  medium,
  high,
}

class Event {
  final int id;
  final String name;
  final String type;
  final String impact;
  final String cause;
  final String source;
  final DateTime identificationDate;
  final EventType eventType;
  final EventLevel level;
  final User user;
  final List<Evaluation> evaluations;
  final List<Document> documents;

  Event(
      this.id,
      this.name,
      this.type,
      this.impact,
      this.cause,
      this.source,
      this.identificationDate,
      this.eventType,
      this.level,
      this.user,
      this.evaluations,
      this.documents);
}

List<Event> events = [
  Event(
      5487,
      "Retard potentiel pour une tâche",
      "Chronologie",
      "Retard dans la prochaine action",
      "Ressources humaines",
      "Développement d'une nouvelle interface utilisateur",
      DateTime.now(),
      EventType.Risk,
      EventLevel.medium,
      User(12, "Saidani Wael", "3"), [
    Evaluation(
        6565,
        DateTime.now(),
        "Indice de risque",
        0,
        20,
        User(2, "Saidani Wael", "3"),
        [
          Calculation(54, 12, DateTime.now(), DateTime.now(),
              DateTime.now().add(Duration(days: 35)), "name", [
            Criterion(1, "Gravité", 3, "G"),
            Criterion(2, "Fréquence", 2, "F"),
            Criterion(3, "Importance", 2, "I"),
          ]),
          Calculation(98574, 4, DateTime.now(), DateTime.now(),
              DateTime.now().add(Duration(days: 35)), "name", [
            Criterion(1, "Gravité", 2, "G"),
            Criterion(2, "Fréquence", 1, "F"),
            Criterion(3, "Importance", 2, "I"),
          ])
        ],
        Formula(545, "Indice de risque", 'F * I * G', [
          Criterion(1, "Gravité", 0, "G"),
          Criterion(2, "Fréquence", 0, "F"),
          Criterion(3, "Importance", 0, "I"),
        ])),
    Evaluation(
        65987,
        DateTime.now(),
        "Indice de risque",
        0,
        16,
        User(2, "Saidani Wael", "3"),
        [],
        Formula(587, "Indice de risque", 'F * I* G', [])),
  ], []),
  Event(
      8784,
      "Retard potentiel pour une tâche",
      "Chronologie",
      "Retard dans la prochaine action",
      "Ressources humaines",
      "Développement d'une nouvelle interface utilisateur",
      DateTime.now(),
      EventType.Risk,
      EventLevel.high,
      User(12, "Saidani Wael", "4"), [], []),
  Event(
      84,
      "Retard potentiel pour une tâche",
      "Chronologie",
      "Retard dans la prochaine action",
      "Ressources humaines",
      "Développement d'une nouvelle interface utilisateur",
      DateTime.now(),
      EventType.Opportunity,
      EventLevel.low,
      User(12, "Saidani Wael", "4"), [], []),
];
