import 'package:gestion_projets/pages/projects/project_details/overview/data_layer/action.dart';

enum status{
  inProgress, //0
  completed //1
}
class Phase {


  int id;
  String name;
//  final DateTime creationDate;
 // final DateTime updateDate;
 // final List<Action> actions;

  Phase(this.id , this.name);

  Phase.fromJson(Map json)
      : id = json['id'],
        name = json['name'];
      //  creationDate = json['creationDate'],
      //  updateDate = json['updateDate'],
      //  actions = json['actions'];
}
