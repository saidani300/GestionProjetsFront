import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/objective_bloc.dart';
import 'package:gestion_projets/dialogs/forms/create_indicator_form.dart';
import 'package:gestion_projets/pages/people/Data/user.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/data/indicator.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/data/objective.dart';
import 'package:gestion_projets/widgets/toast.dart';

import 'forms/widgets/buttons.dart';

createIndicatorDialogBox(BuildContext context, Objective objective) {
  Indicator indicator = new Indicator(Random().nextInt(999999), "", users.first, [], IndicatorType.type1, "", 0, 0, 0, Nature.manual, "", Frequency.monthly);
  final bloc = BlocProvider.of<ObjectiveBloc>(context);
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: EdgeInsets.all(0),
        actionsPadding: EdgeInsets.all(10),
        content: CreateIndicatorForm(indicator: indicator,
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
                bloc.addIndicator(objective, indicator);
                showToast(ToastType.success,
                    indicator.name,
                    event: ToastEvent.create);
              }),
        ],
      );
    },
  );
}
