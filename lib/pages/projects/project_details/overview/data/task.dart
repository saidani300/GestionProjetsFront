import 'package:gestion_projets/pages/projects/Data/project.dart';
import 'package:gestion_projets/pages/projects/project_details/documents/data/document.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data/phase.dart'
    as Model;
import 'package:gestion_projets/pages/people/Data/user.dart';

class Task {
  final int id;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  Model.Status status;
  final User user;
  final List<Document> documents;
  final Priority priority;

  Task(this.id, this.name, this.startDate, this.endDate, this.status, this.user,
      this.documents, this.priority);

  Task.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        startDate = json['startDate'],
        endDate = json['endDate'],
        status = json['status'],
        user = json['user'],
        documents = json['documents'],
        priority = json['priority'];
}
