import 'dart:ui';

import 'package:gestion_projets/pages/people/Data/user.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/data/event.dart';
class EventFilter {
  bool allLevels;
  bool allUsers;
  bool date;
  List<EventLevel> levels;
  List<User> users;
  DateTime identificationDate;
  EventType? type;
  String searchQuery;
  EventFilter(this.allLevels, this.allUsers, this.date, this.levels, this.users, this.identificationDate, this.type ,  this.searchQuery);

}

EventFilter eventFilter = EventFilter(
    true, true, false, List.from(EventLevel.values), List.from(users),  DateTime(DateTime.now().year-1, DateTime.now().month , DateTime.now().day),null, "" );


enum EventOrderByProperties
{
  name,
  identificationDate,
  user,
  level,
}

String eventOrderByAsText(EventOrderByProperties eventOrderByProperties)
{
  switch(eventOrderByProperties)
  {
    case EventOrderByProperties.name :
      return 'Nom';
    case EventOrderByProperties.identificationDate :
      return "Date d'identification";
    case EventOrderByProperties.user :
      return "Identifié par";
    case EventOrderByProperties.level :
      return 'Niveau';
  }
}

class EventListOrder
{
  bool isAscending;
  EventOrderByProperties orderBy;

  EventListOrder(this.isAscending, this.orderBy);
}

EventListOrder eventListOrder = EventListOrder(true, EventOrderByProperties.name);