import 'dart:async';

import 'package:gestion_projets/pages/people/Data/user.dart';
import 'package:gestion_projets/pages/projects/Data/project.dart';
import 'package:gestion_projets/pages/projects/project_details/tasks/data/task_filter_data.dart';
import '../bloc.dart';

class TaskFilterBloc implements Bloc {
  final _controller = StreamController<TaskFilter>.broadcast();

  Stream<TaskFilter> get filterStream => _controller.stream;

  Future init() async {
    await Future.delayed(
        Duration(milliseconds: 100), () => _controller.sink.add(taskFilter));
  }

  fetch() {
    _controller.sink.add(taskFilter);
  }


  removeUser(User user) async {
    taskFilter.users.remove(user);

    _controller.sink.add(taskFilter);
  }

  addUser(User user) async {
    taskFilter.users.add(user);
    _controller.sink.add(taskFilter);
  }

  removePriority(Priority priority) async {
    taskFilter.priorities.remove(priority);
    _controller.sink.add(taskFilter);
  }

  addPriority(Priority priority) async {
    taskFilter.priorities.add(priority);
    _controller.sink.add(taskFilter);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
