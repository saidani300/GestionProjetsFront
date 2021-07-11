import 'package:gestion_projets/pages/projects/project_details/overview/data_layer/task.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data_layer/user.dart';

class Action {
  final int id;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final int status;
  final User user;
  final List<Task> tasks;

  Action.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        startDate = json['startDate'],
        endDate = json['endDate'],
        status = json['status'],
        user = json['user'],
        tasks = json['tasks'];
}
