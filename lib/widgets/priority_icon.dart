import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/Data/project.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data/phase.dart';

class PriorityIcon extends StatelessWidget {
  final double size;
  final Priority priority;

  const PriorityIcon({Key? key, this.size = 18, required this.priority})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //return
    switch (priority) {
      case Priority.Important:
        return Tooltip(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(2)),
                color: lightRed),
            message: "Élevée",
            child: Icon(
              Icons.flag_rounded,
              size: size,
              color: lightRed,
            ));

      case Priority.Normal:
        return Tooltip(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(2)),
                color: active),
            message: "Normale",
            child: Icon(
              Icons.flag_rounded,
              size: size,
              color: active,
            ));

      case Priority.Low:
        return Tooltip(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(2)),
                color: dividerColor),
            textStyle: TextStyle(
                color: text,
                fontSize: 11,
                fontWeight: FontWeight.w500,
                fontFamily: 'Montserrat'),
            message: "Basse",
            child: Icon(
              Icons.outlined_flag_rounded,
              size: size,
              color: active,
            ));
    }
  }
}
