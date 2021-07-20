import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/bloc_provider.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/event_bloc.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/body/project_overview_body.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/data/calculation.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/data/event.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/widgets/calculation_item.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/messages.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/multi_options_button.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/pages/projects/widgets/search_text_field.dart';
import 'package:gestion_projets/services/navigation_service.dart';
import 'package:gestion_projets/widgets/custom_tag.dart';
import 'package:gestion_projets/widgets/profile_avatar.dart';
import 'package:intl/intl.dart';

import '../../../../../locator.dart';

final ScrollController scrollController = ScrollController();

class CalculationsHeader extends StatelessWidget {
  const CalculationsHeader({
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
            "Évaluations",
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
          "Indice de risque",
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
          "Calculs",
          style: textStyle_Text_12_600
        ),
        SizedBox(
          width: 2,
        ),
        Padding(
            padding: EdgeInsets.only(top: 2),
            child: CustomIconButton(
              icon: Icons.info,
              message: "Calculs",
              onTap: () {},
              size: 17,
            )),
        Expanded(child: Container()),
        MultiOptionsButton(
          text: "Ajouter un calcul",
          isMultiple: false,
          onTap: () {
            // bloc.add(new   Event(new Random().nextInt(99999), "Retard potentiel pour une tâche", "Chronologie", "Retard dans la prochaine action", "Ressources humaines", "Développement d'une nouvelle interface utilisateur", DateTime.now(), EventType.Opportunity, EventLevel.low, User(12,"Saidani Wael","https://i.imgur.com/kieKRFZ.jpeg"), [] ,[Document(1, "name")]),);
          },
        ),
      ],
    );
  }
}

class CalculationsBody extends StatefulWidget {
  const CalculationsBody({Key? key}) : super(key: key);

  @override
  _CalculationsBodyState createState() => _CalculationsBodyState();
}

class _CalculationsBodyState extends State<CalculationsBody> {
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
        CalculationsHeader(),
        EvaluationDetails(),
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
                                    "Date de création",
                                    overflow: TextOverflow.ellipsis,
                                    style: textStyle_Text_12_600
                                  )),
                                ],
                              ),
                            ),
                            flex: 2,
                          ),
                          Expanded(
                            child: Container(
                                child: Row(
                              children: events
                                  .first.evaluations.first.formula.criteria
                                  .map(
                                    (e) => Expanded(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Flexible(
                                                  child: Text(
                                                e.name,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    color: text,
                                                    fontSize: 12,
                                                    letterSpacing: 0,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ))
                                            ],
                                          ),
                                        ],
                                      ),
                                      flex: 2,
                                    ),
                                  )
                                  .toList(),
                            )),
                            flex: 2 *
                                events.first.evaluations.first.formula.criteria
                                    .length,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                                child: Row(children: [
                              Flexible(
                                  child: Text(
                                "Score",
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
                                    "Date de début",
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
                            child: Container(
                              child: Row(
                                children: [
                                  Flexible(
                                      child: Text(
                                    "Date de fin",
                                    overflow: TextOverflow.ellipsis,
                                    style: textStyle_Text_12_600
                                  )),
                                ],
                              ),
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
                        child: CalculationsList(
                      parentContext: context,
                    )),
                  ]),
                )))
      ],
    ));
  }
}

class CalculationsList extends StatefulWidget {
  final BuildContext parentContext;

  const CalculationsList({Key? key, required this.parentContext})
      : super(key: key);

  @override
  _CalculationsListState createState() => _CalculationsListState();
}

class _CalculationsListState extends State<CalculationsList> {
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
                      ? (results!.first.evaluations.first.calculations.isEmpty)
                          ? NoObjectives()
                          : ListView(
                              key: ValueKey(Random.secure()),
                              controller: scrollController,
                              children: results
                                  .first.evaluations.first.calculations
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

  Widget _buildItem(Calculation calculation) {
    return TestProxy(
        key: ValueKey(calculation),
        child: new CalculationItem(
          onTap: () {},
          evaluation: events.first.evaluations.first,
          calculation: calculation,
        ));
  }
}

class EvaluationDetails extends StatefulWidget {
  const EvaluationDetails({Key? key}) : super(key: key);

  @override
  _EvaluationDetailsState createState() => _EvaluationDetailsState();
}

String getText(DateTime date) => DateFormat.yMMMMd('fr_FR').format(date);

class _EvaluationDetailsState extends State<EvaluationDetails> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<EventBloc>(context);

    return Container(
        child: StreamBuilder<List<Event>>(
            stream: bloc.eventStream,
            builder: (context, snapshot) {
              return Container(
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
                        EvaluationDetailsHeader(),
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
                                            events.first.evaluations.first.name,
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
                                        text: events.first.evaluations.first
                                            .formula.formula,
                                        color: text,
                                        date: events.first.evaluations.first
                                            .formula.name,
                                      ),
                                    ])),
                                    flex: 2,
                                  ),

                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Container(
                                        child: Row(children: [
                                      CustomTag(
                                        text: events
                                            .first.evaluations.first.minValue
                                            .toString(),
                                        color: lightBlue,
                                      ),
                                    ])),
                                    flex: 2,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Container(
                                        child: Row(children: [
                                      CustomTag(
                                        text: events
                                            .first.evaluations.first.maxValue
                                            .toString(),
                                        color: lightRed,
                                      ),
                                    ])),
                                    flex: 2,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Container(
                                        child: Row(children: [
                                      CustomTag(
                                        text: events.first.evaluations.first
                                                .calculations.length
                                                .toString() +
                                            " Calculs",
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
                                            getText(events.first.evaluations
                                                .first.creationDate),
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
                                              picture: events.first.evaluations
                                                  .first.user.avatar,
                                              name: events.first.evaluations
                                                  .first.user.name,
                                            )),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Flexible(
                                            child: Text(
                                          events.first.evaluations.first.user
                                              .name,
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
                          ),
                          Divider(
                            height: 1,
                            color: dividerColor,
                          ),
                          // Container(height: 60,)
                        ])
                      ])));
            }));
  }
}

class EvaluationDetailsHeader extends StatelessWidget {
  const EvaluationDetailsHeader({Key? key}) : super(key: key);

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
    );
  }
}
