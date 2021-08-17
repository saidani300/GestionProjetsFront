import 'dart:async';

import 'package:gestion_projets/pages/projects/project_details/objectives/data/indicator.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/data/indicator_filter_data.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/data/measure.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/data/objective.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/data/objective_filter_data.dart';

import 'bloc.dart';

class ObjectiveBloc implements Bloc {
  final _controller = StreamController<List<Objective>>.broadcast();

  Stream<List<Objective>> get objectiveStream => _controller.stream;

  Future init() async {
    await Future.delayed(
        Duration(milliseconds: 300), () => _controller.sink.add(filter(objectives)));
  }

  fetch() {
    _controller.sink.add(filter(objectives));
  }

  remove(Objective objective) async {
    objectives.remove(objective);

    _controller.sink.add(filter(objectives));
  }

  removeIndicator(Objective objective, Indicator indicator) async {
    objective.indicators.remove(indicator);
    _controller.sink.add(filter(objectives));
  }

  removeMeasure(Indicator indicator, Measure measure) async {
    indicator.measures.remove(measure);
    _controller.sink.add(filter(objectives));
  }

  addMeasure(Indicator indicator, Measure measure) async {
    indicator.measures.insert(0, measure);
    _controller.sink.add(filter(objectives));
  }

  add(Objective objective) async {
    objectives.insert(0, objective);
    _controller.sink.add(filter(objectives));
  }

  addIndicator(Objective objective, Indicator indicator) async {
    objective.indicators.insert(0, indicator);
    _controller.sink.add(filter(objectives));
  }

  List<Objective> filter(List<Objective> initList) {
    List<Objective> result = initList;
    switch (objectiveFilter.status) {
      case null:
        break;
      case ObjectiveStatus.inProgress:
        result = result
            .where((element) => identical(element.status, ObjectiveStatus.inProgress))
            .toList();
        break;
      case ObjectiveStatus.notAchieved:
        result = result
            .where((element) => identical(element.status, ObjectiveStatus.notAchieved))
            .toList();
        break;
      case ObjectiveStatus.achieved:
        result = result
            .where((element) => identical(element.status, ObjectiveStatus.achieved))
            .toList();
        break;
    }
    result = result
        .where((element) => element.name
        .toLowerCase()
        .contains(objectiveFilter.searchQuery.toLowerCase()))
        .toList();

    result = propertiesFilter(result);

    orderBy(result);

    measureOrderBy(result);

    return result;
  }

  List<Objective> propertiesFilter(List<Objective> list)
  {
    if(objectiveFilter.allUsers== false)
      list = list.where((element) => objectiveFilter.users.contains(element.user)).toList();
    if(objectiveFilter.allPriorities== false)
      list = list.where((element) => objectiveFilter.priorities.contains(element.priority)).toList();
    if(objectiveFilter.date)
      list = list.where((element) => element.creationDate.isAfter(objectiveFilter.creationDate) && element.endDate.isBefore(objectiveFilter.endDate)).toList();
    return list;
  }

  orderBy(List<Objective> list)
  {
    switch(objectiveListOrder.orderBy)
    {
      case ObjectiveOrderByProperties.name:
        (objectiveListOrder.isAscending) ? list.sort((a, b) => a.name.compareTo(b.name)) :
        list.sort((a, b) => b.name.compareTo(a.name));
        break;
      case ObjectiveOrderByProperties.creationDate:
        (objectiveListOrder.isAscending) ? list.sort((a, b) => a.creationDate.compareTo(b.creationDate)) :
        list.sort((a, b) => b.creationDate.compareTo(a.creationDate));
        break;
      case ObjectiveOrderByProperties.endDate:
        (objectiveListOrder.isAscending) ? list.sort((a, b) => a.endDate.compareTo(b.endDate)) :
        list.sort((a, b) => b.endDate.compareTo(a.endDate));
        break;
      case ObjectiveOrderByProperties.user:
        (objectiveListOrder.isAscending) ? list.sort((a, b) => a.user.name.compareTo(b.user.name)) :
        list.sort((a, b) => b.user.name.compareTo(a.user.name));
        break;
      case ObjectiveOrderByProperties.status:
        (objectiveListOrder.isAscending) ? list.sort((a, b) => a.status.index.compareTo(b.status.index)) :
        list.sort((a, b) => b.status.index.compareTo(a.status.index));
        break;
      case ObjectiveOrderByProperties.priority:
        (objectiveListOrder.isAscending) ? list.sort((a, b) => a.priority.index.compareTo(b.priority.index)) :
        list.sort((a, b) => b.priority.index.compareTo(a.priority.index));
        break;
    }
  }

  measureOrderBy(List<Objective> list)
  {
    list.forEach((e) {
      e.indicators.forEach((element) {
    switch(indicatorListOrder.orderBy)
    {
      case IndicatorOrderByProperties.measure:
        (indicatorListOrder.isAscending) ? element.measures.sort((a, b) => a.value.compareTo(b.value)) :
        element.measures.sort((a, b) => b.value.compareTo(a.value));
        break;
      case IndicatorOrderByProperties.difference:
        (indicatorListOrder.isAscending) ? element.measures.sort((a, b) => (a.value - element.criticalThreshold).compareTo(b.value - element.criticalThreshold)) :
        element.measures.sort((a, b) => (b.value - element.criticalThreshold).compareTo((a.value - element.criticalThreshold)));
        break;
      case IndicatorOrderByProperties.startDate:
        (indicatorListOrder.isAscending) ? element.measures.sort((a, b) => a.startDate.compareTo(b.startDate)) :
        element.measures.sort((a, b) => b.startDate.compareTo(a.startDate));
        break;
      case IndicatorOrderByProperties.endDate:
        (indicatorListOrder.isAscending) ? element.measures.sort((a, b) => a.endDate.compareTo(b.endDate)) :
        element.measures.sort((a, b) => b.endDate.compareTo(a.endDate));
        break;
    }
      });
    });
  }
  
  @override
  void dispose() {
    _controller.close();
  }
}
