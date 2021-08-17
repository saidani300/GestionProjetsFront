import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gestion_projets/pages/projects/project_details/meetings/data/meeting.dart';
import 'package:gestion_projets/pages/projects/project_details/meetings/data/meeting_filter_data.dart';

import 'bloc.dart';

class MeetingBloc implements Bloc {
  final _controller = StreamController<List<Meeting>>.broadcast();

  Stream<List<Meeting>> get meetingStream => _controller.stream;

  Future init() async {
    Future.delayed(Duration(milliseconds: 300), () => _controller.sink.add(filter(meetings)));
  }

  fetch() {
    _controller.sink.add(filter(meetings));
  }

  remove(Meeting meeting) async {
    meetings.remove(meeting);
    _controller.sink.add(filter(meetings));
  }

  add(Meeting meeting) async {
    meetings.insert(0, meeting);
    _controller.sink.add(filter(meetings));
  }

  List<Meeting> filter(List<Meeting> initList) {
    List<Meeting> result = initList;
    result = result
        .where((element) => element.name
        .toLowerCase()
        .contains(meetingFilter.searchQuery.toLowerCase()))
        .toList();

    result = propertiesFilter(result);

    orderBy(result);

    return result;
  }
  double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute/60.0;
  TimeOfDay toTime(String value) => TimeOfDay(hour:int.parse(value.split(":")[0]),minute: int.parse(value.split(":")[1]));


  List<Meeting> propertiesFilter(List<Meeting> list)
  {
    if(meetingFilter.allStatutes== false)
      list = list.where((element) => meetingFilter.statutes.contains(element.status)).toList();
    if(meetingFilter.date)
      list = list.where((element) => element.date.isAfter(meetingFilter.startDate) && element.date.isBefore(meetingFilter.endDate)).toList();
    if(meetingFilter.time)
      list = list.where((element) {
      TimeOfDay time = toTime(element.time);
      return toDouble(time) >= toDouble(meetingFilter.startTime) && toDouble(time) <= toDouble(meetingFilter.endTime);}).toList();
    return list;
  }

  orderBy(List<Meeting> list)
  {
    switch(meetingListOrder.orderBy)
    {
      case MeetingOrderByProperties.name:
        (meetingListOrder.isAscending) ? list.sort((a, b) => a.name.compareTo(b.name)) :
        list.sort((a, b) => b.name.compareTo(a.name));
        break;
      case MeetingOrderByProperties.date:
        (meetingListOrder.isAscending) ? list.sort((a, b) => a.date.compareTo(b.date)) :
        list.sort((a, b) => b.date.compareTo(a.date));
        break;
      case MeetingOrderByProperties.time:
        (meetingListOrder.isAscending) ? list.sort((a, b) => toDouble(toTime(a.time)).compareTo(toDouble(toTime(b.time)))) :
        list.sort((a, b) => toDouble(toTime(b.time)).compareTo(toDouble(toTime(a.time))));
        break;
      case MeetingOrderByProperties.status:
        (meetingListOrder.isAscending) ? list.sort((a, b) => a.status.index.compareTo(b.status.index)) :
        list.sort((a, b) => b.status.index.compareTo(a.status.index));
        break;
    }
  }
  
  
  @override
  void dispose() {
    _controller.close();
  }
}

final meetingBloc = MeetingBloc();
