import 'dart:async';
import 'package:gestion_projets/pages/projects/project_details/meetings/data/meeting.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/service/API_client.dart';
import 'bloc.dart';
class MeetingBloc implements Bloc {
  final _controller = StreamController<List<Meeting>>.broadcast();

  Stream<List<Meeting>> get meetingStream => _controller.stream;

  Future init() async {
    await Future.delayed(
        Duration(milliseconds: 300), () => _controller.sink.add(meetings));
  }

  fetch() {
    _controller.sink.add(meetings);
  }

  remove(Meeting meeting) async {
    meetings.remove(meeting);

    _controller.sink.add(meetings);
  }

  add(Meeting meeting) async {
    meetings.insert(0, meeting);
    _controller.sink.add(meetings);
  }

  @override
  void dispose() {
    _controller.close();
  }
}

final meetingBloc = MeetingBloc();
