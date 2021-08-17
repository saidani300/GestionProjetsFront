import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/filter/event_filter_bloc.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/data/event.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/data/event_filter_data.dart';
import 'package:gestion_projets/pages/projects/widgets/form_widgets/custom_select_list.dart';
import 'package:gestion_projets/widgets/custom_tag.dart';

class EventLevelsPicker extends StatefulWidget {
  final double widgetHeight;
  const EventLevelsPicker({
    Key? key,
    this.widgetHeight = 40,
  }) : super(key: key);

  @override
  _EventLevelsPickerState createState() => _EventLevelsPickerState();
}

class _EventLevelsPickerState extends State<EventLevelsPicker>{
  late final filterBloc;

  @override
  void initState() {
    filterBloc = BlocProvider.of<EventFilterBloc>(context);
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
                    child: BlocProvider<EventFilterBloc>(
                        bloc: EventFilterBloc(),
                        child: EventLevelsListView(EventLevel.values,filterBloc))))
          ];
        });
  }
}

class EventLevelsListView extends StatefulWidget {
  final List<EventLevel> levels;
  final EventFilterBloc bloc;
  EventLevelsListView(this.levels , this.bloc) ;

  @override
  _EventLevelsListViewState createState() => _EventLevelsListViewState();
}

class _EventLevelsListViewState extends State<EventLevelsListView>{

  @override
  void initState() {
    super.initState();
    widget.bloc.init();
  }

  @override
  Widget build(BuildContext context) {
    Function eq = const DeepCollectionEquality.unordered().equals;
    ScrollController controller = new ScrollController();
    return StreamBuilder<EventFilter>(
        stream: widget.bloc.filterStream,
        builder: (context, snapshot) {
          EventFilter? filter = snapshot.data;
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
                            ? eq(filter!.levels, EventLevel.values)
                            : false,
                        onChanged: (value) {

                          if (eq(filter!.levels, EventLevel.values))
                          {
                            eventFilter.levels = [];
                            widget.bloc.fetch();
                          }
                          else{
                            eventFilter.levels = List.from(EventLevel.values);
                            widget.bloc.fetch();
                          }
                          eventFilter.allLevels = eq(filter.levels, EventLevel.values);
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

                      if (eq(filter!.levels, EventLevel.values))
                      {
                        eventFilter.levels = [];
                        widget.bloc.fetch();
                      }
                      else
                      {
                        eventFilter.levels = List.from(EventLevel.values);
                        widget.bloc.fetch();
                      }
                      eventFilter.allLevels = eq(filter.levels, EventLevel.values);
                    },
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: dividerColor,
                  ),
                  ...widget.levels
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
                            ? filter!.levels.contains(e)
                            : true,
                        onChanged: (value) {
                          eventFilter.levels.contains(e)
                              ? widget.bloc.removeLevel(e)
                              : widget.bloc.addLevel(e);
                          eventFilter.allLevels = eq(filter!.levels, EventLevel.values);
                        },
                        activeColor: active,
                      ),
                    ),
                    title: Row(
                      children: [
                        Container( decoration: BoxDecoration(
                          color: eventLevelAsObject(EventType.Risk, e).color,
                          shape: BoxShape.circle
                        ),
                        height: 22, width: 22,
                        child: Center(child: Text(eventLevelAsObject(EventType.Risk, e).name, style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 9,
                          color: white
                        ),),),
                        ) ,
                        /*  SizedBox(width: 10,),
                        Text(
                          priorityAsText(e),
                          style: textStyle_Text_12_500,
                        ),*/
                      ],
                    ),
                    onTap: () async {
                      eventFilter.levels.contains(e)
                          ? widget.bloc.removeLevel(e)
                          : widget.bloc.addLevel(e);
                      eventFilter.allLevels = eq(filter!.levels, EventLevel.values);
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
  final EventFilterBloc bloc;
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
    return StreamBuilder<EventFilter>(
        stream: widget.bloc.filterStream,
        builder: (context, filterSnapshot) {
          return Text(
            filterSnapshot.hasData ? eq(filterSnapshot.data!.levels, EventLevel.values) ? "Par défaut" : "Personnalisé" : "Par défaut",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 11,
            ),
          );});
  }
}