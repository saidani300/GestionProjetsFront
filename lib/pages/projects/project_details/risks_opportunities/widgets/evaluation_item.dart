import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/event_bloc.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/dialogs/dialogs.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/data/evaluation.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/data/event.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/routing/routes.dart';
import 'package:gestion_projets/services/navigation_service.dart';
import 'package:gestion_projets/widgets/custom_tag.dart';
import 'package:gestion_projets/widgets/profile_avatar.dart';
import 'package:intl/intl.dart';

import '../../../../../locator.dart';

class EvaluationItem extends StatefulWidget {
  final VoidCallback onTap;
  final Evaluation evaluation;
  final Event event;

  const EvaluationItem(
      {Key? key,
      required this.evaluation,
      required this.event,
      required this.onTap})
      : super(key: key);

  @override
  _EvaluationItemState createState() => _EvaluationItemState();
}

class _EvaluationItemState extends State<EvaluationItem>
    with
        AutomaticKeepAliveClientMixin<EvaluationItem>,
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
                      locator<NavigationService>().eventNavigateTo(
                          evaluationCalculationsPageRoute, widget.evaluation);
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
                                    child: AutoSizeText(
                                      widget.evaluation.name,
                                      maxLines: 1,
                                      style: textStyle_Text_12_600,
                                      overflowReplacement: Row(
                                        children: [
                                          Flexible(
                                            child: Tooltip(
                                                message: widget.evaluation.name,
                                                child: Text(
                                                    widget.evaluation.name,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        textStyle_Text_12_600)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
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
                                letterSpacing: 2,
                                text: widget.evaluation.formula.formula,
                                color: text,
                                date: widget.evaluation.formula.name,
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
                                text: widget.evaluation.minValue.toString(),
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
                                text: widget.evaluation.maxValue.toString(),
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
                                text: widget.evaluation.calculations.length
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
                                          getText(
                                              widget.evaluation.creationDate),
                                          overflow: TextOverflow.ellipsis,
                                          style: textStyle_Text_12_600)),
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
                                      picture: widget.evaluation.user.avatar,
                                      name: widget.evaluation.user.name,
                                    )),
                                SizedBox(
                                  width: 15,
                                ),
                                Flexible(
                                    child: Text(widget.evaluation.user.name,
                                        overflow: TextOverflow.ellipsis,
                                        style: textStyle_Text_12_600)),
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
                                              .whenComplete(() =>
                                                  bloc.removeEvaluation(
                                                      widget.event,
                                                      widget.evaluation)),
                                          DeleteType.evaluation,
                                          widget.evaluation.name);
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
