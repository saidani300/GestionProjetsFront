import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/people/Data/user.dart';
import 'package:gestion_projets/pages/projects/project_details/documents/data/document.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/data/calculation.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/data/evaluation.dart';

enum EventType {
  Opportunity,
  Risk,
}

enum EventLevel {
  low,
  medium,
  high,
}

enum EventCategory {
  category1,
  category2,
  category3,
  category4,
}

String categoryAsText(EventCategory category) {
  switch (category) {
    case EventCategory.category1:
      return "Catégorie 1";
    case EventCategory.category2:
      return "Catégorie 2";
    case EventCategory.category3:
      return "Catégorie 3";
    case EventCategory.category4:
      return "Catégorie 4";
  }
}

class Event {
  int id;
  String name;
  String description;
  String type;
  String impact;
  String cause;
  String source;
  DateTime identificationDate;
  EventType eventType;
  EventLevel level;
  EventCategory category;
  User user;
  List<Evaluation> evaluations;
  List<Document> documents;

  Event(
      this.id,
      this.name,
      this.description,
      this.type,
      this.impact,
      this.cause,
      this.source,
      this.identificationDate,
      this.eventType,
      this.level,
      this.category,
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
      "",
      DateTime.now(),
      EventType.Risk,
      EventLevel.medium,
      EventCategory.category1,
      users.elementAt(1), [
    Evaluation(
        6565,
        DateTime.now(),
        "Indice de risque",
        "",
        0,
        20,
        users.elementAt(0),
        [
          Calculation(54, 12, DateTime.now(), DateTime.now(),
              DateTime.now().add(Duration(days: 35)), [
            Criterion(1, "Gravité", 3, "G"),
            Criterion(2, "Fréquence", 2, "F"),
            Criterion(3, "Importance", 2, "I"),
          ]),
          Calculation(98574, 4, DateTime.now(), DateTime.now(),
              DateTime.now().add(Duration(days: 35)), [
            Criterion(1, "Gravité", 2, "G"),
            Criterion(2, "Fréquence", 1, "F"),
            Criterion(3, "Importance", 2, "I"),
          ])
        ],
        Formula(545, "Indice de risque", 'F*I*G', [
          Criterion(1, "Gravité", 0, "G"),
          Criterion(2, "Fréquence", 0, "F"),
          Criterion(3, "Importance", 0, "I"),
        ])),
    Evaluation(
        65987,
        DateTime.now(),
        "Indice de risque",
        "",
        0,
        16,
        users.elementAt(3),
        [],
        Formula(587, "Indice de risque", 'F*I*G', [
          Criterion(1, "Gravité", 0, "G"),
          Criterion(2, "Fréquence", 0, "F"),
          Criterion(3, "Importance", 0, "I"),
        ])),
  ], []),
  Event(
      8784,
      "Retard potentiel pour une tâche",
      "Chronologie",
      "Retard dans la prochaine action",
      "Ressources humaines",
      "Développement d'une nouvelle interface utilisateur",
      "",
      DateTime.now(),
      EventType.Risk,
      EventLevel.high,
      EventCategory.category1,
      users.elementAt(4), [], []),
  Event(
      84,
      "Retard potentiel pour une tâche",
      "Chronologie",
      "Retard dans la prochaine action",
      "Ressources humaines",
      "Développement d'une nouvelle interface utilisateur",
      "",
      DateTime.now(),
      EventType.Opportunity,
      EventLevel.low,
      EventCategory.category1,
      users.first, [], []),
];

EventTypeObject eventTypeAsObject(EventType eventType) {
  switch (eventType) {
    case EventType.Opportunity:
      return EventTypeObject(
        "Opportunité",
        SvgPicture.asset(
          "icons/up-arrow.svg",
          color: lightBlue,
          width: 20,
          height: 20,
        ),
      );
    case EventType.Risk:
      return EventTypeObject(
        "Risque",
        SvgPicture.asset(
          "icons/down-arrow.svg",
          color: lightRed,
          width: 20,
          height: 20,
        ),
      );
  }
}

EventLevelObject eventLevelAsObject(EventType type, EventLevel level) {
  switch (type) {
    case EventType.Opportunity:
      switch (level) {
        case EventLevel.low:
          return EventLevelObject("1", lightBlue);
        case EventLevel.medium:
          return EventLevelObject("2", active);
        case EventLevel.high:
          return EventLevelObject("3", lightPurple);
      }
    case EventType.Risk:
      switch (level) {
        case EventLevel.low:
          return EventLevelObject("1", lightBlue);
        case EventLevel.medium:
          return EventLevelObject("2", lightOrange);
        case EventLevel.high:
          return EventLevelObject("3", lightRed);
      }
  }
}

class EventLevelObject {
  final String name;

  final Color color;

  EventLevelObject(this.name, this.color);
}

class EventTypeObject {
  final String name;

  final Widget icon;

  EventTypeObject(this.name, this.icon);
}
