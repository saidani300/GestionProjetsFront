import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/project_bloc.dart';
import 'package:gestion_projets/pages/people/Data/user.dart';
import 'package:gestion_projets/pages/projects/Data/project.dart';
import 'package:gestion_projets/pages/projects/Data/project_type.dart';
import 'package:gestion_projets/pages/projects/project_details/structure/data/phase.dart';
import 'package:gestion_projets/widgets/toast.dart';

import 'forms/create_project_form.dart';
import 'forms/widgets/buttons.dart';


createProjectDialogBox(BuildContext context, ScrollController controller) {
  Project project = new Project(
      new Random().nextInt(999999999),
      "",
      projectTypesList.first,
      users.first,
      Status.inProgress,
      DateTime.now(),
      DateTime.now(),
      Priority.Normal, []);
  final bloc = BlocProvider.of<ProjectBloc>(context);
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: EdgeInsets.all(0),
        actionsPadding: EdgeInsets.all(10),
        content: CreateProjectForm(
          project: project,
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
              onTap: () {
                Navigator.of(context).pop();
                bloc.add(project);
                if (controller.hasClients)
                {controller.animateTo(
                  0.0,
                  curve: Curves.easeOut,
                  duration: const Duration(milliseconds: 300),
                );}
                showToast(ToastType.success,
                    project.name,
                    event: ToastEvent.create);
              }),
        ],
      );
    },
  );
}