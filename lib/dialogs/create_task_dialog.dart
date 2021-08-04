import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gestion_projets/BLoC/phase_bloc.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/pages/people/Data/user.dart';
import 'package:gestion_projets/pages/projects/Data/project.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data/action.dart' as Model;
import 'package:gestion_projets/pages/projects/project_details/overview/data/phase.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data/task.dart';
import 'package:gestion_projets/widgets/toast.dart';

import 'forms/widgets/buttons.dart';
import 'forms/create_task_form.dart';

createTaskDialogBox(BuildContext context, Model.Action action , Function() expand) {
  Task task = new Task(Random().nextInt(99999), "", DateTime.now(), DateTime.now().add(Duration(days: 30)), Status.inProgress, users.last, [], Priority.Normal);
  final bloc = BlocProvider.of<PhaseBloc>(context);
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: EdgeInsets.all(0),
        actionsPadding: EdgeInsets.all(10),
        content: CreateTaskForm(task: task,
        ),
        actions: [
          DialogOutlinedButton(
            onTap: () {
              Navigator.of(context).pop();
            },
            text: 'Annuler',
          ),
          SizedBox(
            width: 5,
          ),
          DialogButton(
              text: 'Créer',
              onTap: () async {
                Navigator.of(context).pop();
                await expand();
                bloc.addTask(action, task);
                showToast(ToastType.success,
                    task.name,
                    event: ToastEvent.create);
              }),
        ],
      );
    },
  );
}
