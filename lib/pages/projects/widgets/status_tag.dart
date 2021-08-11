import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/project_details/structure/data/phase.dart';
import 'package:gestion_projets/widgets/custom_tag.dart';

class GlobalStatusTag extends StatelessWidget {
  final Status status;
  final DateTime deadLine;
  final String date;

  const GlobalStatusTag(
      {Key? key, required this.status, this.date = "", required this.deadLine})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case Status.completed:
        return CustomTag(text: 'Terminé', color: lightBlue, date: date);
      case Status.inProgress:
        return (deadLine.isBefore(DateTime.now()))
            ? CustomTag(
                text: 'En retard',
                color: lightRed,
              )
            : CustomTag(
                text: 'En cours',
                color: lightOrange,
              );
      case Status.approved:
        return CustomTag(text: 'Approuvé', color: lightPurple, date: date);
    }
  }
}
