import 'dart:async';

import 'package:gestion_projets/pages/people/Data/user.dart';
import 'package:gestion_projets/pages/projects/Data/project.dart';
import 'package:gestion_projets/pages/projects/project_details/documents/data/document_filter_data.dart';
import '../bloc.dart';

class DocumentFilterBloc implements Bloc {
  final _controller = StreamController<DocumentFilter>.broadcast();

  Stream<DocumentFilter> get filterStream => _controller.stream;

  Future init() async {
    await Future.delayed(
        Duration(milliseconds: 100), () => _controller.sink.add(documentFilter));
  }

  fetch() {
    _controller.sink.add(documentFilter);
  }


  removeUser(User user) async {
    documentFilter.users.remove(user);

    _controller.sink.add(documentFilter);
  }

  addUser(User user) async {
    documentFilter.users.add(user);
    _controller.sink.add(documentFilter);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
