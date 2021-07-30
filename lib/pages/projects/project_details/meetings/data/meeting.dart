import 'package:gestion_projets/pages/projects/project_details/documents/data/document.dart';
import 'package:gestion_projets/pages/people/Data/user.dart';
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
  final String time;
  final MeetingStatus status;
  final List<User> participants;
  final List<Document> documents;

  Meeting(this.id, this.name, this.date, this.time ,this.comment, this.participants, this.status, this.documents );

  Meeting.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        date = DateTime.parse(json['date']),
        comment = json['comment'],
        status = MeetingStatus.values.elementAt(json['status']),
        participants =
            List<User>.from(json["participants"].map((x) => User.fromJson(x)))
                .toList(),
        time = json['time'],
        documents = List<Document>.from(
            json["documents"].map((x) => Document.fromJson(x))).toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'date': date.toIso8601String(),
         'time': time,
        'comment': comment,
        'status': status.index,
        'participants': participants.map((x) => x.toJson()).toList(),
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
      DateTime.now().add(Duration(days: 8)),
      '10:00',
      "",
      [users.first, users.elementAt(1) , users.elementAt(2), users.elementAt(3)],
      MeetingStatus.programmed,
      []),
  Meeting(
      455,
      "Retard potentiel pour une tâche",
      DateTime.now().add(Duration(days: 10)),
      '8:00',
      "",
      [users.first, users.elementAt(1)],
      MeetingStatus.inProgress,
      []),
  Meeting(
      687444,
      "Retard potentiel pour une tâche",
      DateTime.now().add(Duration(days: 2)),
      '12:00',
      "",
      [users.first, users.elementAt(1)],
      MeetingStatus.inProgress,
      []),
  Meeting(
      687444,
      "Retard potentiel pour une tâche",
      DateTime.now().add(Duration(days: 0)),
      '13:00',
      "",
      [users.first, users.elementAt(1) ,users.elementAt(6) ,users.elementAt(4)],
      MeetingStatus.completed,
      []),
  Meeting(
      687444,
      "Retard potentiel pour une tâche",
      DateTime.now().add(Duration(days: 0)),
      '10:00',
      "",
      [users.first, users.elementAt(1) ,users.elementAt(3)],
      MeetingStatus.completed,
      []),
];
