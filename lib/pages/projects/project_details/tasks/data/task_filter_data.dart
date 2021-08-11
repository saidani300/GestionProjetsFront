import 'package:gestion_projets/pages/people/Data/user.dart';
import 'package:gestion_projets/pages/projects/Data/project.dart';
import 'package:gestion_projets/pages/projects/project_details/structure/data/phase.dart';

class TaskFilter {
  bool allPriorities;
  bool allUsers;
  bool date;
  List<Priority> priorities;
  List<User> users;
  DateTime startDate;
  DateTime endDate;
  Status? status;
  String searchQuery;
  TaskFilter(this.allPriorities, this.allUsers, this.date, this.priorities, this.users, this.startDate, this.endDate , this.status , this.searchQuery);

}

TaskFilter taskFilter = TaskFilter(
     true, true, false, List.from(Priority.values), List.from(users),  DateTime(DateTime.now().year , DateTime.now().month -6 , DateTime.now().day),
    DateTime(DateTime.now().year , DateTime.now().month +6 , DateTime.now().day) ,null , "" );


enum TaskOrderByProperties
{
  name,
  startDate,
  endDate,
  user,
  status,
  priority,
}

String taskOrderByAsText(TaskOrderByProperties taskOrderByProperties)
{
  switch(taskOrderByProperties)
  {
    case TaskOrderByProperties.name :
      return 'Nom';
    case TaskOrderByProperties.startDate :
      return 'Date de début';
    case TaskOrderByProperties.endDate :
      return 'Date de fin';
    case TaskOrderByProperties.user :
      return "Affecter à";
    case TaskOrderByProperties.priority :
      return 'Priorité';
    case TaskOrderByProperties.status :
      return 'Statut';
  }
}

class TaskListOrder
{
  bool isAscending;
  TaskOrderByProperties orderBy;

  TaskListOrder(this.isAscending, this.orderBy);
}

TaskListOrder taskListOrder = TaskListOrder(true, TaskOrderByProperties.name);