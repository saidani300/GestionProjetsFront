import 'dart:async';

import 'package:gestion_projets/pages/projects/project_details/structure/data/phase.dart';
import 'package:gestion_projets/pages/projects/project_details/tasks/data/task_filter_data.dart';
import 'package:gestion_projets/pages/projects/project_details/tasks/data/task_model.dart';

import 'bloc.dart';

class TaskBloc implements Bloc {
  final _controller = StreamController<List<TaskModel>>.broadcast();

  Stream<List<TaskModel>> get taskStream => _controller.stream;

  Future init() async {
    await Future.delayed(
        Duration(milliseconds: 300), () => _controller.sink.add(filter(tasks)));
  }

  fetch() {
    _controller.sink.add(filter(tasks));
  }

  remove(TaskModel task) async {
    tasks.remove(task);

    _controller.sink.add(filter(tasks));
  }

  removesSubTask(TaskModel task, TaskModel subTask) async {
    task.subTasks.remove(subTask);
    _controller.sink.add(filter(tasks));
  }

  add(TaskModel task) async {
    tasks.insert(0, task);
    _controller.sink.add(filter(tasks));
  }

  addSubTask(TaskModel task, TaskModel subTask) async {
    task.subTasks.add(subTask);
    _controller.sink.add(filter(tasks));
  }

  List<TaskModel> filter(List<TaskModel> initList) {
    List<TaskModel> result = initList;
    switch (taskFilter.status) {
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
        .contains(taskFilter.searchQuery.toLowerCase()) || project.user.name.toLowerCase()
        .contains(taskFilter.searchQuery.toLowerCase()))
        .toList();

    result = propertiesFilter(result);

    orderBy(result);

    return result;
  }

  List<TaskModel> propertiesFilter(List<TaskModel> list)
  {
    if(taskFilter.allUsers== false)
      list = list.where((element) => taskFilter.users.contains(element.user)).toList();
    if(taskFilter.allPriorities== false)
      list = list.where((element) => taskFilter.priorities.contains(element.priority)).toList();
    if(taskFilter.date)
      list = list.where((element) => element.startDate.isAfter(taskFilter.startDate) && element.endDate.isBefore(taskFilter.endDate)).toList();
    return list;
  }

  orderBy(List<TaskModel> list)
  {
    switch(taskListOrder.orderBy)
    {
      case TaskOrderByProperties.name:
        (taskListOrder.isAscending) ? list.sort((a, b) => a.name.compareTo(b.name)) :
        list.sort((a, b) => b.name.compareTo(a.name));
        break;
      case TaskOrderByProperties.startDate:
        (taskListOrder.isAscending) ? list.sort((a, b) => a.startDate.compareTo(b.startDate)) :
        list.sort((a, b) => b.startDate.compareTo(a.startDate));
        break;
      case TaskOrderByProperties.endDate:
        (taskListOrder.isAscending) ? list.sort((a, b) => a.endDate.compareTo(b.endDate)) :
        list.sort((a, b) => b.endDate.compareTo(a.endDate));
        break;
      case TaskOrderByProperties.user:
        (taskListOrder.isAscending) ? list.sort((a, b) => a.user.name.compareTo(b.user.name)) :
        list.sort((a, b) => b.user.name.compareTo(a.user.name));
        break;
      case TaskOrderByProperties.status:
        (taskListOrder.isAscending) ? list.sort((a, b) => a.status.index.compareTo(b.status.index)) :
        list.sort((a, b) => b.status.index.compareTo(a.status.index));
        break;
      case TaskOrderByProperties.priority:
        (taskListOrder.isAscending) ? list.sort((a, b) => a.priority.index.compareTo(b.priority.index)) :
        list.sort((a, b) => b.priority.index.compareTo(a.priority.index));
        break;
    }
  }

  @override
  void dispose() {
    _controller.close();
  }
}
