import 'dart:async';

import 'package:gestion_projets/pages/projects/Data/items.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data_layer/phase.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/service/API_client.dart';
import 'package:gestion_projets/pages/projects/project_details/tasks/data/task_model.dart';

import 'bloc.dart';

class TaskBloc implements Bloc {
  final _controller = StreamController<List<TaskModel>>.broadcast();
  final _client = APIClient();
  Stream<List<TaskModel>> get actionStream => _controller.stream;

  Future init () async
  {
    Future.delayed(Duration(milliseconds: 300) , ()=> _controller.sink.add(Tasks));
  }
  fetch(){
    _controller.sink.add(Tasks);
    // final results = await _client.fetchPhases();

  }
  remove(TaskModel task) async
  {
    Tasks.remove(task);

    _controller.sink.add(Tasks);
  }
  add(TaskModel task) async
  {
    Tasks.insert(0,task);
    _controller.sink.add(Tasks);
  }

  @override
  void dispose() {
    _controller.close();
  }
}