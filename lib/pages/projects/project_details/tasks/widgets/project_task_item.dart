import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/Data/project.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/bloc_provider.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/task_bloc.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data_layer/phase.dart';
import 'package:gestion_projets/pages/projects/project_details/tasks/data/task_model.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/change_status_button.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/task_item.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/routing/routes.dart';
import 'package:gestion_projets/services/navigation_service.dart';
import 'package:gestion_projets/widgets/custom_tag.dart';
import 'package:gestion_projets/widgets/priority_icon.dart';
import 'package:gestion_projets/widgets/profile_avatar.dart';
import 'package:intl/intl.dart';

class ProjectTaskItem extends StatefulWidget {
  //final Animation<double> animation;
  final VoidCallback onTap;
  final bool  isSubTask;
  final TaskModel task;
  const ProjectTaskItem(
      {Key? key,
      this.isSubTask = false,
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
        duration: const Duration(milliseconds: 300), vsync: this, value: 0.0);
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
                  color: lightBlue,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Container(
                  child: Row(
                    children: [
                      Visibility(visible: widget.isSubTask, child:Padding( padding : EdgeInsets.only(right: 10 , bottom: 10,left: 4), child :  SvgPicture.asset(
                        "icons/subtask.svg",
                        color: text.withOpacity(0.8),
                        width: 20,
                        height: 20,

                      ),),),
                      ChangeStatusButton(onTap: () {  }, status: Status.completed,),
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
                      Visibility(visible: true, child: CustomIconButton(icon: Icons.attach_file_rounded, message: "${widget.task.documents.length.toString()} Attachement", onTap: (){}, size: 15,)),
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
                Visibility(visible: !widget.isSubTask  ,child: Row( mainAxisSize : MainAxisSize.min,children :[
                  SizedBox(
                    width: 5,
                  ),
                  CustomIconButton(
                      icon: Icons.add_circle_rounded,
                      message: 'Ajouter une sous-tâche',
                      color: active,
                      onTap: () {
                        //showDialogBox(context, onTap);
                      }),]),),
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
        widget.isSubTask == false ?  ListView(
            shrinkWrap: true,
            children:
              widget.task.subTasks.map((e) => ProjectTaskItem(onTap: (){} , isSubTask: true, task: e,)).toList(),
          ) : Container()
    ]))));
  }
}
