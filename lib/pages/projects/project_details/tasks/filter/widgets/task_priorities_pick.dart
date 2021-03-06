import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/filter/task_filter_bloc.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/Data/project.dart';
import 'package:gestion_projets/pages/projects/project_details/tasks/data/task_filter_data.dart';
import 'package:gestion_projets/pages/projects/widgets/form_widgets/custom_select_list.dart';
import 'package:gestion_projets/widgets/priority_icon.dart';

class TaskPrioritiesPicker extends StatefulWidget {
  final double widgetHeight;
  const TaskPrioritiesPicker({
    Key? key,
    this.widgetHeight = 40,
  }) : super(key: key);

  @override
  _TaskPrioritiesPickerState createState() => _TaskPrioritiesPickerState();
}

class _TaskPrioritiesPickerState extends State<TaskPrioritiesPicker>{
  late final filterBloc;

  @override
  void initState() {
    filterBloc = BlocProvider.of<TaskFilterBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomListPopupMenuButton(
        containerHeight: widget.widgetHeight,
        offset: Offset(0, 38),
        child: StatusText(filterBloc),
        enabled: true,
        itemBuilder: (context) {
          return[
            CustomListPopupMenuItem(
                value: 1,
                enabled: false,
                child: Container(
                    height: 161,
                    width: 250,
                    child: BlocProvider<TaskFilterBloc>(
                        bloc: TaskFilterBloc(),
                        child: TaskPrioritiesListView(Priority.values,filterBloc))))
          ];
        });
  }
}

class TaskPrioritiesListView extends StatefulWidget {
  final List<Priority> priorities;
  final TaskFilterBloc bloc;
  TaskPrioritiesListView(this.priorities , this.bloc) ;

  @override
  _TaskPrioritiesListViewState createState() => _TaskPrioritiesListViewState();
}

class _TaskPrioritiesListViewState extends State<TaskPrioritiesListView>{

  @override
  void initState() {
    super.initState();
    widget.bloc.init();
  }

  @override
  Widget build(BuildContext context) {
    Function eq = const DeepCollectionEquality.unordered().equals;
    ScrollController controller = new ScrollController();
    return StreamBuilder<TaskFilter>(
        stream: widget.bloc.filterStream,
        builder: (context, snapshot) {
          TaskFilter? filter = snapshot.data;
          return snapshot.hasData
              ? Scrollbar(
            isAlwaysShown: true,
            controller: controller,
            child: ListView(
                controller: controller,
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
                    horizontalTitleGap: 0,
                    dense: true,
                    tileColor: white,
                    leading: Transform.scale(
                      scale: 0.8,
                      child: Checkbox(
                        value: (snapshot.hasData)
                            ? eq(filter!.priorities, Priority.values)
                            : false,
                        onChanged: (value) {

                          if (eq(filter!.priorities, Priority.values))
                          {
                            taskFilter.priorities = [];
                            widget.bloc.fetch();
                          }
                          else{
                            taskFilter.priorities = List.from(Priority.values);
                            widget.bloc.fetch();
                          }
                          taskFilter.allPriorities = eq(filter.priorities, Priority.values);
                        },
                        activeColor: active,
                      ),
                    ),
                    title: Row(
                      children: [
                        Text(
                          'Tous',
                          style: textStyle_Text_12_500,
                        ),
                      ],
                    ),
                    onTap: () async {

                      if (eq(filter!.priorities, Priority.values))
                      {
                        taskFilter.priorities = [];
                        widget.bloc.fetch();
                      }
                      else
                      {
                        taskFilter.priorities = List.from(Priority.values);
                        widget.bloc.fetch();
                      }
                      taskFilter.allPriorities = eq(filter.priorities, Priority.values);
                    },
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: dividerColor,
                  ),
                  ...widget.priorities
                      .map((e) => ListTile(
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 0),
                    horizontalTitleGap: 0,
                    dense: true,
                    tileColor: white,
                    leading: Transform.scale(
                      scale: 0.8,
                      child: Checkbox(
                        value: (snapshot.hasData)
                            ? filter!.priorities.contains(e)
                            : true,
                        onChanged: (value) {
                          taskFilter.priorities.contains(e)
                              ? widget.bloc.removePriority(e)
                              : widget.bloc.addPriority(e);
                          taskFilter.allPriorities = eq(filter!.priorities, Priority.values);
                        },
                        activeColor: active,
                      ),
                    ),
                    title: Row(
                      children: [
                        PriorityIcon(
                          priority: e,
                          toolTipEnabled: false,
                        ),
                        SizedBox(width: 10,),
                        Text(
                          priorityAsText(e),
                          style: textStyle_Text_12_500,
                        ),
                      ],
                    ),
                    onTap: () async {
                      taskFilter.priorities.contains(e)
                          ? widget.bloc.removePriority(e)
                          : widget.bloc.addPriority(e);
                      taskFilter.allPriorities = eq(filter!.priorities, Priority.values);
                    },
                  ))
                      .toList()
                ]),
          )
              : Container();
        });
  }
}

class StatusText extends StatefulWidget {
  final TaskFilterBloc bloc;
  StatusText(this.bloc);

  @override
  _StatusTextState createState() => _StatusTextState();
}

class _StatusTextState extends State<StatusText>{
  String status = "Par d??faut";
  @override
  void initState() {
    super.initState();
    widget.bloc.init();
  }

  @override
  Widget build(BuildContext context) {
    Function eq = const DeepCollectionEquality.unordered().equals;
    return StreamBuilder<TaskFilter>(
        stream: widget.bloc.filterStream,
        builder: (context, filterSnapshot) {
          return Text(
            filterSnapshot.hasData ? eq(filterSnapshot.data!.priorities, Priority.values) ? "Par d??faut" : "Personnalis??" : "Par d??faut",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 11,
            ),
          );});
  }
}