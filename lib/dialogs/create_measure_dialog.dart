import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gestion_projets/BLoC/objective_bloc.dart';
import 'package:gestion_projets/dialogs/forms/create_measure_form.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/data/indicator.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/data/measure.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/body/evaluations.dart';
import 'package:gestion_projets/widgets/toast.dart';

import 'forms/widgets/buttons.dart';

createMeasureDialogBox(BuildContext context, ScrollController controller, Indicator indicator) {
  DateTime startDate = (indicator.measures.isNotEmpty) ? indicator.measures.first.endDate.add(Duration(days: 1)) : DateTime.now();
  DateTime endDate = DateTime(startDate.year , startDate.month + frequencyToDays(indicator.frequency) , startDate.day);
  Measure measure = new Measure(Random().nextInt(999999), 0, DateTime.now(), startDate, endDate, "");
  final bloc = BlocProvider.of<ObjectiveBloc>(context);
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: EdgeInsets.all(0),
        actionsPadding: EdgeInsets.all(10),
        content: CreateMeasureForm(indicator: indicator, measure: measure,),
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
                bloc.addMeasure(indicator, measure);
                if (controller.hasClients)
                  controller.animateTo(
                    0.0,
                    curve: Curves.easeOut,
                    duration: const Duration(milliseconds: 300),
                  );
                showToast(ToastType.success,
                    "La mesure de " + getText(startDate),
                    event: ToastEvent.create);
              }),
        ],
      );
    },
  );
}

int frequencyToDays(Frequency frequency)
{
  switch(frequency)
  {
    case Frequency.monthly :
      return 1;
    case Frequency.quarterly :
      return 3;
    case Frequency.semiAnnually :
      return 6;
    case Frequency.annually :
      return 12;
  }
}