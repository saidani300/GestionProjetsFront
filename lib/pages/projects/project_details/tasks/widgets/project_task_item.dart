import 'dart:math';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/task_bloc.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/dialogs/attachments_dialog.dart';
import 'package:gestion_projets/dialogs/create_subtask_form.dart';
import 'package:gestion_projets/dialogs/dialogs.dart';
import 'package:gestion_projets/pages/projects/project_details/structure/body/project_overview_body.dart';
import 'package:gestion_projets/pages/projects/project_details/structure/data/phase.dart';
import 'package:gestion_projets/pages/projects/project_details/structure/widgets/task_item.dart';
import 'package:gestion_projets/pages/projects/project_details/tasks/data/task_model.dart';
import 'package:gestion_projets/pages/projects/project_details/tasks/widgets/project_subtask_item.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/change_status_button.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/pages/projects/widgets/status_tag.dart';
import 'package:gestion_projets/widgets/priority_icon.dart';
import 'package:gestion_projets/widgets/profile_avatar.dart';
import 'package:intl/intl.dart';

class ProjectTaskItem extends StatefulWidget {
  final Function() onTap;
  final TaskModel task;

  const ProjectTaskItem({Key? key, required this.task, required this.onTap})
      : super(key: key);

  @override
  _ProjectTaskItemState createState() => _ProjectTaskItemState();
}

class _ProjectTaskItemState extends State<ProjectTaskItem>
    with
        AutomaticKeepAliveClientMixin<ProjectTaskItem>,
        TickerProviderStateMixin {
  String getText(DateTime date) => DateFormat.yMMMMd('fr_FR').format(date);
  late AnimationController _controller;
  late Animation<double> _animation;

  initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this, value: 0);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<TaskBloc>(context);
    super.build(context);

    return FadeTransition(
        opacity: _animation,
        child: SizeTransition(
            sizeFactor: _animation,
            child: Material(
                color: Colors.transparent,
                child: Column(children: [
                  InkWell(
                    hoverColor: active.withOpacity(0.015),
                    onTap: () {
                      showDialog(context);
                    },
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Container(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 2,
                            child: Container(
                              color: statusColor(widget.task.status),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                              child: Row(
                                children: [
                                  ChangeStatusButton(
                                    onTap: () {
                                      widget.task.status != Status.inProgress
                                          ? widget.task.status ==
                                                  Status.approved
                                              ? widget.task.status =
                                                  Status.completed
                                              : widget.task.status =
                                                  Status.approved
                                          : null;
                                      // phaseBloc.fetch();
                                      bloc.fetch();
                                    },
                                    status: widget.task.status,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
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
                                                child: Text(widget.task.name,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        textStyle_Text_12_600)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Visibility(
                                      visible: widget.task.documents.isNotEmpty,
                                      child: CustomIconButton(
                                        icon: Icons.attach_file_rounded,
                                        message:
                                            "${widget.task.documents.length.toString()} Attachement",
                                        onTap: () {
                                          attachmentsDialogBox(
                                              context, widget.task.documents);
                                        },
                                        size: 15,
                                      )),
                                ],
                              ),
                            ),
                            flex: 8,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                                child: Row(children: [
                              Flexible(
                                  child: Text(getText(widget.task.startDate),
                                      overflow: TextOverflow.ellipsis,
                                      style: textStyle_Text_12_600)),
                            ])),
                            flex: 3,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                              child: Row(
                                children: [
                                  Flexible(
                                      child: Text(
                                    getText(widget.task.endDate),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: (widget.task.endDate
                                                    .isBefore(DateTime.now()) &&
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
                                ],
                              ),
                            ),
                            flex: 3,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                    height: 30,
                                    width: 30,
                                    child: Avatar(
                                      picture: widget.task.user.avatar,
                                      name: widget.task.user.name,
                                    )),
                                SizedBox(
                                  width: 15,
                                ),
                                Flexible(
                                    child: Text(widget.task.user.name,
                                        overflow: TextOverflow.ellipsis,
                                        style: textStyle_Text_12_600)),
                              ],
                            ),
                            flex: 4,
                          ),
                          Expanded(
                            child: Container(
                                child: Row(children: [
                              PriorityIcon(
                                priority: widget.task.priority,
                              )
                            ])),
                            flex: 2,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      child: GlobalStatusTag(
                                    status: widget.task.status,
                                    date: getText(widget.task.endDate),
                                    deadLine: widget.task.endDate,
                                  ))
                                ]),
                            flex: 2,
                          ),
                          // ActionsMenu(),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 40,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(child: Container()),
                                CustomIconButton(
                                    icon: Icons.delete_forever_rounded,
                                    message: 'Supprimer',
                                    color: Colors.redAccent,
                                    onTap: () {
                                      deleteDialogBox(
                                          context,
                                          () => _controller
                                              .reverse()
                                              .whenComplete(() =>
                                                  bloc.remove(widget.task)),
                                          DeleteType.task,
                                          widget.task.name);
                                    }),
                                Row(mainAxisSize: MainAxisSize.min, children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  CustomIconButton(
                                      icon: Icons.add_circle_rounded,
                                      message: 'Ajouter une sous-t??che',
                                      color: active,
                                      onTap: () {
                                        createSubTaskDialogBox(
                                            context, widget.task, null, true);
                                      }),
                                ]),
                              ],
                            ),
                          ),

                          SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: dividerColor,
                  ),
                  SubTasksList(
                    parentContext: context,
                    task: widget.task,
                  ),
                ]))));
  }
}

class SubTasksList extends StatefulWidget {
  final BuildContext parentContext;
  final TaskModel task;

  const SubTasksList(
      {Key? key, required this.parentContext, required this.task})
      : super(key: key);

  @override
  _SubTasksListState createState() => _SubTasksListState();
}

class _SubTasksListState extends State<SubTasksList> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      controller: null,
      primary: false,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      key: ValueKey(Random.secure()),
      children:
          widget.task.subTasks.map((e) => _buildItem(widget.task, e)).toList(),
    ));
  }

  Widget _buildItem(TaskModel task, TaskModel subTask) {
    return TestProxy(
        key: ValueKey(subTask),
        child: new ProjectSubTaskItem(
          task: task,
          onTap: () {},
          subtask: subTask,
        ));
  }
}

void showDialog(BuildContext context) {
  showGeneralDialog(
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.transparent,
    transitionDuration: Duration(milliseconds: 300),
    context: context,
    pageBuilder: (context, __, ___) {
      return Align(
        alignment: Alignment.centerRight,
        child: Container(
          margin: EdgeInsets.only(top: 55.5),
          width: 700,
          child: Container(),
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                offset: Offset(-0.5, 2),
                spreadRadius: 1,
                blurRadius: 1,
              ),
            ],
          ),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      return SlideTransition(
        position: Tween(begin: Offset(1, 0), end: Offset(0, 0)).animate(anim),
        child: child,
      );
    },
  );
}
