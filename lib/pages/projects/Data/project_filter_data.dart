import 'package:gestion_projets/pages/people/Data/user.dart';
import 'package:gestion_projets/pages/projects/Data/project.dart';
import 'package:gestion_projets/pages/projects/Data/project_type.dart';

class ProjectFilter {
  bool allTypes;
  bool allPriorities;
  bool allUsers;
  bool date;
  List<ProjectType> types;
  List<Priority> priorities;
  List<User> users;
  DateTime startDate;
  DateTime endDate;

  ProjectFilter(this.allTypes, this.allPriorities, this.allUsers, this.date,
      this.types, this.priorities, this.users, this.startDate, this.endDate);

  toString() {
    String string = '';
    types.forEach((element) {
      string = string + element.name + "  ";
    });
    return string;
  }
}

ProjectFilter projectFilter = ProjectFilter(
    true, true, true, false, List.from(projectTypesList), List.from(Priority.values), List.from(users),  DateTime(DateTime.now().year -1 , DateTime.now().month , DateTime.now().day),
    DateTime(DateTime.now().year + 1 , DateTime.now().month , DateTime.now().day));
