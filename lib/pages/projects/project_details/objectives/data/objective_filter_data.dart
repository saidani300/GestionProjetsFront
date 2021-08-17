import 'package:gestion_projets/pages/people/Data/user.dart';
import 'package:gestion_projets/pages/projects/Data/project.dart';
import 'package:gestion_projets/pages/projects/project_details/structure/data/phase.dart';

import 'objective.dart';

class ObjectiveFilter {
  bool allPriorities;
  bool allUsers;
  bool date;
  List<Priority> priorities;
  List<User> users;
  DateTime creationDate;
  DateTime endDate;
  ObjectiveStatus? status;
  String searchQuery;
  ObjectiveFilter(this.allPriorities, this.allUsers, this.date, this.priorities, this.users, this.creationDate, this.endDate , this.status , this.searchQuery);

}

ObjectiveFilter objectiveFilter = ObjectiveFilter(
    true, true, false, List.from(Priority.values), List.from(users),  DateTime(DateTime.now().year , DateTime.now().month -6 , DateTime.now().day),
    DateTime(DateTime.now().year , DateTime.now().month +6 , DateTime.now().day) ,null , "" );


enum ObjectiveOrderByProperties
{
  name,
  creationDate,
  endDate,
  user,
  status,
  priority,
}

String objectiveOrderByAsText(ObjectiveOrderByProperties objectiveOrderByProperties)
{
  switch(objectiveOrderByProperties)
  {
    case ObjectiveOrderByProperties.name :
      return 'Nom';
    case ObjectiveOrderByProperties.creationDate :
      return 'Date de création';
    case ObjectiveOrderByProperties.endDate :
      return 'Date de fin';
    case ObjectiveOrderByProperties.user :
      return "Créer par";
    case ObjectiveOrderByProperties.priority :
      return 'Priorité';
    case ObjectiveOrderByProperties.status :
      return 'Statut';
  }
}

class ObjectiveListOrder
{
  bool isAscending;
  ObjectiveOrderByProperties orderBy;

  ObjectiveListOrder(this.isAscending, this.orderBy);
}

ObjectiveListOrder objectiveListOrder = ObjectiveListOrder(true, ObjectiveOrderByProperties.name);