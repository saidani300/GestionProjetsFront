import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/objective_bloc.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/dialogs/create_objective_dialog.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/data/objective.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/widgets/objective_item.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/widgets/view_types.dart';
import 'package:gestion_projets/pages/projects/project_details/structure/body/project_overview_body.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/messages.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/multi_options_button.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/pages/projects/widgets/search_text_field.dart';
import 'package:gestion_projets/services/navigation_service.dart';

import '../../../../../locator.dart';

class ProjectObjectivesHeader extends StatelessWidget {
  final ScrollController scrollController;

  const ProjectObjectivesHeader({Key? key, required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            locator<NavigationService>().projectGoBack();
          },
          child: Text("Projets", style: textStyle_active_12_600),
        ),
        Padding(
            padding: EdgeInsets.only(top: 2),
            child: Icon(
              Icons.keyboard_arrow_right_rounded,
              size: 16,
              color: active,
            )),
        SizedBox(
          width: 2,
        ),
        Text("Développement d'une nouvelle interface utilisateur",
            style: textStyle_Text_12_600),
        SizedBox(
          width: 2,
        ),
        Padding(
            padding: EdgeInsets.only(top: 2),
            child: Icon(
              Icons.keyboard_arrow_right_rounded,
              size: 16,
              color: active,
            )),
        SizedBox(
          width: 2,
        ),
        Text("Objectifs", style: textStyle_Text_12_600),
        SizedBox(
          width: 2,
        ),
        Padding(
            padding: EdgeInsets.only(top: 2),
            child: CustomIconButton(
              icon: Icons.info,
              message:
                  "Ajoutez des objectifs généraux d’entreprise pour aider les équipes à hiérarchiser\nles tâches et à faire le lien entre leur travail et les objectifs de votre organisation.",
              onTap: () {},
              size: 17,
            )),
        Expanded(child: Container()),
        MultiOptionsButton(
          text: "Créer un Objectif",
          isMultiple: false,
          onTap: () {
            createObjectiveDialogBox(context, scrollController);
          },
        ),
      ],
    );
  }
}

class ProjectObjectivesBody extends StatefulWidget {
  const ProjectObjectivesBody({Key? key}) : super(key: key);

  @override
  _ProjectObjectivesBodyState createState() => _ProjectObjectivesBodyState();
}

class _ProjectObjectivesBodyState extends State<ProjectObjectivesBody> {
  final ScrollController controller = ScrollController();

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
        color: text,
        fontSize: 12,
        letterSpacing: 0,
        fontWeight: FontWeight.w600);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ProjectObjectivesHeader(scrollController: controller),
        Expanded(
            child: Container(
                margin: EdgeInsets.only(top: 20),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: lightGrey.withOpacity(0.3),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        spreadRadius: 0.5,
                        blurRadius: 0.5,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(3),
                    color: white,
                  ),
                  child: Column(children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(3),
                            topRight: Radius.circular(3),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0)),
                        color: white,
                      ),
                      alignment: Alignment.bottomLeft,
                      child: Row(children: [
                        ObjectiveShowByViewMenu(),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(child: Container()),
                        SearchWidget(
                          hintText: 'Rechercher des objectifs...',
                          onChanged: (value) {},
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        CustomIconButton(
                            icon: Icons.save_alt_rounded,
                            message: 'Exporter',
                            onTap: () {
                              /*  bloc.fetch();*/
                            }),
                        SizedBox(
                          width: 15,
                        ),
                        CustomIconButton(
                          icon: Icons.filter_alt_outlined,
                          message: 'Filter',
                          onTap: () {},
                        ),
                        SizedBox(
                          width: 15,
                        ),
                      ]),
                    ),
                    Divider(
                      height: 1,
                      color: dividerColor,
                    ),
                    Container(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 2,
                            child: Container(
                              color: Colors.transparent,
                            ),
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
                                    "Objectif",
                                    overflow: TextOverflow.ellipsis,
                                    style: style,
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
                                  child: Text(
                                "Indicateurs",
                                overflow: TextOverflow.ellipsis,
                                style: style,
                              )),
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
                                    "Date limite",
                                    overflow: TextOverflow.ellipsis,
                                    style: style,
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
                                Flexible(
                                    child: Text(
                                  "Créer par",
                                  overflow: TextOverflow.ellipsis,
                                  style: style,
                                )),
                              ],
                            ),
                            flex: 4,
                          ),
                          Expanded(
                            child: Container(
                                child: Row(children: [
                              Flexible(
                                  child: Text(
                                "Priorité",
                                overflow: TextOverflow.ellipsis,
                                style: style,
                              )),
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
                                  Flexible(
                                      child: Text(
                                    "Statut",
                                    overflow: TextOverflow.ellipsis,
                                    style: style,
                                  )),
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
                              children: [],
                            ),
                          ),

                          SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: dividerColor,
                    ),
                    Expanded(
                        child: ObjectivesList(
                      parentContext: context,
                      scrollController: controller,
                    )),
                  ]),
                )))
      ],
    );
  }
}

class ObjectivesList extends StatefulWidget {
  final BuildContext parentContext;
  final ScrollController scrollController;

  const ObjectivesList(
      {Key? key, required this.parentContext, required this.scrollController})
      : super(key: key);

  @override
  _ObjectivesListState createState() => _ObjectivesListState();
}

class _ObjectivesListState extends State<ObjectivesList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ObjectiveBloc>(context);
    bloc.init();
    return Container(
        child: StreamBuilder<List<Objective>>(
            stream: bloc.objectiveStream,
            builder: (context, snapshot) {
              final results = snapshot.data;
              return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: (snapshot.hasData)
                      ? (results!.isEmpty)
                          ? NoItems(
                              icon: "icons/no-objective.svg",
                              message:
                                  "Il n'y a aucun objectif à afficher pour vous, actuellement vous n'en avez pas mais vous pouvez en créer un nouveau.",
                              title: "Aucun objectif trouvé",
                              buttonText: "Créer",
                              onTap: () {
                                createObjectiveDialogBox(
                                    context, widget.scrollController);
                              },
                            )
                          : ListView(
                              key: ValueKey(Random.secure()),
                              controller: widget.scrollController,
                              children: results
                                  .map((e) =>
                                      _buildItem(e, identical(results.last, e)))
                                  .toList(),
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

  Widget _buildItem(Objective objective, bool isLast) {
    return TestProxy(
        key: ValueKey(objective),
        child: new ObjectiveItem(
          objective: objective,
          isLast: isLast,
          onTap: () {},
        ));
  }
}
