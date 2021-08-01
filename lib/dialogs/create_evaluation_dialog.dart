import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gestion_projets/pages/people/Data/user.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/bloc_provider.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/event_bloc.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/data/evaluation.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/data/event.dart';

import 'buttons.dart';
import 'forms/create_evaluation_form.dart';

createEvaluationDialogBox(
    BuildContext context, ScrollController controller, Event event) {
  Evaluation evaluation = new Evaluation(
      Random().nextInt(99999),
      DateTime.now(),
      "",
      "",
      0,
      0,
      users.last,
      [],
      Formula(545, "Indice de risque", 'F * I * G', [
        Criterion(1, "Gravité", 0, "G"),
        Criterion(2, "Fréquence", 0, "F"),
        Criterion(3, "Importance", 0, "I"),
      ]));
  final bloc = BlocProvider.of<EventBloc>(context);
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: EdgeInsets.all(0),
        actionsPadding: EdgeInsets.all(10),
        content: CreateEvaluationForm(
          evaluation: evaluation,
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
                bloc.addEvaluation(event, evaluation);
                if (controller.hasClients)
                  controller.animateTo(
                    0.0,
                    curve: Curves.easeOut,
                    duration: const Duration(milliseconds: 300),
                  );
              }),
        ],
      );
    },
  );
}
