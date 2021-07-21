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
        Duration(milliseconds: 300), () => _controller.sink.add(Objectives));
  }

  fetch() {
    _controller.sink.add(Objectives);
  }

  remove(Objective objective) async {
    Objectives.remove(objective);

    _controller.sink.add(Objectives);
  }

  removeIndicator(Objective objective, Indicator indicator) async {
    objective.indicators.remove(indicator);
    _controller.sink.add(Objectives);
  }

  removeMeasure(Indicator indicator, Measure measure) async {
    indicator.measures.remove(measure);
    _controller.sink.add(Objectives);
  }

  addMeasure(Indicator indicator, Measure measure) async {
    indicator.measures.add(measure);
    _controller.sink.add(Objectives);
  }

  add(Objective objective) async {
    Objectives.insert(0, objective);
    _controller.sink.add(Objectives);
  }

  addIndicator(Objective objective, Indicator indicator) async {
    objective.indicators.add(indicator);
    _controller.sink.add(Objectives);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
