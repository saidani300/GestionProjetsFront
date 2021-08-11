import 'dart:async';

import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/data/evaluation.dart';

import 'bloc.dart';

class CriterionBloc implements Bloc {
  final _controller = StreamController<List<Criterion>>.broadcast();

  Stream<List<Criterion>> get criterionStream => _controller.stream;

  Future init(List<Criterion> criteria) async {
    await Future.delayed(
        Duration(milliseconds: 300), () => _controller.sink.add(criteria));
  }

  fetch(List<Criterion> criteria) {
    _controller.sink.add(criteria);
  }

  removeCriterion(List<Criterion> criteria, Criterion criterion) async {
    criteria.remove(criterion);

    _controller.sink.add(criteria);
  }

  addCriterion(List<Criterion> criteria, Criterion criterion) async {
    criteria.insert(0, criterion);
    _controller.sink.add(criteria);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
