import 'dart:async';

import 'package:gestion_projets/pages/projects/Data/items.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data/action.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data/phase.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data/task.dart';

import 'bloc.dart';

class PhaseBloc implements Bloc {
  final _controller = StreamController<List<Phase>>.broadcast();

  Stream<List<Phase>> get phaseStream => _controller.stream;

  Future init() async {
    await Future.delayed(
        Duration(milliseconds: 300), () => _controller.sink.add(Phases));
  }

  fetch() {
    _controller.sink.add(Phases);
  }

  remove(Phase phase) async {
    Phases.remove(phase);

    _controller.sink.add(Phases);
  }

  add(Phase phase) async {
    Phases.insert(0, phase);
    _controller.sink.add(Phases);
  }

  addAction(Phase phase, Action action) async {
    phase.actions.add(action);
    _controller.sink.add(Phases);
  }

  removeAction(Phase phase, Action action) async {
    phase.actions.remove(action);
    _controller.sink.add(Phases);
  }

  addTask(Action action, Task task) async {
    action.tasks.add(task);
    _controller.sink.add(Phases);
  }

  removeTask(Action action, Task task) async {
    action.tasks.remove(task);
    _controller.sink.add(Phases);
  }

  @override
  void dispose() {
    _controller.close();
  }
}

final phaseBloc = PhaseBloc();
