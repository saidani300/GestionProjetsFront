import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/phase_bloc.dart';
import 'package:gestion_projets/dialogs/forms/create_action_form.dart';
import 'package:gestion_projets/pages/people/Data/user.dart';
import 'package:gestion_projets/pages/projects/Data/project.dart';
import 'package:gestion_projets/pages/projects/project_details/structure/data/action.dart' as Model;
import 'package:gestion_projets/pages/projects/project_details/structure/data/phase.dart';
import 'package:gestion_projets/widgets/toast.dart';

import 'forms/widgets/buttons.dart';

createActionDialogBox(BuildContext context, Phase phase , Function() expand) {
  Model.Action action = new Model.Action(Random().nextInt(99999), "", DateTime.now(), DateTime.now().add(Duration(days: 30)), Status.inProgress, users.last, [], [], Priority.Normal);
  final bloc = BlocProvider.of<PhaseBloc>(context);
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: EdgeInsets.all(0),
        actionsPadding: EdgeInsets.all(10),
        content: CreateActionForm(action: action,
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
                bloc.addAction(phase, action);
                showToast(ToastType.success,
                    action.name,
                    event: ToastEvent.create);
              }),
        ],
      );
    },
  );
}
