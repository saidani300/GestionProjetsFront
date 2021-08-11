import 'dart:async';

import 'package:gestion_projets/pages/projects/project_details/objectives/data/indicator.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/data/measure.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/data/objective.dart';

import 'bloc.dart';

class ObjectiveBloc implements Bloc {
  final _controller = StreamController<List<Objective>>.broadcast();

  Stream<List<Objective>> get objectiveStream => _controller.stream;

  Future init() async {
    await Future.delayed(
        Duration(milliseconds: 300), () => _controller.sink.add(objectives));
  }

  fetch() {
    _controller.sink.add(objectives);
  }

  remove(Objective objective) async {
    objectives.remove(objective);

    _controller.sink.add(objectives);
  }

  removeIndicator(Objective objective, Indicator indicator) async {
    objective.indicators.remove(indicator);
    _controller.sink.add(objectives);
  }

  removeMeasure(Indicator indicator, Measure measure) async {
    indicator.measures.remove(measure);
    _controller.sink.add(objectives);
  }

  addMeasure(Indicator indicator, Measure measure) async {
    indicator.measures.insert(0, measure);
    _controller.sink.add(objectives);
  }

  add(Objective objective) async {
    objectives.insert(0, objective);
    _controller.sink.add(objectives);
  }

  addIndicator(Objective objective, Indicator indicator) async {
    objective.indicators.insert(0, indicator);
    _controller.sink.add(objectives);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
