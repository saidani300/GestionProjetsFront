import 'package:gestion_projets/pages/people/Data/user.dart';
import 'package:gestion_projets/pages/projects/Data/project.dart';
import 'package:gestion_projets/pages/projects/project_details/documents/data/document.dart';
import 'package:gestion_projets/pages/projects/project_details/structure/data/phase.dart'
    as Model;

class Task {
  int id;
  String name;
  DateTime startDate;
  DateTime endDate;
  Model.Status status;
  User user;
  List<Document> documents;
  Priority priority;

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
