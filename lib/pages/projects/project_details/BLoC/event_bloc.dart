import 'dart:async';
import 'package:gestion_projets/pages/projects/project_details/overview/service/API_client.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/data/event.dart';
import 'bloc.dart';

class EventBloc implements Bloc {
  final _controller = StreamController<List<Event>>.broadcast();
  Stream<List<Event>> get eventStream => _controller.stream;

  Future init () async
  {
    await Future.delayed(Duration(milliseconds: 300) , ()=> _controller.sink.add(events));
  }
  fetch(){

    _controller.sink.add(events);

  }
  remove(Event event) async
  {
    events.remove(event);

    _controller.sink.add(events);
  }
  add(Event event) async
  {
    events.insert(0,event);
    _controller.sink.add(events);
  }

  @override
  void dispose() {
    _controller.close();
  }
}