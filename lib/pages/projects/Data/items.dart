import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data/action.dart'
    as Model;
import 'package:gestion_projets/pages/projects/project_details/overview/data/document.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data/phase.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data/task.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data/user.dart';

const AllName = "Tous";
const CompletedName = "Terminé";
const InProgressName = "En cours";

class showByStatusItem {
  final String name;

  showByStatusItem(this.name);
}

List<showByStatusItem> ShowByStatusItems = [
  showByStatusItem(AllName),
  showByStatusItem(CompletedName),
  showByStatusItem(InProgressName),
];

class PriorityItem {
  final String name;
  final IconData icon;
  final Color color;

  PriorityItem(this.name, this.icon, this.color);
}

List<PriorityItem> priorityItems = [
  PriorityItem("Élevée", Icons.flag_rounded, lightRed),
  PriorityItem("Normale", Icons.flag_rounded, active),
  PriorityItem("Basse", Icons.flag_outlined, text.withOpacity(0.65)),
];

Phase newPhase = Phase(Random.secure().nextInt(1000),
    Random.secure().hashCode.toString(), DateTime.now(), DateTime.now(), []);

List<Phase> Phases = [
  Phase(1, 'Specification'.toUpperCase(), DateTime.now(), DateTime.now(), [
    Model.Action(
        1,
        "Développement d'une nouvelle interface utilisateur",
        DateTime.now(),
        DateTime.now().add(Duration(days: 30)),
        Status.inProgress,
        User(1, "Saidani Wael", "3"),
        [
          Task(
              1,
              "Développement d'une nouvelle interface utilisateur",
              DateTime.now(),
              DateTime.now().add(Duration(days: 64)),
              Status.completed,
              User(1, "Saidani Wael", "5"),
              [],
              Priority.Important),
          Task(
              2,
              "Développement d'une nouvelle interface",
              DateTime.now(),
              DateTime.now().add(Duration(days: 10)),
              Status.inProgress,
              User(2, "Saidani Wael", "https://i.imgur.com/kieKRFZ.jpeg"),
              [
                Document(1, "Document1"),
                Document(1, "Document2"),
              ],
              Priority.Low),
          Task(
              2,
              "Développement du service web",
              DateTime.now(),
              DateTime.now().add(Duration(days: 22)),
              Status.inProgress,
              User(2, "Saidani Wael", "https://i.imgur.com/kieKRFZ.jpeg"),
              [],
              Priority.Important),
        ],
        [
          Document(1, "Document1"),
          Document(1, "Document2"),
        ],
        Priority.Normal),
    Model.Action(
        2,
        "Développement du service web",
        DateTime.now(),
        DateTime.now().add(Duration(days: 87)),
        Status.completed,
        User(1, "Saidani Wael", "3"),
        [
          Task(
              1,
              "Développement d'une nouvelle interface utilisateur",
              DateTime.now(),
              DateTime.now().add(Duration(days: 40)),
              Status.completed,
              User(1, "Saidani Wael", "https://i.imgur.com/kieKRFZ.jpeg"),
              [
                Document(1, "Document1"),
              ],
              Priority.Important),
          Task(
              1,
              "Développement du service web",
              DateTime.now(),
              DateTime.now().subtract(Duration(days: 11)),
              Status.completed,
              User(2, "Saidani Wael", "https://i.imgur.com/01lxY0W.jpeg"),
              [
                Document(1, "Document1"),
                Document(1, "Document2"),
              ],
              Priority.Normal),
          Task(
              1,
              "Développement d'une nouvelle interface utilisateur",
              DateTime.now(),
              DateTime.now().add(Duration(days: 11)),
              Status.approved,
              User(2, "Saidani Wael", "https://i.imgur.com/01lxY0W.jpeg"),
              [
                Document(1, "Document1"),
              ],
              Priority.Normal),
        ],
        [
          Document(1, "Document1"),
        ],
        Priority.Important)
  ]),
  Phase(2, 'Développement'.toUpperCase(), DateTime.now(), DateTime.now(), [
    Model.Action(
        1,
        "Développement d'une nouvelle interface utilisateur",
        DateTime.now(),
        DateTime.now().add(Duration(days: 30)),
        Status.inProgress,
        User(1, "Saidani Wael", "3"),
        [
          Task(
              1,
              "Développement d'une nouvelle interface utilisateur",
              DateTime.now(),
              DateTime.now().add(Duration(days: 64)),
              Status.completed,
              User(1, "Saidani Wael", "5"),
              [],
              Priority.Important),
          Task(
              2,
              "Développement d'une nouvelle interface",
              DateTime.now(),
              DateTime.now().add(Duration(days: 10)),
              Status.completed,
              User(2, "Saidani Wael", "https://i.imgur.com/kieKRFZ.jpeg"),
              [
                Document(1, "Document1"),
                Document(1, "Document2"),
              ],
              Priority.Low),
          Task(
              2,
              "Développement du service web",
              DateTime.now(),
              DateTime.now().add(Duration(days: 22)),
              Status.inProgress,
              User(2, "Saidani Wael", "https://i.imgur.com/kieKRFZ.jpeg"),
              [],
              Priority.Important),
        ],
        [
          Document(1, "Document1"),
          Document(1, "Document2"),
        ],
        Priority.Normal),
    Model.Action(
        2,
        "Développement du service web",
        DateTime.now(),
        DateTime.now().add(Duration(days: 87)),
        Status.completed,
        User(1, "Saidani Wael", "3"),
        [
          Task(
              1,
              "Développement d'une nouvelle interface utilisateur",
              DateTime.now(),
              DateTime.now().add(Duration(days: 40)),
              Status.completed,
              User(1, "Saidani Wael", "https://i.imgur.com/kieKRFZ.jpeg"),
              [
                Document(1, "Document1"),
              ],
              Priority.Important),
          Task(
              1,
              "Développement du service web",
              DateTime.now(),
              DateTime.now().subtract(Duration(days: 11)),
              Status.completed,
              User(2, "Saidani Wael", "https://i.imgur.com/01lxY0W.jpeg"),
              [
                Document(1, "Document1"),
                Document(1, "Document2"),
              ],
              Priority.Normal),
          Task(
              1,
              "Développement d'une nouvelle interface utilisateur",
              DateTime.now(),
              DateTime.now().add(Duration(days: 11)),
              Status.approved,
              User(2, "Saidani Wael", "https://i.imgur.com/01lxY0W.jpeg"),
              [
                Document(1, "Document1"),
              ],
              Priority.Normal),
        ],
        [
          Document(1, "Document1"),
        ],
        Priority.Important),
    Model.Action(
        3,
        "Développement du service web",
        DateTime.now(),
        DateTime.now().add(Duration(days: 87)),
        Status.completed,
        User(1, "Saidani Wael", "3"),
        [
          Task(
              1,
              "Développement d'une nouvelle interface utilisateur",
              DateTime.now(),
              DateTime.now().add(Duration(days: 40)),
              Status.completed,
              User(1, "Saidani Wael", "https://i.imgur.com/kieKRFZ.jpeg"),
              [
                Document(1, "Document1"),
              ],
              Priority.Important),
          Task(
              1,
              "Développement du service web",
              DateTime.now(),
              DateTime.now().subtract(Duration(days: 11)),
              Status.completed,
              User(2, "Saidani Wael", "https://i.imgur.com/01lxY0W.jpeg"),
              [
                Document(1, "Document1"),
                Document(1, "Document2"),
              ],
              Priority.Normal),
          Task(
              1,
              "Développement d'une nouvelle interface utilisateur",
              DateTime.now(),
              DateTime.now().add(Duration(days: 11)),
              Status.approved,
              User(2, "Saidani Wael", "https://i.imgur.com/01lxY0W.jpeg"),
              [
                Document(1, "Document1"),
              ],
              Priority.Normal),
        ],
        [
          Document(1, "Document1"),
        ],
        Priority.Important)
  ]),
  //Phase(2, 'name')
];
