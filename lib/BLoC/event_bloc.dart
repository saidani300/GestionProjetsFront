import 'dart:async';

import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/data/calculation.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/data/evaluation.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/data/evaluation_filter_data.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/data/event.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/data/event_filter_data.dart';

import 'bloc.dart';

class EventBloc implements Bloc {
  final _controller = StreamController<List<Event>>.broadcast();

  Stream<List<Event>> get eventStream => _controller.stream;

  Future init() async {
    await Future.delayed(
        Duration(milliseconds: 300), () => _controller.sink.add(filter(events)));
  }

  fetch() {
    _controller.sink.add(filter(events));
  }

  remove(Event event) async {
    events.remove(event);

    _controller.sink.add(filter(events));
  }

  add(Event event) async {
    events.insert(0, event);
    _controller.sink.add(filter(events));
  }

  addEvaluation(Event event, Evaluation evaluation) async {
    event.evaluations.insert(0, evaluation);
    _controller.sink.add(filter(events));
  }

  removeCalculation(Evaluation evaluation, Calculation calculation) async {
    evaluation.calculations.remove(calculation);
    _controller.sink.add(filter(events));
  }

  addCalculation(Evaluation evaluation, Calculation calculation) async {
    evaluation.calculations.insert(0, calculation);
    _controller.sink.add(filter(events));
  }

  removeEvaluation(Event event, Evaluation evaluation) async {
    event.evaluations.remove(evaluation);
    _controller.sink.add(filter(events));
  }


  List<Event> filter(List<Event> initList) {
    List<Event> result = initList;
    //Type Filter
    result =filterByType(result);
    //SearchByQuery
    result = result.where((element) => element.name.toLowerCase().contains(eventFilter.searchQuery.toLowerCase())).toList();
    //Properties Filter
    result = propertiesFilter(result);
    //Order By
    orderBy(result);
    //Evaluations order by
    evaluationOrderBy(result);
    return result;
  }


  List<Event> filterByType(List<Event> list)
  {
    switch (eventFilter.type) {
      case null:
        break;
      case EventType.Opportunity:
        list = list.where((element) => identical(element.eventType, EventType.Opportunity)).toList();
        break;
      case EventType.Risk:
        list = list.where((element) => identical(element.eventType, EventType.Risk)).toList();
        break;
    }
    return list;
  }


  List<Event> propertiesFilter(List<Event> list)
  {
    if(eventFilter.allUsers== false)
      list = list.where((element) => eventFilter.users.contains(element.user)).toList();
    if(eventFilter.allLevels== false)
      list = list.where((element) => eventFilter.levels.contains(element.level)).toList();
    if(eventFilter.date)
      list = list.where((element) => element.identificationDate.isBefore(eventFilter.identificationDate)).toList();
    return list;
  }

  orderBy(List<Event> list)
  {
    switch(eventListOrder.orderBy)
    {
      case EventOrderByProperties.name:
        (eventListOrder.isAscending) ? list.sort((a, b) => a.name.compareTo(b.name)) :
        list.sort((a, b) => b.name.compareTo(a.name));
        break;
      case EventOrderByProperties.identificationDate:
        (eventListOrder.isAscending) ? list.sort((a, b) => a.identificationDate.compareTo(b.identificationDate)) :
        list.sort((a, b) => b.identificationDate.compareTo(a.identificationDate));
        break;
      case EventOrderByProperties.user:
        (eventListOrder.isAscending) ? list.sort((a, b) => a.user.name.compareTo(b.user.name)) :
        list.sort((a, b) => b.user.name.compareTo(a.user.name));
        break;
      case EventOrderByProperties.level:
        (eventListOrder.isAscending) ? list.sort((a, b) => a.level.index.compareTo(b.level.index)) :
        list.sort((a, b) => b.level.index.compareTo(a.level.index));
        break;
    }
  }
  evaluationOrderBy(List<Event> list)
  {
    list.forEach((element) {
        switch(evaluationListOrder.orderBy)
        {
          case EvaluationOrderByProperties.name:
            (evaluationListOrder.isAscending) ? element.evaluations.sort((a, b) => a.name.compareTo(b.name)) :
            element.evaluations.sort((a, b) => b.name.compareTo(a.name));
            break;
          case EvaluationOrderByProperties.calculationsNumber:
            (evaluationListOrder.isAscending) ? element.evaluations.sort((a, b) => a.calculations.length.compareTo(b.calculations.length)) :
            element.evaluations.sort((a, b) => b.calculations.length.compareTo(a.calculations.length));
            break;
          case EvaluationOrderByProperties.creationDate:
            (evaluationListOrder.isAscending) ? element.evaluations.sort((a, b) => a.creationDate.compareTo(b.creationDate)) :
            element.evaluations.sort((a, b) => b.creationDate.compareTo(a.creationDate));
            break;
          case EvaluationOrderByProperties.user:
            (evaluationListOrder.isAscending) ? element.evaluations.sort((a, b) => a.user.name.compareTo(b.user.name)) :
            element.evaluations.sort((a, b) => b.user.name.compareTo(a.user.name));
            break;
        }
    });
  }
  @override
  void dispose() {
    _controller.close();
  }
}
