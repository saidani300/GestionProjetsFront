import 'dart:async';

import 'package:gestion_projets/pages/projects/Data/project.dart';
import 'package:gestion_projets/pages/projects/Data/project_filter_data.dart';
import 'package:gestion_projets/pages/projects/filter/Data/project_filter.dart';
import 'package:gestion_projets/pages/projects/project_details/structure/data/phase.dart';

import 'bloc.dart';

ProjectGlobalFilter projectsFilterData = ProjectGlobalFilter(null, null, null, null, null);

String projectsSearchQuery = '';

class ProjectBloc implements Bloc {
  final _controller = StreamController<List<Project>>.broadcast();


  Stream<List<Project>> get projectStream => _controller.stream;

  Future init() async {
    Future.delayed(Duration(milliseconds: 300),
        () => _controller.sink.add(filter(projects)));
  }

  fetch() {
    _controller.sink.add(filter(projects));
  }

  remove(Project project) async {
    projects.remove(project);

    _controller.sink.add(filter(projects));
  }

  add(Project project) async {
    projects.insert(0, project);
    _controller.sink.add(filter(projects));
  }

  List<Project> filter(List<Project> initList) {
    List<Project> result = initList;
    switch (projectsFilterData.status) {
      case null:
        break;
      case Status.approved:
        break;
      case Status.inProgress:
        result = result
            .where((project) => identical(project.status, Status.inProgress))
            .toList();
        break;
      case Status.completed:
        result = result
            .where((project) => identical(project.status, Status.completed))
            .toList();
        break;
    }
    result = result
        .where((project) => project.name
            .toLowerCase()
            .contains(projectsSearchQuery.toLowerCase()))
        .toList();

    result = propertiesFilter(result);

    orderBy(result);

    return result;
  }

  List<Project> propertiesFilter(List<Project> list)
  {
    if(projectFilter.allTypes == false)
      list = list.where((element) => projectFilter.types.contains(element.type)).toList();
    if(projectFilter.allUsers== false)
      list = list.where((element) => projectFilter.users.contains(element.teamLeader)).toList();
    if(projectFilter.allPriorities== false)
      list = list.where((element) => projectFilter.priorities.contains(element.priority)).toList();
    if(projectFilter.date)
      list = list.where((element) => element.startDate.isAfter(projectFilter.startDate) && element.endDate.isBefore(projectFilter.endDate)).toList();
    return list;
  }

  orderBy(List<Project> list)
  {
    switch(projectListOrder.orderBy)
    {
      case ProjectOrderByProperties.name:
        (projectListOrder.isAscending) ? list.sort((a, b) => a.name.compareTo(b.name)) :
        list.sort((a, b) => b.name.compareTo(a.name));
        break;
      case ProjectOrderByProperties.type:
        (projectListOrder.isAscending) ? list.sort((a, b) => a.type.name.compareTo(b.type.name)) :
        list.sort((a, b) => b.type.name.compareTo(a.type.name));
        break;
      case ProjectOrderByProperties.startDate:
        (projectListOrder.isAscending) ? list.sort((a, b) => a.startDate.compareTo(b.startDate)) :
        list.sort((a, b) => b.startDate.compareTo(a.startDate));
        break;
      case ProjectOrderByProperties.endDate:
        (projectListOrder.isAscending) ? list.sort((a, b) => a.endDate.compareTo(b.endDate)) :
        list.sort((a, b) => b.endDate.compareTo(a.endDate));
        break;
      case ProjectOrderByProperties.teamLeader:
        (projectListOrder.isAscending) ? list.sort((a, b) => a.teamLeader.name.compareTo(b.teamLeader.name)) :
        list.sort((a, b) => b.teamLeader.name.compareTo(a.teamLeader.name));
        break;
      case ProjectOrderByProperties.status:
        (projectListOrder.isAscending) ? list.sort((a, b) => a.status.index.compareTo(b.status.index)) :
        list.sort((a, b) => b.status.index.compareTo(a.status.index));
        break;
      case ProjectOrderByProperties.priority:
        (projectListOrder.isAscending) ? list.sort((a, b) => a.priority.index.compareTo(b.priority.index)) :
        list.sort((a, b) => b.priority.index.compareTo(a.priority.index));
        break;
    }
  }


  @override
  void dispose() {
    _controller.close();
  }
}
