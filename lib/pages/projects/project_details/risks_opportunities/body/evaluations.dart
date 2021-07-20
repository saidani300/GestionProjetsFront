import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/Data/items.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/bloc_provider.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/event_bloc.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/objective_bloc.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/data/objective.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/widgets/objective_item.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/body/project_overview_body.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data/document.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data/user.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/data/evaluation.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/data/event.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/widgets/evaluation_item.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/widgets/event_item.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/messages.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/multi_options_button.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/pages/projects/widgets/search_text_field.dart';
import 'package:gestion_projets/pages/projects/widgets/show_by_status_item.dart';
import 'package:gestion_projets/services/navigation_service.dart';
import 'package:gestion_projets/widgets/custom_tag.dart';
import 'package:gestion_projets/widgets/profile_avatar.dart';
import 'package:intl/intl.dart';

import '../../../../../locator.dart';

final ScrollController scrollController = ScrollController();

class EvaluationsHeader extends StatelessWidget {
  const EvaluationsHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<EventBloc>(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            locator<NavigationService>().eventGoBack();
          },
          child: Text(
            "Risques/Opportunités",
            style: textStyle_active_12_600
          ),
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
        Text(
          "Développement d'une nouvelle interface utilisateur",
          style: textStyle_Text_12_600
        ),
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
        Text(
          "Évaluations",
          style: textStyle_Text_12_600
        ),
        SizedBox(
          width: 2,
        ),
        Padding(
            padding: EdgeInsets.only(top: 2),
            child: CustomIconButton(
              icon: Icons.info,
              message: "Évaluations",
              onTap: () {},
              size: 17,
            )),
        Expanded(child: Container()),
        MultiOptionsButton(
          text: "Créer une évaluation",
          isMultiple: false,
          onTap: () {
            // bloc.add(new   Event(new Random().nextInt(99999), "Retard potentiel pour une tâche", "Chronologie", "Retard dans la prochaine action", "Ressources humaines", "Développement d'une nouvelle interface utilisateur", DateTime.now(), EventType.Opportunity, EventLevel.low, User(12,"Saidani Wael","https://i.imgur.com/kieKRFZ.jpeg"), [] ,[Document(1, "name")]),);
          },
        ),
      ],
    );
  }
}

class EvaluationsBody extends StatefulWidget {
  const EvaluationsBody({Key? key}) : super(key: key);

  @override
  _EvaluationsBodyState createState() => _EvaluationsBodyState();
}

class _EvaluationsBodyState extends State<EvaluationsBody> {
  final ScrollController controller = ScrollController();

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(color: backgroundColor, child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        EvaluationsHeader(),
        EventDetails(),
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
                        //Menu
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(child: Container()),
                        SearchWidget(
                          text: "",
                          hintText: 'Rechercher des évaluations',
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
                                    "Évaluation",
                                    overflow: TextOverflow.ellipsis,
                                    style: textStyle_Text_12_600
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
                            child: Container(
                                child: Row(children: [
                              Flexible(
                                  child: Text(
                                "Formule",
                                overflow: TextOverflow.ellipsis,
                                style: textStyle_Text_12_600
                              )),
                            ])),
                            flex: 2,
                          ),

                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                                child: Row(children: [
                              Flexible(
                                  child: Text(
                                "Valeur min",
                                overflow: TextOverflow.ellipsis,
                                style: textStyle_Text_12_600
                              )),
                            ])),
                            flex: 2,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                                child: Row(children: [
                              Flexible(
                                  child: Text(
                                "Valeur max",
                                overflow: TextOverflow.ellipsis,
                                style: textStyle_Text_12_600
                              )),
                            ])),
                            flex: 2,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                                child: Row(children: [
                              Flexible(
                                  child: Text(
                                "Calculs",
                                overflow: TextOverflow.ellipsis,
                                style: textStyle_Text_12_600
                              )),
                            ])),
                            flex: 2,
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
                                    "Date de création",
                                    overflow: TextOverflow.ellipsis,
                                    style: textStyle_Text_12_600
                                  )),
                                ],
                              ),
                            ),
                            flex: 2,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Flexible(
                                    child: Text(
                                  "Responsable",
                                  overflow: TextOverflow.ellipsis,
                                  style: textStyle_Text_12_600
                                )),
                              ],
                            ),
                            flex: 2,
                          ), // ActionsMenu(),
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
                        child: EvaluationsList(
                      parentContext: context,
                    )),
                  ]),
                )))
      ],
    ));
  }
}

class EvaluationsList extends StatefulWidget {
  final BuildContext parentContext;

  const EvaluationsList({Key? key, required this.parentContext})
      : super(key: key);

  @override
  _EvaluationsListState createState() => _EvaluationsListState();
}

class _EvaluationsListState extends State<EvaluationsList> {
  late final bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<EventBloc>(widget.parentContext);
    super.initState();
    bloc.init();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder<List<Event>>(
            stream: bloc.eventStream,
            builder: (context, snapshot) {
              print("snapshot " + snapshot.data.toString());
              final results = snapshot.data;
              return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: (snapshot.hasData)
                      ? (results!.isEmpty)
                          ? NoObjectives()
                          : ListView(
                              key: ValueKey(Random.secure()),
                              controller: scrollController,
                              children: results.first.evaluations
                                  .map((e) => _buildItem(e))
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

  Widget _buildItem(Evaluation evaluation) {
    return TestProxy(
        key: ValueKey(evaluation),
        child: new EvaluationItem(
          onTap: () {},
          evaluation: evaluation,
          event: events.first,
        ));
  }
}

class EventDetails extends StatefulWidget {
  const EventDetails({Key? key}) : super(key: key);

  @override
  _EventDetailsState createState() => _EventDetailsState();
}

String getText(DateTime date) => DateFormat.yMMMMd('fr_FR').format(date);

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
        //height: 93,
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
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              EventDetailsHeader(),
              Divider(
                height: 1,
                color: dividerColor,
              ),
              Column(children: [
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
                            color: TypeColor(events.first.eventType),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Container(
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  events.first.eventType ==
                                          EventType.Opportunity
                                      ? "icons/up-arrow.svg"
                                      : "icons/down-arrow.svg",
                                  color: events.first.eventType ==
                                          EventType.Opportunity
                                      ? lightBlue
                                      : lightRed,
                                  width: 20,
                                  height: 20,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                    child: Text(
                                  events.first.name,
                                  overflow: TextOverflow.ellipsis,
                                  style: textStyle_Text_12_600
                                )),
                                SizedBox(width: 5),
                                Visibility(
                                    visible: events.first.documents.isNotEmpty,
                                    child: CustomIconButton(
                                      icon: Icons.attach_file_rounded,
                                      message:
                                          "${events.first.documents.length.toString()} Attachement",
                                      onTap: () {},
                                      size: 15,
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
                          child: Container(
                            child: Row(
                              children: [
                                Flexible(
                                    child: Text(
                                  events.first.impact,
                                  overflow: TextOverflow.ellipsis,
                                  style: textStyle_Text_12_600
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
                          child: Container(
                            child: Row(
                              children: [
                                Flexible(
                                    child: Text(
                                  events.first.source,
                                  overflow: TextOverflow.ellipsis,
                                  style: textStyle_Text_12_600
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
                          child: Container(
                              child: Row(children: [
                            CustomTag(
                              text: events.first.evaluations.length.toString() +
                                  " Évaluations",
                              color: text,
                            ),
                          ])),
                          flex: 2,
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
                                  getText(events.first.identificationDate),
                                  overflow: TextOverflow.ellipsis,
                                  style: textStyle_Text_12_600
                                )),
                              ],
                            ),
                          ),
                          flex: 2,
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
                                    picture: events.first.user.avatar,
                                    name: events.first.user.name,
                                  )),
                              SizedBox(
                                width: 15,
                              ),
                              Flexible(
                                  child: Text(
                                events.first.user.name,
                                overflow: TextOverflow.ellipsis,
                                style: textStyle_Text_12_600
                              )),
                            ],
                          ),
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
                                    child: LevelTag(
                                  level: events.first.level,
                                ))
                              ]),
                          flex: 1,
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
                ),
                // Container(height: 60,)
              ])
            ])));
  }
}

class EventDetailsHeader extends StatelessWidget {
  const EventDetailsHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    "Risque / Opportunité",
                    overflow: TextOverflow.ellipsis,
                    style: textStyle_Text_12_600
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
            child: Container(
              child: Row(
                children: [
                  Flexible(
                      child: Text(
                    "Impact",
                    overflow: TextOverflow.ellipsis,
                    style: textStyle_Text_12_600
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
            child: Container(
              child: Row(
                children: [
                  Flexible(
                      child: Text(
                    "Source",
                    overflow: TextOverflow.ellipsis,
                    style: textStyle_Text_12_600
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
            child: Container(
                child: Row(children: [
              Flexible(
                  child: Text(
                "Évaluations",
                overflow: TextOverflow.ellipsis,
                style: textStyle_Text_12_600
              )),
            ])),
            flex: 2,
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
                    "Date d'identification",
                    overflow: TextOverflow.ellipsis,
                    style: textStyle_Text_12_600
                  )),
                ],
              ),
            ),
            flex: 2,
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Row(
              children: [
                Flexible(
                    child: Text(
                  "Identifié par",
                  overflow: TextOverflow.ellipsis,
                  style: textStyle_Text_12_600
                )),
              ],
            ),
            flex: 2,
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Row(children: [
              Flexible(
                  child: Text(
                "Niveau",
                overflow: TextOverflow.ellipsis,
                style: textStyle_Text_12_600
              )),
            ]),
            flex: 1,
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
    );
  }
}
