
import 'package:gestion_projets/pages/people/Data/user.dart';
import 'package:gestion_projets/pages/projects/Data/project.dart';
import 'package:gestion_projets/pages/projects/project_details/documents/data/document.dart';
import 'package:gestion_projets/pages/projects/project_details/structure/data/action.dart'
    as Model;
import 'package:gestion_projets/pages/projects/project_details/structure/data/phase.dart';
import 'package:gestion_projets/pages/projects/project_details/structure/data/task.dart';

const AllName = "Tous";
const CompletedName = "Terminé";
const InProgressName = "En cours";

class ShowByStatusItem {
  final String name;

  ShowByStatusItem(this.name);
}

List<ShowByStatusItem> showByStatusItems = [
  ShowByStatusItem(AllName),
  ShowByStatusItem(CompletedName),
  ShowByStatusItem(InProgressName),
];

List<Phase> phases = [
  Phase(
    1,
    'Specification'.toUpperCase(),
    Priority.Normal,
    DateTime.now(),
    DateTime.now(),
    [],
    [
      Model.Action(
          1,
          "Développement d'une nouvelle interface utilisateur",
          DateTime.now(),
          DateTime.now().add(Duration(days: 30)),
          Status.inProgress,
          users.first,
          [
            Task(
                1,
                "Développement d'une nouvelle interface utilisateur",
                DateTime.now(),
                DateTime.now().add(Duration(days: 64)),
                Status.completed,
                users.elementAt(2),
                [],
                Priority.Important),
            Task(
                2,
                "Développement d'une nouvelle interface",
                DateTime.now(),
                DateTime.now().add(Duration(days: 10)),
                Status.inProgress,
users.elementAt(3),
                [
                  Document(
                      55,
                      "Développement d'une nouvelle interface utilisateur",
                      "url",
                      "PDF",
                      users.elementAt(4),
                      DateTime.now(),
                      656848),
                  Document(
                      55,
                      "Développement d'une nouvelle interface utilisateur",
                      "url",
                      "PDF",
                      users.elementAt(4),
                      DateTime.now(),
                      656848),
                ],
                Priority.Low),
            Task(
                656,
                "Développement du service web",
                DateTime.now(),
                DateTime.now().add(Duration(days: 22)),
                Status.inProgress,
                users.elementAt(5),
                [],
                Priority.Important),
          ],
          [
            Document(
                55,
                "Développement d'une nouvelle interface utilisateur",
                "url",
                "PDF",
                users.elementAt(5),
                DateTime.now(),
                656848),
            Document(
                55,
                "Développement d'une nouvelle interface utilisateur",
                "url",
                "PDF",
                users.elementAt(5),
                DateTime.now(),
                656848),
          ],
          Priority.Normal),
      Model.Action(
          2,
          "Développement du service web",
          DateTime.now(),
          DateTime.now().add(Duration(days: 87)),
          Status.completed,
          users.elementAt(0),
          [
            Task(
                1,
                "Développement d'une nouvelle interface utilisateur",
                DateTime.now(),
                DateTime.now().add(Duration(days: 40)),
                Status.completed,
                users.elementAt(3),
                [
                  Document(
                      55,
                      "Développement d'une nouvelle interface utilisateur",
                      "url",
                      "PDF",
                      users.elementAt(5),
                      DateTime.now(),
                      656848),
                ],
                Priority.Important),
            Task(
                879,
                "Développement du service web",
                DateTime.now(),
                DateTime.now().subtract(Duration(days: 11)),
                Status.completed,
                users.elementAt(1),
                [
                  Document(
                      55,
                      "Développement d'une nouvelle interface utilisateur",
                      "url",
                      "PDF",
                      users.elementAt(5),
                      DateTime.now(),
                      656848),
                  Document(
                      55,
                      "Développement d'une nouvelle interface utilisateur",
                      "url",
                      "PDF",
                      users.elementAt(5),
                      DateTime.now(),
                      656848),
                ],
                Priority.Normal),
            Task(
                3131365,
                "Développement d'une nouvelle interface utilisateur",
                DateTime.now(),
                DateTime.now().add(Duration(days: 11)),
                Status.approved,
                users.elementAt(2),
                [
                  Document(
                      55,
                      "Développement d'une nouvelle interface utilisateur",
                      "url",
                      "PDF",
                      users.elementAt(5),
                      DateTime.now(),
                      656848),
                ],
                Priority.Normal),
          ],
          [
            Document(
                55,
                "Développement d'une nouvelle interface utilisateur",
                "url",
                "PDF",
                users.elementAt(5),
                DateTime.now(),
                656848),
          ],
          Priority.Important)
    ],
    DateTime.now(),
    DateTime.now(),
  ),
  Phase(
    2,
    'Développement'.toUpperCase(),
    Priority.Normal,
    DateTime.now(),
    DateTime.now(),
    [],
    [
      Model.Action(
          56456,
          "Développement d'une nouvelle interface utilisateur",
          DateTime.now(),
          DateTime.now().add(Duration(days: 30)),
          Status.inProgress,
          users.elementAt(2),
          [
            Task(
                257,
                "Développement d'une nouvelle interface utilisateur",
                DateTime.now(),
                DateTime.now().add(Duration(days: 64)),
                Status.completed,
                users.elementAt(5),
                [],
                Priority.Important),
            Task(
                99748,
                "Développement d'une nouvelle interface",
                DateTime.now(),
                DateTime.now().add(Duration(days: 10)),
                Status.completed,
                users.elementAt(3),
                [
                  Document(
                      55,
                      "Développement d'une nouvelle interface utilisateur",
                      "url",
                      "PDF",
                      users.elementAt(5),
                      DateTime.now(),
                      656848),
                  Document(
                      55,
                      "Développement d'une nouvelle interface utilisateur",
                      "url",
                      "PDF",
                      users.elementAt(5),
                      DateTime.now(),
                      656848),
                ],
                Priority.Low),
            Task(
                3261,
                "Développement du service web",
                DateTime.now(),
                DateTime.now().add(Duration(days: 22)),
                Status.inProgress,
                users.elementAt(3),
                [],
                Priority.Important),
          ],
          [
            Document(
                55,
                "Développement d'une nouvelle interface utilisateur",
                "url",
                "PDF",
                users.elementAt(5),
                DateTime.now(),
                656848),
            Document(
                55,
                "Développement d'une nouvelle interface utilisateur",
                "url",
                "PDF",
                users.elementAt(5),
                DateTime.now(),
                656848),
          ],
          Priority.Normal),
      Model.Action(
          89787,
          "Développement du service web",
          DateTime.now(),
          DateTime.now().add(Duration(days: 87)),
          Status.completed,
          users.elementAt(1),
          [
            Task(
                15456,
                "Développement d'une nouvelle interface utilisateur",
                DateTime.now(),
                DateTime.now().add(Duration(days: 40)),
                Status.completed,
                users.elementAt(0),
                [
                  Document(
                      55,
                      "Développement d'une nouvelle interface utilisateur",
                      "url",
                      "PDF",
                      users.elementAt(5),
                      DateTime.now(),
                      656848),
                ],
                Priority.Important),
            Task(
                1115,
                "Développement du service web",
                DateTime.now(),
                DateTime.now().subtract(Duration(days: 11)),
                Status.completed,
                users.elementAt(4),
                [
                  Document(
                      55,
                      "Développement d'une nouvelle interface utilisateur",
                      "url",
                      "PDF",
                      users.elementAt(5),
                      DateTime.now(),
                      656848),
                  Document(
                      55,
                      "Développement d'une nouvelle interface utilisateur",
                      "url",
                      "PDF",
                      users.elementAt(5),
                      DateTime.now(),
                      656848),
                ],
                Priority.Normal),
            Task(
                0654,
                "Développement d'une nouvelle interface utilisateur",
                DateTime.now(),
                DateTime.now().add(Duration(days: 11)),
                Status.approved,
                users.elementAt(3),
                [
                  Document(
                      55,
                      "Développement d'une nouvelle interface utilisateur",
                      "url",
                      "PDF",
                      users.elementAt(5),
                      DateTime.now(),
                      656848),
                ],
                Priority.Normal),
          ],
          [
            Document(
                55,
                "Développement d'une nouvelle interface utilisateur",
                "url",
                "PDF",
                users.elementAt(5),
                DateTime.now(),
                656848),
          ],
          Priority.Important),
      Model.Action(
          984,
          "Développement du service web",
          DateTime.now(),
          DateTime.now().add(Duration(days: 87)),
          Status.completed,
          users.elementAt(0),
          [
            Task(
                5576,
                "Développement d'une nouvelle interface utilisateur",
                DateTime.now(),
                DateTime.now().add(Duration(days: 40)),
                Status.completed,
                users.elementAt(6),
                [
                  Document(
                      55,
                      "Développement d'une nouvelle interface utilisateur",
                      "url",
                      "PDF",
                      users.elementAt(5),
                      DateTime.now(),
                      656848),
                ],
                Priority.Important),
            Task(
                698458,
                "Développement du service web",
                DateTime.now(),
                DateTime.now().subtract(Duration(days: 11)),
                Status.completed,
                users.elementAt(4),
                [
                  Document(
                      55,
                      "Développement d'une nouvelle interface utilisateur",
                      "url",
                      "PDF",
                      users.elementAt(5),
                      DateTime.now(),
                      656848),
                  Document(
                      55,
                      "Développement d'une nouvelle interface utilisateur",
                      "url",
                      "PDF",
                      users.elementAt(5),
                      DateTime.now(),
                      656848),
                ],
                Priority.Normal),
            Task(
                66454,
                "Développement d'une nouvelle interface utilisateur",
                DateTime.now(),
                DateTime.now().add(Duration(days: 11)),
                Status.approved,
                users.elementAt(5),
                [
                  Document(
                      55,
                      "Développement d'une nouvelle interface utilisateur",
                      "url",
                      "PDF",
                      users.elementAt(5),
                      DateTime.now(),
                      656848),
                ],
                Priority.Normal),
          ],
          [
            Document(
                55,
                "Développement d'une nouvelle interface utilisateur",
                "url",
                "PDF",
users.elementAt(5),
                DateTime.now(),
                656848),
          ],
          Priority.Important)
    ],
    DateTime.now(),
    DateTime.now(),
  ),
  //Phase(2, 'name')
];
