import 'package:gestion_projets/pages/projects/project_details/documents/data/document.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data/user.dart';

class Folder
{
  final int id;
  final String name;
  final List<Document> documents;

  Folder(this.id, this.name, this.documents);
}


List<Folder> documents =
    [
      Folder(1, "Tous", [
        Document(98, "Développement d'une nouvelle interface utilisateur", "url", "PDF", User(12,"Saidani Wael" , "3"), DateTime.now(), 656848 ),
        Document(8, "Développement d'une nouvelle interface utilisateur", "url", "PDF", User(18,"Saidani Wael" , "5"), DateTime.now(), 155249877),
        Document(807, "Développement d'une nouvelle interface utilisateur", "url", "PDF", User(18,"Saidani Wael" , "5"), DateTime.now(), 656848),
        Document(84, "Développement d'une nouvelle interface utilisateur", "url", "PDF", User(18,"Saidani Wael" , "5"), DateTime.now(), 656848),
        Document(81, "Développement d'une nouvelle interface utilisateur", "url", "PDF", User(18,"Saidani Wael" , "5"), DateTime.now(), 656848),
        Document(878, "Développement d'une nouvelle interface utilisateur", "url", "PDF", User(18,"Saidani Wael" , "5"), DateTime.now(), 7856848),
        Document(830, "Développement d'une nouvelle interface utilisateur", "url", "PDF", User(18,"Saidani Wael" , "5"), DateTime.now(), 656848),
        Document(844, "Développement d'une nouvelle interface utilisateur", "url", "PDF", User(18,"Saidani Wael" , "5"), DateTime.now(), 656848)
      ]),

      Folder(12, "Développement d'une nouvelle interface utilisateur", [
        Document(55, "Développement d'une nouvelle interface utilisateur", "url", "PDF", User(12,"Saidani Wael" , "3"), DateTime.now(), 656848),
        Document(887, "Développement d'une nouvelle interface utilisateur", "url", "PDF", User(18,"Saidani Wael" , "5"), DateTime.now(), 6568485)
      ]),

      Folder(656, "Développement d'une nouvelle interface utilisateur", [
        Document(4454, "Développement d'une nouvelle interface utilisateur", "url", "PDF", User(12,"Saidani Wael" , "1"), DateTime.now(), 656848),
        Document(4545454, "Développement d'une nouvelle interface utilisateur", "url", "PDF", User(18,"Saidani Wael" , "8"), DateTime.now(), 656848)
      ])
    ];