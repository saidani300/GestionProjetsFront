import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data/phase.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/task_item.dart';

class ChangeStatusButton extends StatefulWidget {
  final Function() onTap;
  final Status status;
  final bool isChangeable;

  ChangeStatusButton({
    Key? key,
    required this.onTap,
    required this.status,
    this.isChangeable = true,
  }) : super(key: key);

  @override
  _ChangeStatusButtonState createState() => _ChangeStatusButtonState();
}

class _ChangeStatusButtonState extends State<ChangeStatusButton> {
  bool onHover = false;
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return (widget.isChangeable && widget.status != Status.inProgress)
        ? InkWell(
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              widget.onTap();
              setState(() {
                onHover = false;
              });
              /* setState(() {
            isCompleted = widget.isCompleted;
          });*/
            },
            onHover: (value) {
              setState(() {
                value ? onHover = true : onHover = false;
              });
            },
            child: Tooltip(
                message: widget.status == Status.approved
                    ? "Marquer comme terminé"
                    : "Marquer comme approuvé",
                decoration: BoxDecoration(
                  color: widget.status == Status.approved
                      ? StatusColor(Status.completed)
                      : StatusColor(Status.approved),
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                ),
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: onHover
                            ? widget.status == Status.approved
                                ? StatusColor(Status.completed)
                                : StatusColor(Status.approved)
                            : widget.status == Status.approved
                                ? StatusColor(Status.approved)
                                : StatusColor(Status.completed),
                        width: 1.5,
                      ),
                      color: onHover
                          ? widget.status == Status.approved
                              ? StatusColor(Status.completed)
                              : StatusColor(Status.approved)
                          : widget.status == Status.approved
                              ? StatusColor(Status.approved)
                              : StatusColor(Status.completed),
                      shape: BoxShape.circle),
                  child:
                      Icon(Icons.check_rounded, size: 10, color: white),
                )))
        : Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
                border: Border.all(
                  color: widget.status != Status.inProgress
                      ? StatusColor(widget.status)
                      : text.withOpacity(0.5),
                  width: 1.5,
                ),
                color: widget.status != Status.inProgress
                    ? StatusColor(widget.status)
                    : Colors.transparent,
                shape: BoxShape.circle),
            child: Icon(
              Icons.check_rounded,
              size: 10,
              color: widget.status != Status.inProgress
                  ? white
                  : Colors.transparent,
            ),
          );
  }
}
