import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/objective_bloc.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/dialogs/attachments_dialog.dart';
import 'package:gestion_projets/dialogs/create_indicator_dialog.dart';
import 'package:gestion_projets/dialogs/dialogs.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/data/indicator.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/data/objective.dart';
import 'package:gestion_projets/pages/projects/project_details/structure/body/project_overview_body.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/widgets/custom_tag.dart';
import 'package:gestion_projets/widgets/priority_icon.dart';
import 'package:gestion_projets/widgets/profile_avatar.dart';
import 'package:intl/intl.dart';

import 'change_objective_status_button.dart';
import 'indicator_item.dart';

class ObjectiveItem extends StatefulWidget {
  final VoidCallback onTap;
  final bool isLast;
  final Objective objective;

  const ObjectiveItem(
      {Key? key,
      required this.objective,
      required this.onTap,
      this.isLast = false})
      : super(key: key);

  @override
  _ObjectiveItemState createState() => _ObjectiveItemState();
}

class _ObjectiveItemState extends State<ObjectiveItem>
    with
        AutomaticKeepAliveClientMixin<ObjectiveItem>,
        TickerProviderStateMixin {
  String getText(DateTime date) => DateFormat.yMMMMd('fr_FR').format(date);
  late AnimationController _controller;
  late Animation<double> _animation;

  initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this, value: 0);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ObjectiveBloc>(context);
    super.build(context);

    return FadeTransition(
        opacity: _animation,
        child: SizeTransition(
            sizeFactor: _animation,
            child: Material(
                color: Colors.transparent,
                child: Column(children: [
                  InkWell(
                    hoverColor: active.withOpacity(0.015),
                    onTap: () {},
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
                              color: statusColor(widget.objective.status),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                              child: Row(
                                children: [
                                  MultiOptionsStatusChange(
                                    objective: widget.objective,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Flexible(
                                    child: AutoSizeText(
                                      widget.objective.name,
                                      maxLines: 1,
                                      style: textStyle_Text_12_600,
                                      overflowReplacement: Row(
                                        children: [
                                          Flexible(
                                            child: Tooltip(
                                                message: widget.objective.name,
                                                child: Text(
                                                    widget.objective.name,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        textStyle_Text_12_600)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Visibility(
                                      visible:
                                          widget.objective.documents.isNotEmpty,
                                      child: CustomIconButton(
                                        icon: Icons.attach_file_rounded,
                                        message:
                                            "${widget.objective.documents.length.toString()} Attachement",
                                        onTap: () {
                                          attachmentsDialogBox(context,
                                              widget.objective.documents);
                                        },
                                        size: 15,
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
                              CustomTag(
                                text: widget.objective.indicators.length
                                        .toString() +
                                    " Indicateurs",
                                color: text,
                              ),
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
                                    getText(widget.objective.endDate),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: (widget.objective.endDate
                                                    .isBefore(DateTime.now()) &&
                                                widget.objective.status ==
                                                    ObjectiveStatus.inProgress)
                                            ? lightRed
                                            : text,
                                        fontSize: 12,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w600),
                                  )),
                                  Visibility(
                                      visible: (widget.objective.endDate
                                              .isBefore(DateTime.now()) &&
                                          widget.objective.status ==
                                              ObjectiveStatus.inProgress),
                                      child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Tooltip(
                                                preferBelow: false,
                                                verticalOffset: 15,
                                                message: "En retard",
                                                decoration: BoxDecoration(
                                                    color: lightRed,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                2))),
                                                child: Icon(
                                                  Icons.warning_rounded,
                                                  color: lightRed,
                                                  size: 15,
                                                ))
                                          ]))
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
                                      picture: widget.objective.user.avatar,
                                      name: widget.objective.user.name,
                                    )),
                                SizedBox(
                                  width: 15,
                                ),
                                Flexible(
                                    child: Text(widget.objective.user.name,
                                        overflow: TextOverflow.ellipsis,
                                        style: textStyle_Text_12_600)),
                              ],
                            ),
                            flex: 4,
                          ),
                          Expanded(
                            child: Container(
                                child: Row(children: [
                              PriorityIcon(
                                priority: widget.objective.priority,
                              )
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
                                          status: widget.objective.status,
                                          date: getText(
                                              widget.objective.endDate)))
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
                              children: [
                                Expanded(child: Container()),
                                CustomIconButton(
                                    icon: Icons.delete_forever_rounded,
                                    message: 'Supprimer',
                                    color: Colors.redAccent,
                                    onTap: () {
                                      deleteDialogBox(
                                          context,
                                          () => _controller
                                              .reverse()
                                              .whenComplete(() => bloc
                                                  .remove(widget.objective)),
                                          DeleteType.objective,
                                          widget.objective.name);
                                    }),
                                Row(mainAxisSize: MainAxisSize.min, children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  CustomIconButton(
                                      icon: Icons.add_circle_rounded,
                                      message: 'Ajouter un indicateur',
                                      color: active,
                                      onTap: () {
                                        createIndicatorDialogBox(
                                            context, widget.objective);
                                      }),
                                ]),
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
                  Divider(
                    height: 1,
                    color: dividerColor,
                  ),
                  Visibility(
                    visible: widget.objective.indicators.isNotEmpty,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IndicatorsListHeader(),
                        Divider(
                          height: 1,
                          color: dividerColor,
                        ),
                      ],
                    ),
                  ),
                  IndicatorsList(
                    parentContext: context,
                    objective: widget.objective,
                  ),
                  Visibility(
                    visible: !widget.isLast,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 40,
                        ),
                        Divider(
                          height: 1,
                          color: dividerColor,
                        ),
                      ],
                    ),
                  ),
                ]))));
  }
}

class IndicatorsList extends StatefulWidget {
  final BuildContext parentContext;
  final Objective objective;

  const IndicatorsList(
      {Key? key, required this.parentContext, required this.objective})
      : super(key: key);

  @override
  _IndicatorsListState createState() => _IndicatorsListState();
}

class _IndicatorsListState extends State<IndicatorsList> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      controller: null,
      primary: false,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      key: ValueKey(Random.secure()),
      children: widget.objective.indicators
          .map((e) => _buildItem(widget.objective, e))
          .toList(),
    ));
  }

  Widget _buildItem(Objective objective, Indicator indicator) {
    return TestProxy(
        key: ValueKey(indicator),
        child: new IndicatorItem(
          onTap: () {},
          objective: objective,
          indicator: indicator,
        ));
  }
}

Color statusColor(ObjectiveStatus status) {
  switch (status) {
    case ObjectiveStatus.inProgress:
      return lightOrange;
    case ObjectiveStatus.achieved:
      return lightPurple;
    case ObjectiveStatus.notAchieved:
      return lightRed;
  }
}

class StatusTag extends StatelessWidget {
  final ObjectiveStatus status;
  final String date;

  const StatusTag({Key? key, required this.status, this.date = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case ObjectiveStatus.inProgress:
        return CustomTag(
          text: 'En cours',
          color: lightOrange,
        );
      case ObjectiveStatus.achieved:
        return CustomTag(text: 'Atteint', color: lightPurple, date: date);
      case ObjectiveStatus.notAchieved:
        return CustomTag(text: 'Non atteint', color: lightRed, date: date);
    }
  }
}

class IndicatorsListHeader extends StatelessWidget {
  const IndicatorsListHeader({Key? key}) : super(key: key);

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

class IndicatorsNumber extends StatefulWidget {
  final int indicators;
  final int measures;

  const IndicatorsNumber({Key? key, this.indicators = 0, this.measures = 0})
      : super(key: key);

  @override
  _IndicatorsNumberState createState() => _IndicatorsNumberState();
}

class _IndicatorsNumberState extends State<IndicatorsNumber> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(3),
                topRight: Radius.circular(0),
                bottomLeft: Radius.circular(3),
                bottomRight: Radius.circular(0),
              ),
              color: text,
            ),
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            child: Text(
              widget.indicators.toString(),
              style: TextStyle(
                  color: white,
                  fontSize: 12,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w500),
            )),
        SizedBox(
          width: 1,
        ),
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(3),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(3),
              ),
              color: text,
            ),
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            child: Text(
              widget.measures.toString(),
              style: TextStyle(
                  color: white,
                  fontSize: 12,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w500),
            ))
      ],
    ));
  }
}
