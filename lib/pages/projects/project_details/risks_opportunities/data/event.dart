import 'package:gestion_projets/pages/projects/project_details/overview/data_layer/document.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data_layer/user.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/data/evaluation.dart';

enum EventType{
   Risk,
  Opportunity,
}

enum EventLevel
{
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


  Event(this.id, this.name, this.type, this.impact, this.cause, this.source, this.identificationDate, this.eventType, this.level, this.user, this.evaluations, this.documents);

}

List<Event> events = [
  Event(5487, "Retard potentiel pour une tâche", "Chronologie", "Retard dans la prochaine action", "Ressources humaines", "Développement d'une nouvelle interface utilisateur", DateTime.now(), EventType.Risk, EventLevel.medium, User(12,"Saidani Wael","3"), [] ,[]),
  Event(8784, "Retard potentiel pour une tâche", "Chronologie", "Retard dans la prochaine action", "Ressources humaines", "Développement d'une nouvelle interface utilisateur", DateTime.now(), EventType.Risk, EventLevel.high, User(12,"Saidani Wael","4"), [],[]),
  Event(84, "Retard potentiel pour une tâche", "Chronologie", "Retard dans la prochaine action", "Ressources humaines", "Développement d'une nouvelle interface utilisateur", DateTime.now(), EventType.Opportunity, EventLevel.low, User(12,"Saidani Wael","4"), [],[]),

];

