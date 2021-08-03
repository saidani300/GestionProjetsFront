import 'dart:async';

import 'package:gestion_projets/pages/projects/Data/project.dart';
import 'package:gestion_projets/pages/projects/filter/Data/project_filter.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data/phase.dart';
import 'package:gestion_projets/pages/projects/service/API.dart';

import 'bloc.dart';

ProjectFilter projectsFilterData = ProjectFilter(null, null, null, null, null);

String projectsSearchQuery = '';

class ProjectBloc implements Bloc {
  List<Project> filteredList = projects;
  final _controller = StreamController<List<Project>>.broadcast();

  final _client = APIClient();

  Stream<List<Project>> get projectStream => _controller.stream;

  Future init() async {
    //  List<Project> projects = await _client.fetchProjects();
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
    print('project added');
    projects.insert(0, project);
    _controller.sink.add(filter(projects));
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
