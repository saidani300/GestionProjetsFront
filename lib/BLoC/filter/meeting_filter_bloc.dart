import 'dart:async';
import 'package:gestion_projets/pages/projects/project_details/meetings/data/meeting.dart';
import 'package:gestion_projets/pages/projects/project_details/meetings/data/meeting_filter_data.dart';
import '../bloc.dart';

class MeetingFilterBloc implements Bloc {
  final _controller = StreamController<MeetingFilter>.broadcast();

  Stream<MeetingFilter> get filterStream => _controller.stream;

  Future init() async {
    await Future.delayed(
        Duration(milliseconds: 100), () => _controller.sink.add(meetingFilter));
  }

  fetch() {
    _controller.sink.add(meetingFilter);
  }



  removeStatus(MeetingStatus status) async {
    meetingFilter.statutes.remove(status);
    _controller.sink.add(meetingFilter);
  }

  addStatus(MeetingStatus status) async {
    meetingFilter.statutes.add(status);
    _controller.sink.add(meetingFilter);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
