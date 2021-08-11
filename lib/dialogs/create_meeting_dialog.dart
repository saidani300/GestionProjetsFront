import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/meeting_bloc.dart';
import 'package:gestion_projets/dialogs/forms/create_meeting_form.dart';
import 'package:gestion_projets/pages/people/Data/user.dart';
import 'package:gestion_projets/pages/projects/project_details/meetings/data/meeting.dart';
import 'package:gestion_projets/widgets/toast.dart';

import 'forms/widgets/buttons.dart';

createMeetingDialogBox(BuildContext context, ScrollController controller) {
  Meeting meeting = new Meeting(Random().nextInt(999999), "", DateTime.now(), TimeOfDay(hour: 8 , minute: 0).format(context), "", [users.first ,users.last], MeetingStatus.programmed, []);
  final bloc = BlocProvider.of<MeetingBloc>(context);
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: EdgeInsets.all(0),
        actionsPadding: EdgeInsets.all(10),
        content: CreateMeetingForm(meeting: meeting,
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
                bloc.add(meeting);
                if (controller.hasClients)
                {controller.animateTo(
                  0.0,
                  curve: Curves.easeOut,
                  duration: const Duration(milliseconds: 300),
                );}
                showToast(ToastType.success,
                    meeting.name,
                    event: ToastEvent.create);
              }),
        ],
      );
    },
  );
}
