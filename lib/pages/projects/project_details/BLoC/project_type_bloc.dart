import 'dart:async';
import 'package:gestion_projets/pages/projects/Data/project_type.dart';
import 'package:gestion_projets/pages/projects/service/API.dart';

import 'bloc.dart';


class ProjectTypeBloc implements Bloc {
  final _controller = StreamController<List<ProjectType>>();
  final _client = APIClient();

  Stream<List<ProjectType>> get projectTypeStream => _controller.stream;

  Future init() async {
    Future.delayed(Duration(milliseconds: 300) , () => _controller.sink.add(projectTypesList));
  }

  fetch() {
    _controller.sink.add(projectTypesList);
  }

  remove(ProjectType type) async {
    projectTypesList.remove(type);
    _controller.sink.add(projectTypesList);
  }

  add(ProjectType type) async {
    projectTypesList.insert(0, type);
    _controller.sink.add(projectTypesList);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
