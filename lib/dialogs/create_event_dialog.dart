import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gestion_projets/pages/people/Data/user.dart';
import 'package:gestion_projets/pages/projects/Data/project.dart';
import 'package:gestion_projets/pages/projects/Data/project_type.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/bloc_provider.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/event_bloc.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/project_bloc.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data/phase.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/data/event.dart';

import 'buttons.dart';
import 'forms/create_event_form.dart';

createEventDialogBox(BuildContext context) {
  final nameController =TextEditingController(text: "");
  final descriptionController =TextEditingController(text: "");
  final causeController =TextEditingController(text: "");
  final impactController =TextEditingController(text: "");
  final sourceController =TextEditingController(text: "");
  Event event = new Event(Random().nextInt(999999), "","", "", "", "", "", DateTime.now(), EventType.Opportunity, EventLevel.low, EventCategory.category1, users.last, [], []);
  final bloc = BlocProvider.of<EventBloc>(context);
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: EdgeInsets.all(0),
        actionsPadding: EdgeInsets.all(10),
        content: CreateEventForm(causeController: causeController, nameController: nameController, event: event,
          impactController: impactController,
          sourceController: sourceController,
          descriptionController: descriptionController,),
        actions: [
          DialogOutlinedButton(onTap: () {Navigator.of(context).pop();}, text: 'Annuler',),
          SizedBox(
            width: 5,
          ),
          DialogButton(text: 'Créer', onTap: (){
            Navigator.of(context).pop();
            bloc.add(event);
          }),
        ],
      );
    },
  );
}