import 'dart:async';

import 'package:gestion_projets/pages/projects/project_details/tasks/data/task_model.dart';

import 'bloc.dart';

class TaskBloc implements Bloc {
  final _controller = StreamController<List<TaskModel>>.broadcast();

  Stream<List<TaskModel>> get taskStream => _controller.stream;

  Future init() async {
    await Future.delayed(
        Duration(milliseconds: 300), () => _controller.sink.add(Tasks));
  }

  fetch() {
    _controller.sink.add(Tasks);
  }

  remove(TaskModel task) async {
    Tasks.remove(task);

    _controller.sink.add(Tasks);
  }

  removesSubTask(TaskModel task, TaskModel subTask) async {
    task.subTasks.remove(subTask);
    _controller.sink.add(Tasks);
  }

  add(TaskModel task) async {
    Tasks.insert(0, task);
    _controller.sink.add(Tasks);
  }

  addSubTask(TaskModel task, TaskModel subTask) async {
    task.subTasks.add(subTask);
    _controller.sink.add(Tasks);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
