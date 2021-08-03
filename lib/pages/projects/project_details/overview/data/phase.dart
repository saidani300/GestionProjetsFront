import 'package:gestion_projets/pages/projects/Data/project.dart';
import 'package:gestion_projets/pages/projects/project_details/documents/data/document.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data/action.dart';

enum Status {
  inProgress, //0
  completed, //1
  approved
}

class Phase {
  int id;
  String name;
  Priority priority;
  DateTime creationDate= DateTime.now();
  DateTime updateDate= DateTime.now();
  DateTime startDate = DateTime.now();
  DateTime endDate= DateTime.now();
  List<Document> documents;
  List<Action> actions;

  Phase(this.id, this.name, this.priority, this.creationDate, this.updateDate,this.documents, this.actions , this.startDate , this.endDate );

  //TODO: Fix From and To json code
  Phase.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        creationDate = json['creationDate'],
        updateDate = json['updateDate'],
        startDate = json['startDate'],
        endDate = json['endDate'],
        documents = json['documents'],
        actions = json['actions'],
        priority = json['priority'];
}
