import 'dart:math';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/dialogs/dialogs.dart';
import 'package:gestion_projets/pages/people/Data/user.dart';
import 'package:gestion_projets/pages/projects/Data/project.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/bloc_provider.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/phase_bloc.dart';
import 'package:gestion_projets/pages/projects/project_details/documents/data/document.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/body/project_overview_body.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data/action.dart'
    as Model;
import 'package:gestion_projets/pages/projects/project_details/overview/data/phase.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data/task.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/widgets/task_item.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/progress%20indicator.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/widgets/priority_icon.dart';
import 'package:gestion_projets/widgets/profile_avatar.dart';
import 'package:intl/intl.dart';

import '../../widgets/change_status_button.dart';
import '../../widgets/open_close_animated_arrow.dart';

class ActionItem extends StatefulWidget {
  final Model.Action action;
  final Phase phase;

  const ActionItem({Key? key, required this.action, required this.phase})
      : super(key: key);

  @override
  _ActionItemState createState() => _ActionItemState();
}

class _ActionItemState extends State<ActionItem> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  initState() {
    super.initState();
    _controller = new AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this, value: 0.0);
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
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Container(
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
                              Visibility(
                                  visible: isHover,
                                  maintainState: true,
                                  maintainSize: true,
                                  maintainAnimation: true,
                                  child: Container(
                                      width: 25,
                                      child: Row(children: [
                                        OpenCloseArrowButton(
                                          onTap: () {
                                            isExpanded
                                                ? setState(() {
                                                    isExpanded = false;
                                                  })
                                                : setState(() {
                                                    isExpanded = true;
                                                  });
                                          },
                                          color: active,
                                          isExpanded: isExpanded,
                                        ),
                                      ]))),
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
                                            width: 20,
                                            child: DottedLine(
                                              direction: Axis.horizontal,
                                              lineLength: double.infinity,
                                              lineThickness: 1.0,
                                              dashLength: 2,
                                              dashColor: text.withOpacity(0.3),
                                              dashRadius: 0.0,
                                              dashGapLength: 2,
                                              dashGapColor: Colors.transparent,
                                              dashGapRadius: 0.0,
                                            ),
                                          ),
                                          ChangeStatusButton(
                                            onTap: () {},
                                            status: widget.action.status,
                                            isChangeable: false,
                                          ),
                                          SizedBox(width: 10),
                                          Flexible(
                                              child: Text(widget.action.name,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      textStyle_Text_12_600)),
                                          SizedBox(width: 5),
                                          Visibility(
                                              visible: (widget
                                                  .action.documents.isNotEmpty),
                                              child: CustomIconButton(
                                                icon: Icons.attach_file_rounded,
                                                message:
                                                    "${widget.action.documents.length} Attachement",
                                                onTap: () {},
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
                                                getText(widget.action.endDate),
                                                overflow: TextOverflow.ellipsis,
                                                style: textStyle_Text_12_600)),
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
                                          name: widget.action.user.name,
                                          picture: widget.action.user.avatar,
                                          size: 25,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Flexible(
                                            child: Text(widget.action.user.name,
                                                overflow: TextOverflow.ellipsis,
                                                style: textStyle_Text_12_600)),
                                        // Expanded(child: Container()),
                                      ])),
                                      flex: 2,
                                    ),
                                    Expanded(
                                      child: Container(
                                          child: Row(children: [
                                        PriorityIcon(
                                          priority: widget.action.priority,
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
                                        Progress(
                                          completed: widget.action.tasks
                                              .where((element) =>
                                                  element.status ==
                                                      Status.completed ||
                                                  element.status ==
                                                      Status.approved)
                                              .length,
                                          inProgress: widget.action.tasks
                                              .where((element) =>
                                                  element.status ==
                                                  Status.inProgress)
                                              .length,
                                        ),
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
                                                        bloc.removeAction(
                                                            widget.phase,
                                                            widget.action)),
                                                DeleteType.action,
                                                widget.action.name);
                                          },
                                          onTapAdd: () {
                                            bloc.addTask(
                                              widget.action,
                                              new Task(
                                                  new Random().nextInt(999999),
                                                  "Développement d'une nouvelle interface utilisateur",
                                                  DateTime.now(),
                                                  DateTime.now()
                                                      .add(Duration(days: 15)),
                                                  Status.inProgress,
                                                  User(2, "Saidani Wael",
                                                      "https://i.imgur.com/01lxY0W.jpeg"),
                                                  [
                                                    Document(
                                                        55,
                                                        "Développement d'une nouvelle interface utilisateur",
                                                        "url",
                                                        "PDF",
                                                        User(12, "Saidani Wael",
                                                            "3"),
                                                        DateTime.now(),
                                                        656848),
                                                  ],
                                                  Priority.Normal),
                                            );
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
                    ),
                    AnimatedCrossFade(
                      firstCurve: Curves.easeIn,
                      secondCurve: Curves.easeOut,
                      firstChild: Container(),
                      secondChild: Container(
                          child: TasksList(
                        action: widget.action,
                        parentContext: context,
                      )),
                      crossFadeState: isExpanded
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: Duration(milliseconds: 200),
                    ),
                    SizedBox(
                      height: 1,
                    ),
                  ],
                ))));
  }
}

class TasksList extends StatefulWidget {
  final BuildContext parentContext;
  final Model.Action action;

  const TasksList({Key? key, required this.parentContext, required this.action})
      : super(key: key);

  @override
  _TasksListState createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      key: ValueKey(Random.secure()),
      shrinkWrap: true,
      controller: null,
      primary: false,
      children:
          widget.action.tasks.map((e) => _buildItem(widget.action, e)).toList(),
    );
  }

  Widget _buildItem(Model.Action action, Task task) {
    return TestProxy(
        key: ValueKey(task),
        child: new TaskItem(
          action: action,
          task: task,
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
                      color: white,
                    )))));
  }
}

class ActionsMenu extends StatelessWidget {
  final Function() onTapAdd;
  final Function() onTapDeleted;

  const ActionsMenu(
      {Key? key, required this.onTapAdd, required this.onTapDeleted})
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
              case 1:
                onTapAdd();
                break;
              case 2:
                break;
              case 3:
                onTapDeleted();
                break;
            }
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
                    value: 2),
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
                    value: 3),
              ]),
    );
  }
}
