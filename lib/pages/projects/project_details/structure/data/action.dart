import 'package:gestion_projets/pages/people/Data/user.dart';
import 'package:gestion_projets/pages/projects/Data/project.dart';
import 'package:gestion_projets/pages/projects/project_details/documents/data/document.dart';
import 'package:gestion_projets/pages/projects/project_details/structure/data/phase.dart'
    as Model;
import 'package:gestion_projets/pages/projects/project_details/structure/data/task.dart';

class Action {
  int id;
  String name;
  DateTime startDate;
  DateTime endDate;
  Model.Status status;
  User user;
  List<Task> tasks;
  List<Document> documents;
  Priority priority;

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
