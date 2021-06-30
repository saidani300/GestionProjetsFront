import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gestion_projets/constants/style.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container( color: Colors.black.withOpacity(0.04), child: Center(

      child: SpinKitFadingCube(
        color: active,
        size: 25,
        duration: Duration(milliseconds: 1200),
      ),

    ),);
  }
}
