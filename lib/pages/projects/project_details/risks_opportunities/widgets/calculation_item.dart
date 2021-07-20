import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/bloc_provider.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/event_bloc.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/data/calculation.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/data/evaluation.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/data/event.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/widgets/custom_tag.dart';
import 'package:gestion_projets/widgets/profile_avatar.dart';
import 'package:intl/intl.dart';

class CalculationItem extends StatefulWidget {
  final VoidCallback onTap;
  final Calculation calculation;
  final Evaluation evaluation;

  const CalculationItem(
      {Key? key,
      required this.calculation,
      required this.evaluation,
      required this.onTap})
      : super(key: key);

  @override
  _CalculationItemState createState() => _CalculationItemState();
}

class _CalculationItemState extends State<CalculationItem>
    with
        AutomaticKeepAliveClientMixin<CalculationItem>,
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
                                    getText(widget.calculation.creationDate),
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
                              children: widget.calculation.criteria
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
                                              Row(children: [
                                                CustomTag(
                                                  text: e.value.toString(),
                                                  color: e.value == 1
                                                      ? lightBlue
                                                      : e.value == 2
                                                          ? lightOrange
                                                          : lightRed,
                                                ),
                                              ])
                                            ],
                                          ),
                                        ],
                                      ),
                                      flex: 2,
                                    ),
                                  )
                                  .toList(),
                            )),
                            flex: 2 * widget.calculation.criteria.length,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                                child: Row(children: [
                              CustomTag(
                                text: widget.calculation.score.toString(),
                                color: ValueToColor(widget.calculation.score),
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
                                    getText(widget.calculation.startDate),
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
                                    getText(widget.calculation.endDate),
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
                              children: [
                                Expanded(child: Container()),
                                CustomIconButton(
                                    icon: Icons.delete_forever_rounded,
                                    message: 'Supprimer',
                                    color: Colors.redAccent,
                                    onTap: () {
                                      _controller.reverse().whenComplete(() =>
                                          bloc.removeCalculation(
                                              widget.evaluation,
                                              widget.calculation));
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

Color ValueToColor(double value) {
  if (value >= 0 && value < 6) return lightBlue;
  if (value > 5 && value < 13)
    return lightOrange;
  else
    return lightRed;
}
