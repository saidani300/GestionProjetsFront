import 'package:gestion_projets/pages/projects/project_details/overview/data/phase.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data/user.dart';

class ProjectFilter {
  Status? status;
  DateTime? startDate;
  DateTime? endDate;
  List<User>? users;
  List<String>? types;

  ProjectFilter(
      this.status, this.startDate, this.endDate, this.users, this.types);
}