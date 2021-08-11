import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/task_bloc.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/dialogs/attachments_dialog.dart';
import 'package:gestion_projets/dialogs/dialogs.dart';
import 'package:gestion_projets/pages/projects/project_details/structure/data/phase.dart';
import 'package:gestion_projets/pages/projects/project_details/structure/widgets/task_item.dart';
import 'package:gestion_projets/pages/projects/project_details/tasks/data/task_model.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/change_status_button.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/pages/projects/widgets/status_tag.dart';
import 'package:gestion_projets/widgets/priority_icon.dart';
import 'package:gestion_projets/widgets/profile_avatar.dart';
import 'package:intl/intl.dart';

class ProjectSubTaskItem extends StatefulWidget {
  final VoidCallback onTap;
  final TaskModel subtask;
  final TaskModel task;

  const ProjectSubTaskItem(
      {Key? key,
      required this.task,
      required this.subtask,
      required this.onTap})
      : super(key: key);

  @override
  _ProjectSubTaskItemState createState() => _ProjectSubTaskItemState();
}

class _ProjectSubTaskItemState extends State<ProjectSubTaskItem>
    with
        AutomaticKeepAliveClientMixin<ProjectSubTaskItem>,
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
                    onTap: () {},
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
                              color: statusColor(widget.subtask.status),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: 10, bottom: 10, left: 4),
                                    child: SvgPicture.asset(
                                      "icons/subtask.svg",
                                      color: text.withOpacity(0.8),
                                      width: 20,
                                      height: 20,
                                    ),
                                  ),
                                  ChangeStatusButton(
                                    onTap: () {
                                      widget.subtask.status != Status.inProgress
                                          ? widget.subtask.status ==
                                                  Status.approved
                                              ? widget.subtask.status =
                                                  Status.completed
                                              : widget.subtask.status =
                                                  Status.approved
                                          : null;
                                      bloc.fetch();
                                    },
                                    status: widget.subtask.status,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Flexible(
                                    child: AutoSizeText(
                                      widget.subtask.name,
                                      maxLines: 1,
                                      style: textStyle_Text_12_600,
                                      overflowReplacement: Row(
                                        children: [
                                          Flexible(
                                            child: Tooltip(
                                                message: widget.subtask.name,
                                                child: Text(widget.subtask.name,
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
                                      visible:
                                          widget.subtask.documents.isNotEmpty,
                                      child: CustomIconButton(
                                        icon: Icons.attach_file_rounded,
                                        message:
                                            "${widget.subtask.documents.length.toString()} Attachement",
                                        onTap: () {
                                          attachmentsDialogBox(context,
                                              widget.subtask.documents);
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
                                  child: Text(getText(widget.subtask.startDate),
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
                                    getText(widget.subtask.endDate),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: (widget.subtask.endDate
                                                    .isBefore(DateTime.now()) &&
                                                widget.subtask.status ==
                                                    Status.inProgress)
                                            ? lightRed
                                            : text,
                                        fontSize: 12,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w600),
                                  )),
                                  Visibility(
                                      visible: (widget.subtask.endDate
                                              .isBefore(DateTime.now()) &&
                                          widget.subtask.status ==
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
                                      picture: widget.subtask.user.avatar,
                                      name: widget.subtask.user.name,
                                    )),
                                SizedBox(
                                  width: 15,
                                ),
                                Flexible(
                                    child: Text(widget.subtask.user.name,
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
                                priority: widget.subtask.priority,
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
                                    status: widget.subtask.status,
                                    date: getText(widget.subtask.endDate),
                                    deadLine: widget.subtask.endDate,
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
                                                  bloc.removesSubTask(
                                                      widget.task,
                                                      widget.subtask)),
                                          DeleteType.subtask,
                                          widget.subtask.name);
                                      //showDialogBox(context, onTap);
                                    }),
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
                ]))));
  }
}
