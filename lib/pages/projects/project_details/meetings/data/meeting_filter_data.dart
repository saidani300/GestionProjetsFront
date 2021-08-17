import 'package:flutter/material.dart';
import 'package:gestion_projets/pages/projects/project_details/meetings/data/meeting.dart';

class MeetingFilter {
  bool allStatutes;
  bool date;
  bool time;
  List<MeetingStatus> statutes;
  DateTime startDate;
  DateTime endDate;
  TimeOfDay startTime;
  TimeOfDay endTime;
  String searchQuery;
  MeetingFilter(this.allStatutes,this.date, this.time, this.statutes, this.startDate, this.endDate, this.startTime , this.endTime,  this.searchQuery);

}

MeetingFilter meetingFilter = MeetingFilter(true, false, false, List.from(MeetingStatus.values),DateTime(DateTime.now().year, DateTime.now().month -2 , DateTime.now().day),
    DateTime(DateTime.now().year, DateTime.now().month +2 , DateTime.now().day) , TimeOfDay(hour: 7 , minute: 0 ) ,TimeOfDay(hour: 19 , minute: 0 ), "" );


enum MeetingOrderByProperties
{
  name,
  date,
  time,
  status,
}

String meetingOrderByAsText(MeetingOrderByProperties meetingOrderByProperties)
{
  switch(meetingOrderByProperties)
  {
    case MeetingOrderByProperties.name :
      return 'Titre';
    case MeetingOrderByProperties.date :
      return "Date";
    case MeetingOrderByProperties.time :
      return "Heure";
    case MeetingOrderByProperties.status :
      return 'Statut';
  }
}

class MeetingListOrder
{
  bool isAscending;
  MeetingOrderByProperties orderBy;

  MeetingListOrder(this.isAscending, this.orderBy);
}

MeetingListOrder meetingListOrder = MeetingListOrder(true, MeetingOrderByProperties.name);