import 'package:gestion_projets/pages/projects/project_details/overview/data/document.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data/user.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
enum MeetingStatus {
  programmed,
  inProgress,
  completed,
}

class Meeting {
  final int id;
  final String name;
  final DateTime date;
  final String comment;
  final MeetingStatus status;
  final List<User> participants;
  final List<RelatedItem> relatedItems;
  final List<Document> documents;

  Meeting(this.id, this.name, this.date, this.comment, this.participants,
      this.relatedItems, this.status, this.documents);

  Meeting.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        date = DateTime.parse(json['date']),
        comment = json['comment'],
        status = MeetingStatus.values.elementAt(json['status']),
        participants =
            List<User>.from(json["participants"].map((x) => User.fromJson(x)))
                .toList(),
        relatedItems = List<RelatedItem>.from(
            json["relatedItems"].map((x) => RelatedItem.fromJson(x))).toList(),
        documents = List<Document>.from(
            json["documents"].map((x) => Document.fromJson(x))).toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'date': date.toIso8601String(),
        'comment': comment,
        'status': status.index,
        'participants': participants.map((x) => x.toJson()).toList(),
        'relatedItems': relatedItems.map((x) => x.toJson()).toList(),
        'documents': documents.map((x) => x.toJson()).toList(),
      };
}

class RelatedItem {
  final int id;
  final String name;
  final ItemType type;

  RelatedItem(this.id, this.name, this.type);

  RelatedItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        type = ItemType.values.elementAt(json['type']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'type': type.index,
      };
}

enum ItemType {
  Phase,
  Action,
  Task,
  Objective,
  Risk,
  Opportunity,
}

List<Meeting> meetings = [
  Meeting(
      1,
      "Retard potentiel pour une tâche",
      DateTime.now().add(Duration(days: 13)),
      "",
      [User(1, "Saidani Wael", "3"), User(3, "Saidani Wael", "5")],
      [
        RelatedItem(121, "Retard potentiel pour une tâche", ItemType.Risk),
        RelatedItem(487, "Développement d'une nouvelle interface utilisateur",
            ItemType.Task),
      ],
      MeetingStatus.programmed,
      []),
  Meeting(
      455,
      "Retard potentiel pour une tâche",
      DateTime.now().add(Duration(days: 13)),
      "",
      [User(1, "Saidani Wael", "3"), User(3, "Saidani Wael", "5")],
      [
        RelatedItem(121, "Retard potentiel pour une tâche", ItemType.Risk),
        RelatedItem(487, "Développement d'une nouvelle interface utilisateur",
            ItemType.Objective),
        RelatedItem(47444, "Développement d'une nouvelle interface utilisateur",
            ItemType.Opportunity),
      ],
      MeetingStatus.programmed,
      [])
];
