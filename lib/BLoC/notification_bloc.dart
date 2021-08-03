import 'dart:async';

import 'package:gestion_projets/pages/notifications/data/notification.dart';

import 'bloc.dart';

class NotificationBloc implements Bloc {
  final _controller = StreamController<List<Notification>>.broadcast();

  Stream<List<Notification>> get notificationStream => _controller.stream;

  Future init() async {
    await Future.delayed(
        Duration(milliseconds: 300), () => _controller.sink.add(notifications));
  }

  fetch() {
    _controller.sink.add(notifications);
  }

  remove(Notification notification) async {
    notifications.remove(notification);

    _controller.sink.add(notifications);
  }
  removeAll() async {
    notifications = [];
    _controller.sink.add(notifications);
  }

  add(Notification notification) async {
    notifications.insert(0, notification);
    _controller.sink.add(notifications);
  }


  @override
  void dispose() {
    _controller.close();
  }
}

