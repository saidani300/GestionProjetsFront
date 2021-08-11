import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/objective_bloc.dart';
import 'package:gestion_projets/pages/people/Data/user.dart';
import 'package:gestion_projets/pages/projects/Data/project.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/data/objective.dart';
import 'package:gestion_projets/widgets/toast.dart';

import 'forms/create_objective_form.dart';
import 'forms/widgets/buttons.dart';

createObjectiveDialogBox(BuildContext context, ScrollController controller) {
  Objective objective = new Objective(Random().nextInt(999999), "", ObjectiveType.type1, DateTime.now(), ObjectiveStatus.inProgress, users.last, [], Priority.Normal, [], DateTime.now().add(Duration(days: 30)));
  final bloc = BlocProvider.of<ObjectiveBloc>(context);
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: EdgeInsets.all(0),
        actionsPadding: EdgeInsets.all(10),
        content: CreateObjectiveForm(objective: objective,
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
                bloc.add(objective);
                if (controller.hasClients)
                {controller.animateTo(
                  0.0,
                  curve: Curves.easeOut,
                  duration: const Duration(milliseconds: 300),
                );}
                showToast(ToastType.success,
                    objective.name,
                    event: ToastEvent.create);
              }),
        ],
      );
    },
  );
}
