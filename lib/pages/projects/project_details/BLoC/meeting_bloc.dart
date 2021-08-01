import 'dart:async';

import 'package:gestion_projets/pages/projects/project_details/meetings/data/meeting.dart';
import 'package:gestion_projets/pages/projects/service/API.dart';

import 'bloc.dart';

class MeetingBloc implements Bloc {
  final _controller = StreamController<List<Meeting>>.broadcast();
  final _client = APIClient();

  Stream<List<Meeting>> get meetingStream => _controller.stream;

  Future init() async {
    // List<Meeting> meetings = await _client.fetchMeetings();
    Future.delayed(
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
