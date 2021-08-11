import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/project_bloc.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/dialogs/create_project_dialog.dart';
import 'package:gestion_projets/dialogs/dialogs.dart';
import 'package:gestion_projets/dialogs/messages.dart';
import 'package:gestion_projets/pages/projects/Data/project.dart';
import 'package:gestion_projets/pages/projects/filter/Data/project_filter.dart';
import 'package:gestion_projets/pages/projects/filter/widgets/project_order_by.dart';
import 'package:gestion_projets/pages/projects/project_details/structure/body/project_overview_body.dart';
import 'package:gestion_projets/pages/projects/project_details/structure/data/phase.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/multi_options_button.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/pages/projects/filter/project_filter.dart';
import 'package:gestion_projets/pages/projects/widgets/project_item.dart';
import 'package:gestion_projets/pages/projects/widgets/search_text_field.dart';
import 'package:gestion_projets/pages/projects/widgets/show_by_status_menu.dart';

//TODO : Add number of projects
//TODO: Change add project button, more height and make it global style
//TODO: Change project status tag , it's ugly
//TODO: Select multiple projects
bool _isFilterClosed = true;

class ProjectsPageBody extends StatefulWidget {
  @override
  _ProjectsPageBodyState createState() => _ProjectsPageBodyState();
}

/*_______________________________________________________________________*/
/*_______________________________________________________________________*/
/*_______________________________________________________________________*/
/*_______________________________________________________________________*/
/*_______________________________________________________________________*/

class ProjectsPageHeader extends StatelessWidget {
  final ScrollController controller;
  final VoidCallback onTap;

  const ProjectsPageHeader({
    Key? key,
    required this.onTap,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //SvgPicture.asset("icons/Projects.svg" , width: 20, height: 20,),
        Icon(
          Icons.layers_rounded,
          size: 20,
          color: active,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          'Projets',
          style: TextStyle(
              color: dark,
              fontSize: 20,
              letterSpacing: 0,
              fontWeight: FontWeight.w500),
        ),
        Expanded(child: Container()),
        //TODO : Active Export to files , Add more files types options, fix ugly button and change position.

        //TODO: Fix Button ,ugly too
        MultiOptionsButton(
            text: "Créer un projet",
            isMultiple: false,
            onTap: () {
              createProjectDialogBox(context, controller);
            }),
      ],
    );
  }
}

/*_______________________________________________________________________*/
/*_______________________________________________________________________*/
/*_______________________________________________________________________*/
/*_______________________________________________________________________*/
/*_______________________________________________________________________*/
//GlobalKey<ProjectsList> _myKey = GlobalKey();
class _ProjectsPageBodyState extends State<ProjectsPageBody> {
  final ScrollController controller = ScrollController();

  @override
  initState() {
    super.initState();
    projectsFilterData = ProjectGlobalFilter(null, null, null, null, null);
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ProjectBloc>(context);
    return Container(
        color: backgroundColor,
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ProjectsPageHeader(
              onTap: () {},
              controller: controller,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 20),
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: lightGrey.withOpacity(0.3), width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          spreadRadius: 0.5,
                          blurRadius: 0.5,
                          // offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(3),
                      color: white,
                    ),
                    child: Column(
                      children: [
                        Container(
                            alignment: Alignment.bottomLeft,
                            child: Row(children: [
                              ShowProjectsByStatusMenu(),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(child: Container()),
                              SearchWidget(
                                hintText: 'Rechercher des projets...',
                                onChanged: (value) {
                                  projectsSearchQuery = value;
                                  bloc.fetch();
                                },
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              CustomIconButton(
                                  icon: Icons.save_alt_rounded,
                                  message: 'Exporter',
                                  onTap: () {
                                    showExportDialogBox(context);
                                  }),
                              SizedBox(
                                width: 15,
                              ),
                              ProjectFilterMenu(),
                              SizedBox(
                                width: 15,
                              ),
                            ])),
                        AnimatedCrossFade(
                          firstCurve: Curves.easeIn,
                          secondCurve: Curves.easeOut,
                          firstChild: Container(),
                          secondChild: Column(children: [
                            Container(
                              height: 1,
                              color: dividerColor,
                            ),
                            /* Filter(apply: () {
                              setState(() {
                                _isFilterClosed = !_isFilterClosed;
                              });
                            }),*/
                          ]),
                          crossFadeState: _isFilterClosed
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                          duration: Duration(milliseconds: 200),
                        ),
                        Divider(
                          height: 1,
                          color: dividerColor,
                        ),
                        ProjectsListHeader(),
                        Divider(
                          height: 1,
                          color: dividerColor,
                        ),
                        Expanded(
                            child: ProjectsList(
                          parentContext: context,
                          scrollController: controller,
                        )),
                      ],
                    )),
              ),
            )
          ],
        ));
  }
}
/*_______________________________________________________________________*/
/*_______________________________________________________________________*/
/*_______________________________________________________________________*/
/*_______________________________________________________________________*/
/*_______________________________________________________________________*/

class ProjectsListHeader extends StatelessWidget {
  const ProjectsListHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              child: Row(
                children: [
                  Flexible(
                      child: Text("Projet",
                          overflow: TextOverflow.ellipsis,
                          style: textStyle_Text_12_600)),
                ],
              ),
            ),
            flex: 3,
          ),
          SizedBox(
            width: 18,
          ),
          Expanded(
            child: Container(
              child: Row(
                children: [
                  Flexible(
                      child: Text("Date de début",
                          overflow: TextOverflow.ellipsis,
                          style: textStyle_Text_12_600)),
                ],
              ),
            ),
            flex: 2,
          ),
          SizedBox(
            width: 18,
          ),
          Expanded(
            child: Container(
              child: Row(
                children: [
                  Flexible(
                      child: Text("Date limite",
                          overflow: TextOverflow.ellipsis,
                          style: textStyle_Text_12_600)),
                ],
              ),
            ),
            flex: 2,
          ),
          SizedBox(
            width: 18,
          ),
          Expanded(
            child: Container(
              child: Row(
                children: [
                  Flexible(
                      child: Text("Chef d'équipe",
                          overflow: TextOverflow.ellipsis,
                          style: textStyle_Text_12_600)),
                ],
              ),
            ),
            flex: 2,
          ),
          SizedBox(
            width: 18,
          ),
          Expanded(
            child: Container(
              child: Row(
                children: [
                  Flexible(
                      child: Text("Priorité",
                          overflow: TextOverflow.ellipsis,
                          style: textStyle_Text_12_600)),
                ],
              ),
            ),
            flex: 1,
          ),
          SizedBox(
            width: 18,
          ),
          Expanded(
            child: Container(
              child: Row(
                children: [
                  Flexible(
                      child: Text("Statut",
                          overflow: TextOverflow.ellipsis,
                          style: textStyle_Text_12_600)),
                ],
              ),
            ),
            flex: 1,
          ),
          SizedBox(
            width: 18,
          ),
          Container(
            width: 50,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(child: Container()),
                ProjectOrderBy(widgetHeight: 30),
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}

class ProjectsList extends StatefulWidget {
  final BuildContext parentContext;
  final ScrollController scrollController;

  const ProjectsList(
      {Key? key, required this.parentContext, required this.scrollController})
      : super(key: key);

  @override
  _ProjectsListState createState() => _ProjectsListState();
}

class _ProjectsListState extends State<ProjectsList> {
  late final bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<ProjectBloc>(widget.parentContext);
    super.initState();
    bloc.init();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ProjectBloc>(widget.parentContext);
    return Container(
        child: StreamBuilder<List<Project>>(
            stream: bloc.projectStream,
            builder: (context, snapshot) {
              final results = snapshot.data;
              return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: (snapshot.hasData)
                      ? (results!.isEmpty)
                          ? (projectsSearchQuery.isNotEmpty)
                              ? NoResultFound()
                              : projectsFilterData.status == Status.completed
                                  ? NoCompletedProjects(
                                      onTap: () {
                                        createProjectDialogBox(
                                            context, widget.scrollController);
                                      },
                                    )
                                  : NoProjects(
                                      onTap: () {
                                        createProjectDialogBox(
                                            context, widget.scrollController);
                                      },
                                    )
                          : ListView(
                              key: ValueKey(Random.secure()),
                              controller: widget.scrollController,
                              children:
                                  results.map((e) => _buildItem(e)).toList(),
                            )
                      : Center(
                          child: SpinKitFadingCube(
                            color: active,
                            size: 25,
                            duration: Duration(milliseconds: 1200),
                          ),
                        ));
            }));
  }

  Widget _buildItem(Project project) {
    return TestProxy(
        key: ValueKey(project),
        child: new ProjectItem(
          project: project,
        ));
  }
}
