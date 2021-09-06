import 'dart:async';

import 'package:gestion_projets/pages/people/Data/user.dart';

import 'bloc.dart';

class UserBloc implements Bloc {
  final _controller = StreamController<List<User>>.broadcast();

  Stream<List<User>> get userStream => _controller.stream;

  Future init() async {
    Future.delayed(
        Duration(milliseconds: 300), () => _controller.sink.add(users));
  }

  fetch() {
    _controller.sink.add(users);
  }

  remove(User user) async {
    users.remove(user);
    _controller.sink.add(users);
  }

  add(User user) async {
    users.insert(0, user);
    _controller.sink.add(users);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
