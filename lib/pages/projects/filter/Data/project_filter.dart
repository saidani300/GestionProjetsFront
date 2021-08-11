import 'package:gestion_projets/pages/people/Data/user.dart';
import 'package:gestion_projets/pages/projects/project_details/structure/data/phase.dart';

enum ProjectOrderByProperties
{
  name,
  type,
  startDate,
  endDate,
  teamLeader,
  status,
  priority,
}

String projectOrderByAsText(ProjectOrderByProperties projectOrderByProperties)
{
  switch(projectOrderByProperties)
  {
    case ProjectOrderByProperties.name :
      return 'Nom';
    case ProjectOrderByProperties.type :
      return 'Type';
    case ProjectOrderByProperties.startDate :
      return 'Date de début';
    case ProjectOrderByProperties.endDate :
      return 'Date limite';
    case ProjectOrderByProperties.teamLeader :
      return "Chef d'équipe";
    case ProjectOrderByProperties.priority :
      return 'Priorité';
    case ProjectOrderByProperties.status :
      return 'Statut';
  }
}

class ProjectGlobalFilter {
  Status? status;
  DateTime? startDate;
  DateTime? endDate;
  List<User>? users;
  List<String>? types;

  ProjectGlobalFilter(
      this.status, this.startDate, this.endDate, this.users, this.types);
}


class ProjectListOrder
{
  bool isAscending;
  ProjectOrderByProperties orderBy;

  ProjectListOrder(this.isAscending, this.orderBy);
}

ProjectListOrder projectListOrder = ProjectListOrder(true, ProjectOrderByProperties.name);