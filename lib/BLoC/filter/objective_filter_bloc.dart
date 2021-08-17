import 'dart:async';

import 'package:gestion_projets/pages/people/Data/user.dart';
import 'package:gestion_projets/pages/projects/Data/project.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/data/objective_filter_data.dart';
import '../bloc.dart';

class ObjectiveFilterBloc implements Bloc {
  final _controller = StreamController<ObjectiveFilter>.broadcast();

  Stream<ObjectiveFilter> get filterStream => _controller.stream;

  Future init() async {
    await Future.delayed(
        Duration(milliseconds: 100), () => _controller.sink.add(objectiveFilter));
  }

  fetch() {
    _controller.sink.add(objectiveFilter);
  }


  removeUser(User user) async {
    objectiveFilter.users.remove(user);

    _controller.sink.add(objectiveFilter);
  }

  addUser(User user) async {
    objectiveFilter.users.add(user);
    _controller.sink.add(objectiveFilter);
  }

  removePriority(Priority priority) async {
    objectiveFilter.priorities.remove(priority);
    _controller.sink.add(objectiveFilter);
  }

  addPriority(Priority priority) async {
    objectiveFilter.priorities.add(priority);
    _controller.sink.add(objectiveFilter);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
