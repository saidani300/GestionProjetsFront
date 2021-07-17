import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/bloc_provider.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/task_bloc.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/body/project_overview_body.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data_layer/document.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data_layer/phase.dart' as Model;
import 'package:gestion_projets/pages/projects/project_details/overview/data_layer/phase.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data_layer/user.dart';
import 'package:gestion_projets/pages/projects/project_details/tasks/data/task_model.dart';
import 'package:gestion_projets/pages/projects/project_details/tasks/widgets/project_subtask_item.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/change_status_button.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/task_item.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/widgets/priority_icon.dart';
import 'package:gestion_projets/widgets/profile_avatar.dart';
import 'package:intl/intl.dart';

class ProjectTaskItem extends StatefulWidget {
  final VoidCallback onTap;
  final TaskModel task;
  const ProjectTaskItem(
      {Key? key,
        required this.task,
      required this.onTap})
      : super(key: key);

  @override
  _ProjectTaskItemState createState() => _ProjectTaskItemState();
}

class _ProjectTaskItemState extends State<ProjectTaskItem>   with AutomaticKeepAliveClientMixin<ProjectTaskItem> ,TickerProviderStateMixin {


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
    print("Disposed " + widget.hashCode.toString());
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
        child:Column(children: [

      InkWell(
        hoverColor: active.withOpacity(0.015),
        onTap: () {
          print("tapped");
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
                  color: StatusColor(widget.task.status),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Container(
                  child: Row(
                    children: [
                      ChangeStatusButton(onTap: () {
                        widget.task.status != Status.inProgress ?  widget.task.status == Status.approved
                            ? widget.task.status = Status.completed
                            : widget.task.status = Status.approved : null;
                        // phaseBloc.fetch();
                        bloc.fetch();
                      }, status: widget.task.status,),
                  SizedBox(width: 20,),
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
                      Visibility(visible: widget.task.documents.isNotEmpty, child: CustomIconButton(icon: Icons.attach_file_rounded, message: "${widget.task.documents.length.toString()} Attachement", onTap: (){}, size: 15,)),
                    ],
                  ),
                ),
                flex: 8,
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Container( child :
               Row( children :[ Flexible(
                    child: Text(
                      getText(widget.task.startDate),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: text,
                          fontSize: 12,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w600),
                    )),])
                ),
                flex: 3,
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Container( child :
                      Row(
                        children: [
                          Flexible(
                              child: Text(
                            getText(widget.task.endDate),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: text,
                                fontSize: 12,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w600),
                          )),
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
                        child: Text(
                      widget.task.user.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: text,
                          fontSize: 12,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w600),
                    )),
                  ],
                ),
                flex: 4,
              ),
              Expanded(
                child: Container(
                    child: Row(children: [
                      PriorityIcon(priority: widget.task.priority,)
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
                              status: widget.task.status,
                              date: getText(widget.task.endDate)))
                    ]),
                flex: 2,
              ),
              // ActionsMenu(),
              SizedBox(
                width: 10,
              ),
              Container(width: 40, child: Row(mainAxisSize: MainAxisSize.min,children: [
                Expanded(child: Container()),
                CustomIconButton(
                    icon: Icons.delete_forever_rounded,
                    message: 'Supprimer',
                    color: Colors.redAccent,
                    onTap: () {
                      _controller.reverse().whenComplete(() => bloc.remove(widget.task));
                      //showDialogBox(context, onTap);
                    }),
                Row( mainAxisSize : MainAxisSize.min,children :[
                  SizedBox(
                    width: 5,
                  ),
                  CustomIconButton(
                      icon: Icons.add_circle_rounded,
                      message: 'Ajouter une sous-tâche',
                      color: active,
                      onTap: () {
                        bloc.addSubTask(widget.task , new TaskModel(new Random().nextInt(99999), "Développement d'une nouvelle interface utilisateur", DateTime.now(), DateTime.now().add(Duration(days: 17)), Model.Status.inProgress, User(30,"Saidani Wael","5"), [Document((1), "Doc1")], Model.Priority.Important, []));
                        //showDialogBox(context, onTap);
                      }),]),
              ],),),

              SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
      ),
      Divider(
        height: 1,
        color: dark.withOpacity(0.15),
      ),
          SubTasksList(parentContext: context, task: widget.task,),
    ]))));
  }
}


class SubTasksList extends StatefulWidget {
  final BuildContext parentContext;
  final TaskModel task;
  const SubTasksList({Key? key ,required this.parentContext , required this.task}) : super(key: key);

  @override
  _SubTasksListState createState() => _SubTasksListState();
}

class _SubTasksListState extends State<SubTasksList>{
  @override
  Widget build(BuildContext context) {

    return Container(
        child:
                ListView(
                  shrinkWrap: true,
                    key: ValueKey(Random.secure()),
                    children: widget.task.subTasks.map((e) => _buildItem(widget.task,e)).toList(),
                  )

    );

  }
  Widget _buildItem(TaskModel task , TaskModel subTask) {
    return TestProxy(
        key: ValueKey(subTask),
        child: new ProjectSubTaskItem(task: task, onTap: () {  }, subtask: subTask,)
    );
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
            color: Colors.white,
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
        position: Tween(begin: Offset(1,0 ), end: Offset(0, 0)).animate(anim),
        child: child,
      );
    },
  );
}