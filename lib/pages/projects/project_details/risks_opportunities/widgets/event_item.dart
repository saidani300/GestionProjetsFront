import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/bloc_provider.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/event_bloc.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/data/indicator.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/data/objective.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/body/project_overview_body.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data/phase.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data/user.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/data/event.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/change_status_button.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/routing/routes.dart';
import 'package:gestion_projets/services/navigation_service.dart';
import 'package:gestion_projets/widgets/custom_tag.dart';
import 'package:gestion_projets/widgets/priority_icon.dart';
import 'package:gestion_projets/widgets/profile_avatar.dart';
import 'package:intl/intl.dart';

import '../../../../../locator.dart';

class EventItem extends StatefulWidget {
  final VoidCallback onTap;
  final Event event;

  const EventItem({Key? key, required this.event, required this.onTap})
      : super(key: key);

  @override
  _EventItemState createState() => _EventItemState();
}

class _EventItemState extends State<EventItem>
    with AutomaticKeepAliveClientMixin<EventItem>, TickerProviderStateMixin {
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
    print("Disposed " + widget.hashCode.toString());
    _controller.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<EventBloc>(context);
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
                    onTap: () {
                      print("tapped");
                      locator<NavigationService>()
                          .eventNavigateTo(eventEvaluationsPageRoute);
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
                              color: TypeColor(widget.event.eventType),
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
                                    widget.event.eventType ==
                                            EventType.Opportunity
                                        ? "icons/up-arrow.svg"
                                        : "icons/down-arrow.svg",
                                    color: widget.event.eventType ==
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
                                    widget.event.name,
                                    overflow: TextOverflow.ellipsis,
                                    style: textStyle_Text_12_600
                                  )),
                                  SizedBox(width: 5),
                                  Visibility(
                                      visible:
                                          widget.event.documents.isNotEmpty,
                                      child: CustomIconButton(
                                        icon: Icons.attach_file_rounded,
                                        message:
                                            "${widget.event.documents.length.toString()} Attachement",
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
                                    widget.event.impact,
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
                                    widget.event.source,
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
                                text:
                                    widget.event.evaluations.length.toString() +
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
                                    getText(widget.event.identificationDate),
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
                                      picture: widget.event.user.avatar,
                                      name: widget.event.user.name,
                                    )),
                                SizedBox(
                                  width: 15,
                                ),
                                Flexible(
                                    child: Text(
                                  widget.event.user.name,
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
                                    level: widget.event.level,
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
                              children: [
                                Expanded(child: Container()),
                                CustomIconButton(
                                    icon: Icons.delete_forever_rounded,
                                    message: 'Supprimer',
                                    color: Colors.redAccent,
                                    onTap: () {
                                      _controller.reverse().whenComplete(
                                          () => bloc.remove(widget.event));
                                      //showDialogBox(context, onTap);
                                    }),
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
                  // Container(height: 60,)
                ]))));
  }
}

Color TypeColor(EventType type) {
  switch (type) {
    case EventType.Risk:
      return lightRed;
    case EventType.Opportunity:
      return lightBlue;
  }
}

class LevelTag extends StatelessWidget {
  final EventLevel level;

  const LevelTag({Key? key, required this.level}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (level) {
      case EventLevel.low:
        return CustomTag(text: '1', color: lightBlue);
      case EventLevel.medium:
        return CustomTag(text: '2', color: lightOrange);
      case EventLevel.high:
        return CustomTag(text: '3', color: lightRed);
    }
  }
}
