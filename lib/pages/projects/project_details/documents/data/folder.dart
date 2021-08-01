import 'package:gestion_projets/pages/people/Data/user.dart';
import 'package:gestion_projets/pages/projects/project_details/documents/data/document.dart';

class Folder {
  final int id;
  final String name;
  final List<Document> documents;

  Folder(this.id, this.name, this.documents);
}

List<Folder> documents = [
  Folder(1, "Tous", [
    Document(98, "Développement d'une nouvelle interface utilisateur", "url",
        "PDF", users.first, DateTime.now(), 656848),
    Document(8, "Développement d'une nouvelle interface utilisateur", "url",
        "PDF", users.elementAt(1), DateTime.now(), 155249877),
    Document(807, "Développement d'une nouvelle interface utilisateur", "url",
        "PDF", users.elementAt(2), DateTime.now(), 656848),
  ]),
  Folder(12, "Développement d'une nouvelle interface utilisateur", [
    Document(55, "Développement d'une nouvelle interface utilisateur", "url",
        "PDF", users.elementAt(3), DateTime.now(), 656848),
    Document(887, "Développement d'une nouvelle interface utilisateur", "url",
        "PDF", users.elementAt(4), DateTime.now(), 6568485)
  ]),
  Folder(656, "Développement d'une nouvelle interface utilisateur", [
    Document(4454, "Développement d'une nouvelle interface utilisateur", "url",
        "PDF", users.elementAt(5), DateTime.now(), 656848),
    Document(4545454, "Développement d'une nouvelle interface utilisateur",
        "url", "PDF", users.elementAt(6), DateTime.now(), 656848)
  ])
];
