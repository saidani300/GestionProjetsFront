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
        Duration(milliseconds: 300), () => _controller.sink.add(phases));
  }

  fetch() {
    _controller.sink.add(phases);
  }

  remove(Phase phase) async {
    phases.remove(phase);

    _controller.sink.add(phases);
  }

  add(Phase phase) async {
    phases.insert(0, phase);
    _controller.sink.add(phases);
  }

  addAction(Phase phase, Action action) async {
    phase.actions.add(action);
    _controller.sink.add(phases);
  }

  removeAction(Phase phase, Action action) async {
    phase.actions.remove(action);
    _controller.sink.add(phases);
  }

  addTask(Action action, Task task) async {
    action.tasks.add(task);
    _controller.sink.add(phases);
  }

  removeTask(Action action, Task task) async {
    action.tasks.remove(task);
    _controller.sink.add(phases);
  }

  @override
  void dispose() {
    _controller.close();
  }
}

final phaseBloc = PhaseBloc();
