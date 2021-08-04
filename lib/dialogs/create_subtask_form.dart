import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/task_bloc.dart';
import 'package:gestion_projets/dialogs/forms/create_subtask_form.dart';
import 'package:gestion_projets/pages/people/Data/user.dart';
import 'package:gestion_projets/pages/projects/Data/project.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data/phase.dart';
import 'package:gestion_projets/pages/projects/project_details/tasks/data/task_model.dart';
import 'package:gestion_projets/widgets/toast.dart';

import 'forms/widgets/buttons.dart';

createSubTaskDialogBox(BuildContext context, TaskModel? task ,ScrollController? controller, bool isSubTask) {
  TaskModel subTask = new TaskModel(Random().nextInt(99999), "", DateTime.now(), DateTime.now().add(Duration(days: 30)), Status.inProgress, users.first, [], Priority.Normal,[]);
  final bloc = BlocProvider.of<TaskBloc>(context);
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: EdgeInsets.all(0),
        actionsPadding: EdgeInsets.all(10),
        content: CreateSubTaskForm(task: subTask,
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
               if (isSubTask){
                bloc.addSubTask(task!, subTask); }else {
                 bloc.add(subTask);
                 if (controller != null) {
                   if (controller.hasClients)
                     controller.animateTo(
                       0.0,
                       curve: Curves.easeOut,
                       duration: const Duration(milliseconds: 300),
                     );
                 }
               }
                showToast(ToastType.success,
                subTask.name,
                event: ToastEvent.create);
              }),
        ],
      );
    },
  );
}
