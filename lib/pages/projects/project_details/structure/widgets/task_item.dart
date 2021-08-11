import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/phase_bloc.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/dialogs/attachments_dialog.dart';
import 'package:gestion_projets/dialogs/dialogs.dart';
import 'package:gestion_projets/pages/projects/project_details/structure/data/action.dart'
    as Model;
import 'package:gestion_projets/pages/projects/project_details/structure/data/phase.dart';
import 'package:gestion_projets/pages/projects/project_details/structure/data/task.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/pages/projects/widgets/status_tag.dart';
import 'package:gestion_projets/widgets/priority_icon.dart';
import 'package:gestion_projets/widgets/profile_avatar.dart';
import 'package:intl/intl.dart';

import '../../widgets/change_status_button.dart';

class TaskItem extends StatefulWidget {
  final Task task;
  final Model.Action action;

  const TaskItem({Key? key, required this.task, required this.action})
      : super(key: key);

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  initState() {
    super.initState();
    _controller = new AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this, value: 0.0);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    _controller.forward();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool isExpanded = false;
  bool isHover = false;

  String getText(DateTime date) => DateFormat.yMMMMd('fr_FR').format(date);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<PhaseBloc>(context);
    return FadeTransition(
        opacity: _animation,
        child: SizeTransition(
            sizeFactor: _animation,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0),
                child: Container(
                  height: 60,
                  child: InkWell(
                      onTap: () {},
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
                                          padding:
                                              EdgeInsets.symmetric(vertical: 2),
                                          child: Container(
                                              width: 2,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                color: statusColor(
                                                    widget.task.status),
                                              ))),
                                      Container(
                                        width: 20,
                                      ),
                                      ChangeStatusButton(
                                        onTap: () {
                                          widget.task.status !=
                                                  Status.inProgress
                                              ? widget.task.status ==
                                                      Status.approved
                                                  ? widget.task.status =
                                                      Status.completed
                                                  : widget.task.status =
                                                      Status.approved
                                              : null;
                                          updateAction(widget.action);
                                          bloc.fetch();
                                        },
                                        status: widget.task.status,
                                      ),
                                      SizedBox(width: 10),
                                      Flexible(
                                        child: AutoSizeText(
                                          widget.task.name,
                                          maxLines: 1,
                                          style: textStyle_Text_12_600,
                                          overflowReplacement: Row(
                                            children: [
                                              Flexible(
                                                child: Tooltip(
                                                    message: widget.task.name,
                                                    child: Text(
                                                        widget.task.name,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style:
                                                            textStyle_Text_12_600)),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 2),
                                      Visibility(
                                          visible: (widget
                                              .task.documents.isNotEmpty),
                                          child: CustomIconButton(
                                            icon: Icons.attach_file_rounded,
                                            message:
                                                "${widget.task.documents.length} Attachement",
                                            onTap: () {
                                              attachmentsDialogBox(context,
                                                  widget.task.documents);
                                            },
                                            size: 15,
                                          )),
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
                                          color: (widget.task.endDate.isBefore(
                                                      DateTime.now()) &&
                                                  widget.task.status ==
                                                      Status.inProgress)
                                              ? lightRed
                                              : text,
                                          fontSize: 12,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.w600),
                                    )),
                                    Visibility(
                                        visible: (widget.task.endDate
                                                .isBefore(DateTime.now()) &&
                                            widget.task.status ==
                                                Status.inProgress),
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
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  2))),
                                                  child: Icon(
                                                    Icons.warning_rounded,
                                                    color: lightRed,
                                                    size: 15,
                                                  ))
                                            ]))
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
                                        child: Text(widget.task.user.name,
                                            overflow: TextOverflow.ellipsis,
                                            style: textStyle_Text_12_600)),
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
                                  ])),
                                  flex: 1,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Container(
                                      child: Row(children: [
                                    GlobalStatusTag(
                                      status: widget.task.status,
                                      date: getText(widget.task.endDate),
                                      deadLine: widget.task.endDate,
                                    ),
                                    // Expanded(child: Container()),
                                  ])),
                                  flex: 1,
                                ),
                                Expanded(
                                  child: Container(
                                      child: Row(children: [
                                    Expanded(child: Container()),
                                    ActionsMenu(
                                      onTapDeleted: () {
                                        deleteDialogBox(
                                            context,
                                            () => _controller
                                                .reverse()
                                                .whenComplete(() =>
                                                    bloc.removeTask(
                                                        widget.action,
                                                        widget.task)),
                                            DeleteType.task,
                                            widget.task.name);
                                      },
                                    ),
                                  ])),
                                  flex: 1,
                                ),
                              ],
                            ),
                          )),
                        ],
                      )),
                ))));
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
                      color: white,
                    )))));
  }
}

class ActionsMenu extends StatelessWidget {
  final Function()? onTapAdd;
  final Function() onTapDeleted;

  const ActionsMenu({Key? key, this.onTapAdd, required this.onTapDeleted})
      : super(key: key);

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
            switch (selectedValue) {
              case 2:
                onTapDeleted();
                break;
            }
          },
          itemBuilder: (context) => [
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

void updateAction(Model.Action action) {
  action.tasks.every((element) => element.status == Status.approved)
      ? action.status = Status.approved
      : action.tasks.any((element) => element.status == Status.completed)
          ? action.status = Status.completed
          : null;
}

Color statusColor(Status status) {
  switch (status) {
    case Status.inProgress:
      return lightOrange;
    case Status.completed:
      return lightBlue;
    case Status.approved:
      return lightPurple;
  }
}
