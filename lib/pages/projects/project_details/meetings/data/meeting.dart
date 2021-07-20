import 'package:gestion_projets/pages/projects/project_details/overview/data/document.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data/user.dart';

enum MeetingStatus
{
  programmed,
  inProgress,
  completed,
}

class Meeting{
  final int id;
  final String name;
  final DateTime date;
  final String comment;
  final MeetingStatus status;
  final List<User> participants;
  final List<RelatedItem> relatedItems;
  final List<Document> documents;

  Meeting(this.id, this.name, this.date, this.comment, this.participants, this.relatedItems, this.status, this.documents);
}


class RelatedItem
{
  final int id;
  final String name;
  final ItemType type;

  RelatedItem(this.id, this.name, this.type);
}


enum ItemType{
  Phase,
  Action,
  Task,
  Objective,
  Risk,
  Opportunity,
}


List<Meeting> meetings = [

  Meeting(1, "Retard potentiel pour une tâche", DateTime.now().add(Duration(days: 13)), "", [User(1,"Saidani Wael" , "3") , User(3,"Saidani Wael" , "5")] , [
    RelatedItem(121, "Retard potentiel pour une tâche", ItemType.Risk),
    RelatedItem(487, "Développement d'une nouvelle interface utilisateur", ItemType.Task),

  ], MeetingStatus.programmed,[] ),
  Meeting(455, "Retard potentiel pour une tâche", DateTime.now().add(Duration(days: 13)), "", [User(1,"Saidani Wael" , "3") , User(3,"Saidani Wael" , "5")] , [
    RelatedItem(121, "Retard potentiel pour une tâche", ItemType.Risk),
    RelatedItem(487, "Développement d'une nouvelle interface utilisateur", ItemType.Objective),
    RelatedItem(47444, "Développement d'une nouvelle interface utilisateur", ItemType.Opportunity),
  ], MeetingStatus.programmed,[] )
];
