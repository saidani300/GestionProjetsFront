import 'package:gestion_projets/pages/projects/project_details/overview/data/action.dart';

enum Status {
  inProgress, //0
  completed, //1
  approved
}
enum Priority { Important, Normal, Low }

class Phase {
  int id;
  String name;
  final DateTime creationDate;
  final DateTime updateDate;
  final List<Action> actions;

  Phase(this.id, this.name, this.creationDate, this.updateDate, this.actions);

  Phase.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        creationDate = json['creationDate'],
        updateDate = json['updateDate'],
        actions = json['actions'];
}
