
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/dialogs/dialogs.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/bloc_provider.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/task_bloc.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data/phase.dart';
import 'package:gestion_projets/pages/projects/project_details/tasks/data/task_model.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/change_status_button.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/widgets/task_item.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
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
                    onTap: () {
                      print("tapped");
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
                              color: StatusColor(widget.subtask.status),
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
                                      child: Text(widget.subtask.name,
                                          overflow: TextOverflow.ellipsis,
                                          style: textStyle_Text_12_600)),
                                  SizedBox(width: 5),
                                  Visibility(
                                      visible:
                                          widget.subtask.documents.isNotEmpty,
                                      child: CustomIconButton(
                                        icon: Icons.attach_file_rounded,
                                        message:
                                            "${widget.subtask.documents.length.toString()} Attachement",
                                        onTap: () {},
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
                                          style: textStyle_Text_12_600)),
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
                                      child: StatusTag(
                                          status: widget.subtask.status,
                                          date:
                                              getText(widget.subtask.endDate)))
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
                                      deleteDialogBox(context,() =>  _controller.reverse().whenComplete(() => bloc.removesSubTask(widget.task, widget.subtask)),DeleteType.subtask,widget.subtask.name);
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
