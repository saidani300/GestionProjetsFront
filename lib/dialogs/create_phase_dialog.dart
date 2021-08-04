import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gestion_projets/BLoC/phase_bloc.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/pages/projects/Data/project.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data/phase.dart';
import 'package:gestion_projets/widgets/toast.dart';

import 'forms/widgets/buttons.dart';
import 'forms/create_phase_form.dart';

createPhaseDialogBox(BuildContext context, ScrollController controller) {
  Phase phase = new Phase(
      Random().nextInt(999999),
      "",
      Priority.Normal,
      DateTime.now(),
      DateTime.now(),
      [],
      [],
      DateTime.now(),
      DateTime.now().add(Duration(days: 30)));
  final bloc = BlocProvider.of<PhaseBloc>(context);
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: EdgeInsets.all(0),
        actionsPadding: EdgeInsets.all(10),
        content: CreatePhaseForm(phase: phase,
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
                bloc.add(phase);
                if (controller.hasClients)
                  {controller.animateTo(
                    0.0,
                    curve: Curves.easeOut,
                    duration: const Duration(milliseconds: 300),
                  );}
                showToast(ToastType.success,
                    phase.name,
                    event: ToastEvent.create);
              }),
        ],
      );
    },
  );
}
