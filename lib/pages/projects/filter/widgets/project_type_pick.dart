import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/filter/project_filter_bloc.dart';
import 'package:gestion_projets/BLoC/project_type_bloc.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/Data/project_filter_data.dart';
import 'package:gestion_projets/pages/projects/Data/project_type.dart';
import 'package:gestion_projets/pages/projects/widgets/form_widgets/custom_select_list.dart';

class ProjectTypesPicker extends StatefulWidget {
  final double widgetHeight;
  const ProjectTypesPicker({
    Key? key,
    this.widgetHeight = 40,
  }) : super(key: key);

  @override
  _ProjectTypesPickerState createState() => _ProjectTypesPickerState();
}

class _ProjectTypesPickerState extends State<ProjectTypesPicker> {
  late final projectTypeBloc;
  late final filterBloc;

  @override
  void initState() {
    projectTypeBloc = BlocProvider.of<ProjectTypeBloc>(context);
    filterBloc = BlocProvider.of<ProjectFilterBloc>(context);

    super.initState();
    projectTypeBloc.init();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ProjectType>>(
        stream: projectTypeBloc.projectTypeStream,
        builder: (context, snapshot) {
          return CustomListPopupMenuButton(
              containerHeight: widget.widgetHeight,
              offset: Offset(0, 38),
              child: StatusText(filterBloc),
              enabled: true,
              itemBuilder: (context) {
                return (snapshot.hasData)
                    ? [
                        CustomListPopupMenuItem(
                            value: 1,
                            enabled: false,
                            child: Container(
                                height: 161,
                                width: 250,
                                child: BlocProvider<ProjectFilterBloc>(
                                    bloc: ProjectFilterBloc(),
                                    child: ProjectTypesListView(snapshot.data!, filterBloc))))
                      ]
                    : [];
              });
        });
  }
}

class ProjectTypesListView extends StatefulWidget {
  final List<ProjectType> types;
  final ProjectFilterBloc bloc;
  ProjectTypesListView(this.types , this.bloc);

  @override
  _ProjectTypesListViewState createState() => _ProjectTypesListViewState();
}

class _ProjectTypesListViewState extends State<ProjectTypesListView> {

  @override
  void initState() {
    super.initState();
    widget.bloc.init();
  }

  @override
  Widget build(BuildContext context) {
    Function eq = const DeepCollectionEquality.unordered().equals;
    ScrollController controller = new ScrollController();
    return StreamBuilder<ProjectFilter>(
        stream: widget.bloc.filterStream,
        builder: (context, snapshot) {
          ProjectFilter? filter = snapshot.data;
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
                                  ? eq(filter!.types, projectTypesList)
                                  : false,
                              onChanged: (value) {

                                if (eq(filter!.types, projectTypesList))
                                {
                                  projectFilter.types = [];
                                  widget.bloc.fetch();
                                }
                                else{
                                  projectFilter.types = List.from(projectTypesList);
                                  widget.bloc.fetch();
                                }
                                projectFilter.allTypes = eq(filter.types, projectTypesList);
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
                            if (eq(filter!.types, projectTypesList))
                            {
                              projectFilter.types = [];
                              widget.bloc.fetch();
                            }
                              else{
                              projectFilter.types = [];
                                projectFilter.types = List.from(projectTypesList);
                              widget.bloc.fetch();
                            }
                            projectFilter.allTypes = eq(filter.types, projectTypesList);
                          },
                        ),
                        Divider(
                          height: 1,
                          thickness: 1,
                          color: dividerColor,
                        ),
                        ...widget.types
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
                                          ? filter!.types.contains(e)
                                          : true,
                                      onChanged: (value) {
                                        projectFilter.types.contains(e)
                                            ? widget.bloc.removeType(e)
                                            : widget.bloc.addType(e);
                                        projectFilter.allTypes = eq(filter!.types, projectTypesList);
                                      },
                                      activeColor: active,
                                    ),
                                  ),
                                  title: Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          e.name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: textStyle_Text_12_500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: () async {
                                    projectFilter.types.contains(e)
                                        ? widget.bloc.removeType(e)
                                        : widget.bloc.addType(e);
                                    projectFilter.allTypes = eq(filter!.types, projectTypesList);
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
  final ProjectFilterBloc bloc;
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
    return StreamBuilder<ProjectFilter>(
        stream: widget.bloc.filterStream,
        builder: (context, filterSnapshot) {
          return Text(
            filterSnapshot.hasData ? eq(filterSnapshot.data!.types, projectTypesList) ? "Par défaut" : "Personnalisé" : "Par défaut",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 11,
            ),
          );});
  }
}
