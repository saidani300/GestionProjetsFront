import 'dart:math';

import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/event_bloc.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/body/calculations.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/data/calculation.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/data/evaluation.dart';
import 'package:gestion_projets/widgets/toast.dart';

import 'forms/widgets/buttons.dart';
import 'forms/create_calculation_form.dart';

createCalculationDialogBox(
    BuildContext context, ScrollController controller, Evaluation evaluation) {
  Calculation calculation = new Calculation(
      Random().nextInt(99999),
      0,
      DateTime.now(),
      DateTime.now(),
      DateTime.now().add(Duration(days: 30)),
      evaluation.formula.criteria);
  final bloc = BlocProvider.of<EventBloc>(context);
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: EdgeInsets.all(0),
        actionsPadding: EdgeInsets.all(10),
        content: CreateCalculationForm(
          calculation: calculation,
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
              text: 'Ajouter',
              onTap: () {
                String formula = evaluation.formula.formula;
                for (var i = 0; i < calculation.criteria.length; i++) {
                  formula = formula.replaceAll(
                      calculation.criteria[i].abbreviation,
                      calculation.criteria[i].value.toString());
                }
                calculation.score = formula.interpret().toDouble();
                Navigator.of(context).pop();
                bloc.addCalculation(evaluation, calculation);
                if (controller.hasClients)
                  controller.animateTo(
                    0.0,
                    curve: Curves.easeOut,
                    duration: const Duration(milliseconds: 300),
                  );
                showToast(ToastType.success,
                    "Le calcul de " + getText(calculation.creationDate),
                    event: ToastEvent.create);
              }),
        ],
      );
    },
  );
}
