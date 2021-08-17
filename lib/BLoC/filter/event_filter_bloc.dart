import 'dart:async';

import 'package:gestion_projets/pages/people/Data/user.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/data/event.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/data/event_filter_data.dart';
import '../bloc.dart';

class EventFilterBloc implements Bloc {
  final _controller = StreamController<EventFilter>.broadcast();

  Stream<EventFilter> get filterStream => _controller.stream;

  Future init() async {
    await Future.delayed(
        Duration(milliseconds: 100), () => _controller.sink.add(eventFilter));
  }

  fetch() {
    _controller.sink.add(eventFilter);
  }


  removeUser(User user) async {
    eventFilter.users.remove(user);

    _controller.sink.add(eventFilter);
  }

  addUser(User user) async {
    eventFilter.users.add(user);
    _controller.sink.add(eventFilter);
  }

  removeLevel(EventLevel level) async {
    eventFilter.levels.remove(level);
    _controller.sink.add(eventFilter);
  }

  addLevel(EventLevel level) async {
    eventFilter.levels.add(level);
    _controller.sink.add(eventFilter);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
