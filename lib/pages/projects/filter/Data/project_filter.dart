import 'package:gestion_projets/pages/people/Data/user.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data/phase.dart';

class ProjectFilter {
  Status? status;
  DateTime? startDate;
  DateTime? endDate;
  List<User>? users;
  List<String>? types;

  ProjectFilter(
      this.status, this.startDate, this.endDate, this.users, this.types);
}
