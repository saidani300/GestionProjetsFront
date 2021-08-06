import 'dart:async';

import 'package:gestion_projets/pages/people/Data/user.dart';
import 'package:gestion_projets/pages/projects/service/API.dart';

import 'bloc.dart';

class UsersPickBloc implements Bloc {
  final _controller = StreamController<List<User>>();

  Stream<List<User>> get userStream => _controller.stream;

  Future init(List<User> users) async {
    Future.delayed(Duration(milliseconds: 300),
            () => _controller.sink.add(users));
  }


  remove(List<User> users, User user) async {
    users.remove(user);
    _controller.sink.add(users);
  }



  add(List<User> users, User user) async {
    users.insert(0, user);
    _controller.sink.add(users);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
