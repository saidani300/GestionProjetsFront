import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/dialogs/dialogs.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/objective_bloc.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/data/indicator.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/data/measure.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/widgets/custom_tag.dart';
import 'package:intl/intl.dart';

class MeasureItem extends StatefulWidget {
  final VoidCallback onTap;
  final Measure measure;
  final Indicator indicator;

  const MeasureItem(
      {Key? key,
      required this.measure,
      required this.indicator,
      required this.onTap})
      : super(key: key);

  @override
  _MeasureItemState createState() => _MeasureItemState();
}

class _MeasureItemState extends State<MeasureItem>
    with AutomaticKeepAliveClientMixin<MeasureItem>, TickerProviderStateMixin {
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
    TextStyle style = TextStyle(
        color: text,
        fontSize: 12,
        letterSpacing: 0,
        fontWeight: FontWeight.w600);
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
                              color: widget.measure.value <
                                      widget.indicator.criticalThreshold
                                  ? lightRed
                                  : lightBlue,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                                child: Row(children: [
                              CustomTag(
                                text: widget.measure.value.toStringAsFixed(1) +
                                    " " +
                                    widget.indicator.unit,
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
                                  CustomTag(
                                    text: widget.indicator.maxValue
                                            .toStringAsFixed(1) +
                                        " " +
                                        widget.indicator.unit,
                                    color: lightBlue,
                                  ),
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
                                CustomTag(
                                  text: (widget.measure.value -
                                              widget
                                                  .indicator.criticalThreshold)
                                          .toStringAsFixed(1) +
                                      " " +
                                      widget.indicator.unit,
                                  color: widget.measure.value <
                                          widget.indicator.criticalThreshold
                                      ? lightRed
                                      : lightBlue,
                                ),
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
                                getText(widget.measure.startDate),
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
                                getText(widget.measure.endDate),
                                overflow: TextOverflow.ellipsis,
                                style: style,
                              )),
                            ]),
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
                                          widget.measure.comment.isEmpty
                                              ? "Pas de commentaire"
                                              : widget.measure.comment,
                                          overflow: TextOverflow.ellipsis,
                                          style: widget.measure.comment.isEmpty
                                              ? textStyle_Text_11_500
                                              : textStyle_Text_12_600)),
                                ],
                              ),
                            ),
                            flex: 2,
                          ),

                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Row(children: [
                              Tooltip(
                                  message: widget.measure.value <
                                          widget.indicator.criticalThreshold
                                      ? "Mauvaise"
                                      : "Bonne",
                                  decoration: BoxDecoration(
                                    color: widget.measure.value <
                                            widget.indicator.criticalThreshold
                                        ? lightRed
                                        : lightBlue,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(2)),
                                  ),
                                  child: Icon(
                                    widget.measure.value <
                                            widget.indicator.criticalThreshold
                                        ? Icons.thumb_down_alt_rounded
                                        : Icons.thumb_up_alt_rounded,
                                    color: widget.measure.value <
                                            widget.indicator.criticalThreshold
                                        ? lightRed
                                        : lightBlue,
                                    size: 18,
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
                                      deleteDialogBox(
                                          context,
                                          () => _controller
                                              .reverse()
                                              .whenComplete(() =>
                                                  bloc.removeMeasure(
                                                      widget.indicator,
                                                      widget.measure)),
                                          DeleteType.measure,
                                          "La mesure entre " +
                                              getText(
                                                  widget.measure.startDate) +
                                              " et " +
                                              getText(widget.measure.endDate));
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
