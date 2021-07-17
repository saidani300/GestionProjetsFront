import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/Data/items.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/bloc_provider.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/objective_bloc.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/data/chartData.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/data/indicator.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/data/measure.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/data/objective.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/widgets/indicator_item.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/widgets/measure_item.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/widgets/measures_chart.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/body/project_overview_body.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/messages.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/multi_options_button.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/pages/projects/widgets/search_text_field.dart';
import 'package:gestion_projets/pages/projects/widgets/show_by_status_item.dart';
import 'package:gestion_projets/services/navigation_service.dart';
import 'package:gestion_projets/widgets/custom_tag.dart';
import 'package:gestion_projets/widgets/profile_avatar.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../../locator.dart';

final ScrollController scrollController = ScrollController();

class IndicatorHeader extends StatelessWidget {
  const IndicatorHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ObjectiveBloc>(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            locator<NavigationService>().projectGoBack();
          },
          child: Text(
            "Objectifs",
            style: TextStyle(
                color: active,
                fontSize: 12,
                letterSpacing: 0,
                fontWeight: FontWeight.w600),
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
          "Objectif de développement",
          style: TextStyle(
              color: text,
              fontSize: 12,
              letterSpacing: 0,
              fontWeight: FontWeight.w600),
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
          "Indicateurs",
          style: TextStyle(
              color: text,
              fontSize: 12,
              letterSpacing: 0,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(
          width: 2,
        ),
        Padding(
            padding: EdgeInsets.only(top: 2),
            child: CustomIconButton(
              icon: Icons.info,
              message: "Indicateurs",
              onTap: () {},
              size: 17,
            )),
        Expanded(child: Container()),
        MultiOptionsButton(
          text: "Ajouter une mesure",
          isMultiple: false,
          onTap: () {
            bloc.addMeasure(
                Objectives.last.indicators.first,
                new Measure(
                    new Random().nextInt(99999),
                    new Random().nextInt(100).toDouble(),
                    DateTime.now(),
                    DateTime.now(),
                    DateTime.now().add(Duration(days: 90)), []));
          },
        ),
      ],
    );
  }
}

class IndicatorBody extends StatefulWidget {
  const IndicatorBody({Key? key}) : super(key: key);

  @override
  _IndicatorBodyState createState() => _IndicatorBodyState();
}

class _IndicatorBodyState extends State<IndicatorBody> {
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
    return Container(
        color: backgroundColor,
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IndicatorHeader(),
            IndicatorDetails(),
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
                        color: Colors.white,
                      ),
                      child: Column(children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(3),
                                topRight: Radius.circular(3),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0)),
                            color: Colors.white,
                          ),
                          alignment: Alignment.bottomLeft,
                          child: Row(children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: ShowByStatusItems.map(
                                (e) => Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: ShowByStatusItem(
                                        itemName: e.name, onTap: () {})),
                              ).toList(),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(child: Container()),
                            SearchWidget(
                              text: "",
                              hintText: 'Rechercher des objectifs',
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
                          color: dark.withOpacity(0.15),
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
                                    child: Row(children: [
                                  Flexible(
                                      child: Text(
                                    "Mesure",
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
                                child: Container(
                                  child: Row(
                                    children: [
                                      Flexible(
                                          child: Text(
                                        "Cible",
                                        overflow: TextOverflow.ellipsis,
                                        style: style,
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
                                      "Écart",
                                      overflow: TextOverflow.ellipsis,
                                      style: style,
                                    )),
                                  ],
                                ),
                                flex: 2,
                              ),
                              Expanded(
                                child: Container(
                                    child: Row(children: [
                                  Flexible(
                                      child: Text(
                                    "Date de création",
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
                                child: Row(children: [
                                  Flexible(
                                      child: Text(
                                    "Date de début",
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
                              Expanded(
                                child: Row(children: [
                                  Flexible(
                                      child: Text(
                                    "Date de fin",
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
                              Expanded(
                                child: Row(children: [
                                  Flexible(
                                      child: Text(
                                    "Performance",
                                    overflow: TextOverflow.ellipsis,
                                    style: style,
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
                        ),
                        Divider(
                          height: 1,
                          color: dark.withOpacity(0.15),
                        ),
                        Expanded(
                            child: MeasuresList(
                          parentContext: context,
                        )),
                      ]),
                    )))
          ],
        ));
  }
}

class MeasuresList extends StatefulWidget {
  final BuildContext parentContext;
  const MeasuresList({Key? key, required this.parentContext}) : super(key: key);

  @override
  _MeasuresListState createState() => _MeasuresListState();
}

class _MeasuresListState extends State<MeasuresList> {
  late final bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<ObjectiveBloc>(widget.parentContext);
    super.initState();
    bloc.init();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder<List<Objective>>(
            stream: bloc.objectiveStream,
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
                              children: results.last.indicators.first.measures
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

  Widget _buildItem(Measure measure) {
    return TestProxy(
        key: ValueKey(measure),
        child: new MeasureItem(
          onTap: () {},
          indicator: Objectives.last.indicators.first,
          measure: measure,
        ));
  }
}

////////////////
List<ChartData> chartData = [];

class IndicatorDetails extends StatefulWidget {
  const IndicatorDetails({Key? key}) : super(key: key);

  @override
  _IndicatorDetailsState createState() => _IndicatorDetailsState();
}

class _IndicatorDetailsState extends State<IndicatorDetails> {
  bool _firstChild = true;
  String message = "Afficher le graphique";
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
              color: Colors.white,
            ),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              IndicatorDetailsHeader(),
              Divider(
                height: 1,
                color: dark.withOpacity(0.15),
              ),
              IndicatorDetailsItem(
                indicator: indicator,
                chartMessage: message,
                onTap: () {},
                onChartTap: () {
                  setState(() {
                    _firstChild = !_firstChild;

                  });
                  if(message.contains("Afficher"))
                  {
                    setState(() {message = "Masquer le graphique"; });
                  }
                  else
                    {
                      setState(() {message = "Afficher le graphique"; });
                    }
                },
              ),
              AnimatedCrossFade(
                firstCurve: Curves.easeIn,
                secondCurve: Curves.easeOut,
                firstChild: Container(),
                secondChild: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Divider(
                      height: 1,
                      color: dark.withOpacity(0.15),
                    ),
                    MeasuresChart(
                      parentContext: context,
                    )
                  ],
                ),
                crossFadeState: _firstChild
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: Duration(milliseconds: 200),
              ),
            ])));
  }
}

class IndicatorDetailsHeader extends StatelessWidget {
  const IndicatorDetailsHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
        color: text,
        fontSize: 12,
        letterSpacing: 0,
        fontWeight: FontWeight.w600);
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
                    "Indicateur",
                    overflow: TextOverflow.ellipsis,
                    style: style,
                  )),
                ],
              ),
            ),
            flex: 6,
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
                child: Row(children: [
              Flexible(
                  child: Text(
                "Valeur minimale",
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
                    "Valeur maximale",
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
            child: Container(
              child: Row(
                children: [
                  Flexible(
                      child: Text(
                    "Seuil critique",
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
                  "Superviseur",
                  overflow: TextOverflow.ellipsis,
                  style: style,
                )),
              ],
            ),
            flex: 4,
          ),
          Expanded(
            child: Row(
              children: [
                Flexible(
                    child: Text(
                  "Nature et fréquence",
                  overflow: TextOverflow.ellipsis,
                  style: style,
                )),
              ],
            ),
            flex: 4,
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

class IndicatorDetailsItem extends StatefulWidget {
  final VoidCallback onTap;
  final Function() onChartTap;
  final String chartMessage;
  final Indicator indicator;
  const IndicatorDetailsItem(
      {Key? key,
      required this.indicator,
      required this.onTap,
      required this.onChartTap,
      this.chartMessage = "Afficher le graphique"})
      : super(key: key);

  @override
  _IndicatorDetailsItemState createState() => _IndicatorDetailsItemState();
}

class _IndicatorDetailsItemState extends State<IndicatorDetailsItem> {
  String getText(DateTime date) => DateFormat.yMMMMd('fr_FR').format(date);

  initState() {
    super.initState();
  }

  @override
  dispose() {
    print("Disposed " + widget.hashCode.toString());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      InkWell(
        hoverColor: active.withOpacity(0.015),
        onTap: () {
          print("tapped");
          widget.onTap();
        },
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        child: Container(
          height: 50,
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
                        widget.indicator.name,
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
                flex: 6,
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Container(
                    child: Row(children: [
                  CustomTag(
                    text: widget.indicator.minValue.toString() +
                        " " +
                        widget.indicator.unit,
                    color: lightOrange,
                  )
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
                      CustomTag(
                        text: widget.indicator.maxValue.toString() +
                            " " +
                            widget.indicator.unit,
                        color: lightBlue,
                      )
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
                      CustomTag(
                        text: widget.indicator.criticalThreshold.toString() +
                            " " +
                            widget.indicator.unit,
                        color: lightRed,
                      )
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
                          picture: widget.indicator.user.avatar,
                          name: widget.indicator.user.name,
                        )),
                    SizedBox(
                      width: 15,
                    ),
                    Flexible(
                        child: Text(
                      widget.indicator.user.name,
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
                child: Row(
                  children: [
                    Flexible(
                        child: Text(
                      widget.indicator.autoMeasure
                          ? "Automatique :"
                          : "Manuelle : ",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: text,
                          fontSize: 12,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w600),
                    )),
                    Flexible(
                        child: Text(
                      indicatorFrequencyAsText(widget.indicator.frequency),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: text,
                          fontSize: 12,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w500),
                    )),
                  ],
                ),
                flex: 4,
              ),
              // ActionsMenu(),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 40,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(child: Container()),
                    CustomIconButton(
                        icon: Icons.bar_chart,
                        message: widget.chartMessage,
                        onTap: widget.onChartTap,
                      size: 20,
                    ),
                  ],
                ),
              ),

              SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
