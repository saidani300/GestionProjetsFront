import 'package:gestion_projets/pages/projects/project_details/overview/data/document.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data/phase.dart'
    as Model;
import 'package:gestion_projets/pages/projects/project_details/overview/data/task.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data/user.dart';

class Action {
  final int id;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  Model.Status status;
  final User user;
  final List<Task> tasks;
  final List<Document> documents;
  final Model.Priority priority;

  Action(this.id, this.name, this.startDate, this.endDate, this.status,
      this.user, this.tasks, this.documents, this.priority);

  Action.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        startDate = json['startDate'],
        endDate = json['endDate'],
        status = json['status'],
        user = json['user'],
        tasks = json['tasks'],
        documents = json['documents'],
        priority = json['priority'];
}
