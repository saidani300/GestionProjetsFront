import 'dart:async';
import 'package:gestion_projets/pages/projects/Data/project.dart';
import 'package:gestion_projets/pages/projects/filter/Data/project_filter.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data/phase.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/service/API_client.dart';

import 'bloc.dart';

ProjectFilter projectsFilterData = ProjectFilter(null, null, null, null, null);

String projectsSearchQuery = '';

class ProjectBloc implements Bloc {
  List<Project> filteredList = Projects;
  final _controller = StreamController<List<Project>>.broadcast();

  Stream<List<Project>> get projectStream => _controller.stream;

  Future init() async {
    await Future.delayed(Duration(milliseconds: 300),
        () => _controller.sink.add(filter(Projects)));
  }

  fetch() {
    _controller.sink.add(filter(Projects));
  }

  remove(Project project) async {
    Projects.remove(project);

    _controller.sink.add(filter(Projects));
  }

  add(Project project) async {
    print('project added');
    Projects.insert(0, project);
    _controller.sink.add(filter(Projects));
  }

  List<Project> filter(List<Project> initList) {
    List<Project> result = initList;
    switch (projectsFilterData.status) {
      case null:
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
    if (projectsFilterData.startDate != null)
      result = result
          .where((project) =>
              project.endDate.isBefore(projectsFilterData.endDate!) &&
              project.endDate.isAfter(projectsFilterData.startDate!))
          .toList();

    if (projectsFilterData.types != null)
      result.removeWhere(
          (project) => projectsFilterData.types!.contains(project.type));
    if (projectsFilterData.users != null)
      result.removeWhere(
          (project) => projectsFilterData.users!.contains(project.teamLeader));

    result = result
        .where((project) => project.name
            .toLowerCase()
            .contains(projectsSearchQuery.toLowerCase()))
        .toList();

    return result;
  }

  searchQuery(List<Project> list) {
    _controller.sink.add(filteredList);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
