import 'dart:async';

import 'package:gestion_projets/pages/people/Data/user.dart';
import 'package:gestion_projets/pages/projects/Data/project.dart';
import 'package:gestion_projets/pages/projects/Data/project_filter_data.dart';
import 'package:gestion_projets/pages/projects/Data/project_type.dart';

import '../bloc.dart';

class ProjectFilterBloc implements Bloc {
  final _controller = StreamController<ProjectFilter>.broadcast();

  Stream<ProjectFilter> get filterStream => _controller.stream;

  Future init() async {
    await Future.delayed(
        Duration(milliseconds: 100), () => _controller.sink.add(projectFilter));
  }

  fetch() {
    _controller.sink.add(projectFilter);
  }

  removeType(ProjectType type) async {
    projectFilter.types.remove(type);

    _controller.sink.add(projectFilter);
  }

  addType(ProjectType type) async {
    projectFilter.types.add(type);
    _controller.sink.add(projectFilter);
  }

  removeUser(User user) async {
    projectFilter.users.remove(user);

    _controller.sink.add(projectFilter);
  }

  addUser(User user) async {
    projectFilter.users.add(user);
    _controller.sink.add(projectFilter);
  }

  removePriority(Priority priority) async {
    projectFilter.priorities.remove(priority);
    _controller.sink.add(projectFilter);
  }

  addPriority(Priority priority) async {
    projectFilter.priorities.add(priority);
    _controller.sink.add(projectFilter);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
