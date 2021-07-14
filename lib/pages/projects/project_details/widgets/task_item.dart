import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/bloc_provider.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/phase_bloc.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data_layer/phase.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data_layer/task.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/progress%20indicator.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/pages/projects/widgets/project_item.dart';
import 'package:gestion_projets/widgets/custom_tag.dart';
import 'package:gestion_projets/widgets/priority_icon.dart';
import 'package:gestion_projets/widgets/profile_avatar.dart';
import 'package:intl/intl.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data_layer/action.dart'
    as Model;

import 'change_status_button.dart';

class TaskItem extends StatefulWidget {
  final Task task;
  final Model.Action action;
  const TaskItem({Key? key, required this.task, required this.action})
      : super(key: key);

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  //late bool isCompleted;

  @override
  initState() {
    /* if(widget.task.status == Status.completed)
    {
      isCompleted = true;
    }
    else{
      isCompleted = false;
    }*/
    super.initState();
  }

  bool isExpanded = false;
  bool isHover = false;
  String getText(DateTime date) => DateFormat.yMMMMd('fr_FR').format(date);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<PhaseBloc>(context);
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: Container(
          height: 60,
          child: InkWell(
              onTap: () {
                print("tapped");
              },
              onHover: (value) {
                value
                    ? setState(() {
                        isHover = true;
                      })
                    : setState(() {
                        isHover = false;
                      });
              },
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: Row(
                children: [
                  Container(
                    width: 25,
                  ),
                  Expanded(
                      child: Container(
                    height: 60,
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                              child: Row(
                            children: [
                              DottedLine(
                                direction: Axis.vertical,
                                lineLength: double.infinity,
                                lineThickness: 1.0,
                                dashLength: 2,
                                dashColor: text.withOpacity(0.3),
                                dashRadius: 0.0,
                                dashGapLength: 2,
                                dashGapColor: Colors.transparent,
                                dashGapRadius: 0.0,
                              ),
                              Container(
                                width: 29,
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2),
                                  child: Container(
                                      width: 2,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: StatusColor(widget.task.status),
                                      ))),
                              Container(
                                width: 20,
                              ),
                              ChangeStatusButton(
                                onTap: () {
                                  /* isCompleted ?
                                  setState(() {
                                    isCompleted = false;
                                  }) : setState(() {
                                    isCompleted = true;
                                  }) ;*/
                                  widget.task.status != Status.inProgress ?  widget.task.status == Status.approved
                                      ? widget.task.status = Status.completed
                                      : widget.task.status = Status.approved : null;
                                  // phaseBloc.fetch();
                                  UpdateAction(widget.action);
                                  bloc.fetch();
                                }, status: widget.task.status,

                              ),
                              SizedBox(width: 10),
                              Flexible(
                                  child: Text(
                                widget.task.name,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: text,
                                    fontSize: 12,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w600),
                              )),
                              SizedBox(width: 5),
                              Visibility(
                                  visible: (widget.task.documents.isNotEmpty),
                                  child: CustomIconButton(
                                    icon: Icons.attach_file_rounded,
                                    message:
                                        "${widget.task.documents.length} Attachement",
                                    onTap: () {},
                                    size: 15,
                                  )),

                              /* SizedBox(width: 5),
                              SvgPicture.asset(
                                "icons/dependency.svg",
                                color: active,
                                width: 15,
                                height: 15,

                              ),*/
                   /* Icon(Icons.swap_vertical_circle_outlined , color: Colors.orangeAccent, size: 16,)*/
                            ],
                          )),
                          flex: 5,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Container(
                              child: Row(children: [
                            Flexible(
                                child: Text(
                              getText(widget.task.endDate),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: widget.task.endDate
                                          .isBefore(DateTime.now())
                                      ? lightRed
                                      : text,
                                  fontSize: 12,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w600),
                            )),
                            Visibility(
                                visible: widget.task.endDate
                                    .isBefore(DateTime.now()),
                                child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Tooltip(
                                        preferBelow: false,
                                          verticalOffset: 15,
                                          message: "En retard",
                                          decoration: BoxDecoration(
                                            color: lightRed,
                                            borderRadius: BorderRadius.all(Radius.circular(2))
                                          ),
                                          child: Icon(
                                            Icons.warning_rounded,
                                            color: lightRed,
                                            size: 15,
                                          ))
                                    ]))
                            // Expanded(child: Container()),
                          ])),
                          flex: 2,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Container(
                              child: Row(children: [
                            Avatar(
                              name: widget.task.user.name,
                              picture: widget.task.user.avatar,
                              size: 25,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                                child: Text(
                              widget.task.user.name,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: text,
                                  fontSize: 12,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w600),
                            )),
                            // Expanded(child: Container()),
                          ])),
                          flex: 2,
                        ),
                        /* SizedBox(
                          width: 20,
                        ),*/
                        Expanded(
                          child: Container(
                              child: Row(children: [
                            PriorityIcon(
                              priority: widget.task.priority,
                            )
                            /*SizedBox(width: 6.5,),
                      Text(
                        "Normale",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: active,
                            fontSize: 12,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w600),
                      ),*/
                            //  Expanded(child: Container()),
                          ])),
                          flex: 1,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Container(
                              child: Row(children: [
                            StatusTag(
                                status: widget.task.status,
                                date: getText(widget.task.endDate)),
                            // Expanded(child: Container()),
                          ])),
                          flex: 1,
                        ),
                        Expanded(
                          child: Container(
                              child: Row(children: [
                            Expanded(child: Container()),
                            ActionsMenu(),
                          ])),
                          flex: 1,
                        ),
                      ],
                    ),
                  )),
                ],
              )),
        ));
  }
}

class ActionButton extends StatefulWidget {
  final Color color;
  final IconData icon;
  final double topLeftRadius;
  final double bottomLeftRadius;
  final String message;
  final double size;
  const ActionButton(
      {Key? key,
      required this.color,
      required this.icon,
      this.topLeftRadius = 0,
      this.bottomLeftRadius = 0,
      required this.message,
      this.size = 0})
      : super(key: key);

  @override
  _ActionButtonState createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  late Color onHoverColor;

  @override
  initState() {
    onHoverColor = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
        message: widget.message,
        preferBelow: false,
        child: InkWell(
            onTap: () {
              print("ActionButton tapped");
            },
            onHover: (value) {
              value
                  ? setState(() {
                      onHoverColor = widget.color.withAlpha(230);
                    })
                  : setState(() {
                      onHoverColor = widget.color;
                    });
            },
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            child: Container(
                height: (widget.size != 0) ? widget.size : null,
                width: (widget.size != 0) ? widget.size : null,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(widget.topLeftRadius),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(widget.bottomLeftRadius),
                      bottomRight: Radius.circular(0)),
                  color: onHoverColor,
                ),
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                    child: Icon(
                      widget.icon,
                      size: 13,
                      color: Colors.white,
                    )))));
  }
}

class ActionsMenu extends StatelessWidget {
  const ActionsMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          textTheme: TextTheme(),
          hoverColor: active.withOpacity(0.03),
          dividerTheme: DividerThemeData(
            thickness: 0.5,
            space: 0,
          ),
          tooltipTheme: TooltipThemeData(
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
          )),
      child: PopupMenuButton<Object>(
          offset: Offset(0, 20),
          padding: EdgeInsets.symmetric(vertical: 0),
          tooltip: "",
          child: Icon(
            Icons.more_horiz_rounded,
            size: 25,
            color: text.withOpacity(0.5),
          ),
          // child: CustomIconButton(icon: Icons.more_vert_rounded, message: 'Actions'),
          onSelected: (selectedValue) {
            // print(selectedValue);
          },
          itemBuilder: (context) => [
                PopupMenuItem(
                    height: 35,
                    child: Row(children: [
                      Icon(
                        Icons.add_circle_rounded,
                        size: 18,
                        color: active,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Ajouter une tâche',
                        style: TextStyle(
                          color: text,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      )
                    ]),
                    value: 1),
                PopupMenuItem(
                    height: 35,
                    child: Row(children: [
                      Icon(
                        Icons.edit,
                        size: 18,
                        color: text,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Modifier',
                        style: TextStyle(
                          color: text,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      )
                    ]),
                    value: 1),
                PopupMenuDivider(
                  height: 1,
                ),
                PopupMenuItem(
                    height: 35,
                    child: Row(children: [
                      Icon(
                        Icons.delete_rounded,
                        size: 18,
                        color: lightRed,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Supprimer',
                        style: TextStyle(
                          color: lightRed,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      )
                    ]),
                    value: 2),
              ]),
    );
  }
}

class StatusTag extends StatelessWidget {
  final Status status;
  final String date;
  const StatusTag({Key? key, required this.status, this.date = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case Status.completed:
        return CustomTag(text: 'Terminé', color: lightBlue, date: date
            /* icon: Padding(padding: EdgeInsets.only(right: 3), child: Icon(Icons.check_rounded , color: Colors.white, size: 12,),),*/
            );
      case Status.inProgress:
        return CustomTag(
          text: 'En cours',
          color: lightOrange,
          /*icon: Padding(padding: EdgeInsets.only(right: 3), child: Icon(Icons.more_horiz_rounded , color: Colors.white, size: 12,),),*/
        );
      case Status.approved:
        return CustomTag(
          text: 'Approuvé',
          color: lightPurple, date: date
          /*icon: Padding(padding: EdgeInsets.only(right: 3), child: Icon(Icons.more_horiz_rounded , color: Colors.white, size: 12,),),*/
        );
    }
  }
}

void UpdateAction(Model.Action action) {
  action.tasks.every((element) => element.status == Status.approved)
      ? action.status = Status.approved
      :    action.tasks.any((element) => element.status == Status.completed) ? action.status = Status.completed : null;
  print(action.status);
}

Color StatusColor(Status status)
{
  switch (status){
    case Status.inProgress :
      return lightOrange;
    case Status.completed :
      return lightBlue;
    case Status.approved:
      return lightPurple;
  }
}