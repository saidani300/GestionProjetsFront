import 'dart:async';

import 'package:gestion_projets/pages/projects/Data/items.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data_layer/phase.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/service/API_client.dart';

import 'bloc.dart';

class PhaseBloc implements Bloc {
  final _controller = StreamController<List<Phase>>();
  final _client = APIClient();
  Stream<List<Phase>> get phaseStream => _controller.stream.asBroadcastStream();

  void fetch() async {
   // final results = await _client.fetchPhases();
    _controller.sink.add(Phases);
  }

  @override
  void dispose() {
    _controller.close();
  }
}

final phaseBloc = PhaseBloc();