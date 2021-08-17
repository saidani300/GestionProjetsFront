import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/filter/objective_filter_bloc.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/Data/project.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/data/objective_filter_data.dart';
import 'package:gestion_projets/pages/projects/widgets/form_widgets/custom_select_list.dart';
import 'package:gestion_projets/widgets/priority_icon.dart';

class ObjectivePrioritiesPicker extends StatefulWidget {
  final double widgetHeight;
  const ObjectivePrioritiesPicker({
    Key? key,
    this.widgetHeight = 40,
  }) : super(key: key);

  @override
  _ObjectivePrioritiesPickerState createState() => _ObjectivePrioritiesPickerState();
}

class _ObjectivePrioritiesPickerState extends State<ObjectivePrioritiesPicker>{
  late final filterBloc;

  @override
  void initState() {
    filterBloc = BlocProvider.of<ObjectiveFilterBloc>(context);
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
                    child: BlocProvider<ObjectiveFilterBloc>(
                        bloc: ObjectiveFilterBloc(),
                        child: ObjectivePrioritiesListView(Priority.values,filterBloc))))
          ];
        });
  }
}

class ObjectivePrioritiesListView extends StatefulWidget {
  final List<Priority> priorities;
  final ObjectiveFilterBloc bloc;
  ObjectivePrioritiesListView(this.priorities , this.bloc) ;

  @override
  _ObjectivePrioritiesListViewState createState() => _ObjectivePrioritiesListViewState();
}

class _ObjectivePrioritiesListViewState extends State<ObjectivePrioritiesListView>{

  @override
  void initState() {
    super.initState();
    widget.bloc.init();
  }

  @override
  Widget build(BuildContext context) {
    Function eq = const DeepCollectionEquality.unordered().equals;
    ScrollController controller = new ScrollController();
    return StreamBuilder<ObjectiveFilter>(
        stream: widget.bloc.filterStream,
        builder: (context, snapshot) {
          ObjectiveFilter? filter = snapshot.data;
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
                            objectiveFilter.priorities = [];
                            widget.bloc.fetch();
                          }
                          else{
                            objectiveFilter.priorities = List.from(Priority.values);
                            widget.bloc.fetch();
                          }
                          objectiveFilter.allPriorities = eq(filter.priorities, Priority.values);
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
                        objectiveFilter.priorities = [];
                        widget.bloc.fetch();
                      }
                      else
                      {
                        objectiveFilter.priorities = List.from(Priority.values);
                        widget.bloc.fetch();
                      }
                      objectiveFilter.allPriorities = eq(filter.priorities, Priority.values);
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
                          objectiveFilter.priorities.contains(e)
                              ? widget.bloc.removePriority(e)
                              : widget.bloc.addPriority(e);
                          objectiveFilter.allPriorities = eq(filter!.priorities, Priority.values);
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
                      objectiveFilter.priorities.contains(e)
                          ? widget.bloc.removePriority(e)
                          : widget.bloc.addPriority(e);
                      objectiveFilter.allPriorities = eq(filter!.priorities, Priority.values);
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
  final ObjectiveFilterBloc bloc;
  StatusText(this.bloc);

  @override
  _StatusTextState createState() => _StatusTextState();
}

class _StatusTextState extends State<StatusText>{
  String status = "Par défaut";
  @override
  void initState() {
    super.initState();
    widget.bloc.init();
  }

  @override
  Widget build(BuildContext context) {
    Function eq = const DeepCollectionEquality.unordered().equals;
    return StreamBuilder<ObjectiveFilter>(
        stream: widget.bloc.filterStream,
        builder: (context, filterSnapshot) {
          return Text(
            filterSnapshot.hasData ? eq(filterSnapshot.data!.priorities, Priority.values) ? "Par défaut" : "Personnalisé" : "Par défaut",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 11,
            ),
          );});
  }
}