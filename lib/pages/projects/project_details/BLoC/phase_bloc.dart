import 'dart:async';

import 'package:gestion_projets/pages/projects/Data/items.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data_layer/phase.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/service/API_client.dart';

import 'bloc.dart';

class PhaseBloc implements Bloc {
  final _controller = StreamController<List<Phase>>.broadcast();
  final _client = APIClient();
  Stream<List<Phase>> get phaseStream => _controller.stream;

  Future init () async
  {
   await Future.delayed(Duration(milliseconds: 300) , ()=> _controller.sink.add(Phases));
  }
  fetch(){

    _controller.sink.add(Phases);

  }
  remove(Phase phase) async
  {
    Phases.remove(phase);

    _controller.sink.add(Phases);
  }
  add(Phase phase) async
  {
    Phases.insert(0,phase);
    _controller.sink.add(Phases);
  }

  @override
  void dispose() {
    _controller.close();
  }
}

final phaseBloc = PhaseBloc();