import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/bloc_provider.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/objective_bloc.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/data/indicator.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/data/objective.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/routing/routes.dart';
import 'package:gestion_projets/services/navigation_service.dart';
import 'package:gestion_projets/widgets/custom_tag.dart';
import 'package:gestion_projets/widgets/profile_avatar.dart';
import 'package:intl/intl.dart';

import '../../../../../locator.dart';

class IndicatorItem extends StatefulWidget {
  final VoidCallback onTap;
  final Indicator indicator;
  final Objective objective;
  const IndicatorItem(
      {Key? key,
        required this.indicator,
        required this.objective,
        required this.onTap})
      : super(key: key);

  @override
  _IndicatorItemState createState() => _IndicatorItemState();
}

class _IndicatorItemState extends State<IndicatorItem>   with AutomaticKeepAliveClientMixin<IndicatorItem> ,TickerProviderStateMixin {


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
    final bloc = BlocProvider.of<ObjectiveBloc>(context);
    super.build(context);

    return FadeTransition(
        opacity: _animation,
        child: SizeTransition(
            sizeFactor: _animation,
            child: Material(
                color: Colors.transparent,
                child:Column(children: [

                  InkWell(
                    hoverColor: active.withOpacity(0.015),
                    onTap: () {
                      print("tapped");
                      locator<NavigationService>().projectDetailsNavigateTo(indicatorPageRoute);
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
                            flex: 8,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container( child :
                            Row( children :[ CustomTag(
                              text: widget.indicator.minValue.toString() + " " + widget.indicator.unit,
                              color: lightOrange,
                            )])
                            ),
                            flex: 3,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container( child :
                            Row(
                              children: [
                                CustomTag(
                                  text: widget.indicator.maxValue.toString() + " " + widget.indicator.unit,
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
                            child: Container( child :
                            Row(
                              children: [
                                CustomTag(
                                  text: widget.indicator.criticalThreshold.toString() + " " + widget.indicator.unit,
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
                                      widget.indicator.autoMeasure ? "Automatique :"
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
                          Container(width: 40, child: Row(mainAxisSize: MainAxisSize.min,children: [
                            Expanded(child: Container()),
                            CustomIconButton(
                                icon: Icons.delete_forever_rounded,
                                message: 'Supprimer',
                                color: Colors.redAccent,
                                onTap: () {
                                  _controller.reverse().whenComplete(() => bloc.removeIndicator(widget.objective , widget.indicator));
                                  //showDialogBox(context, onTap);
                                }),
                          ],),),

                          SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: dark.withOpacity(0.15),
                  ),
                ]))));
  }
}

String indicatorFrequencyAsText(Frequency frequency)
{
  switch(frequency) {
    case Frequency.monthly :
      return 'Mensuel';
    case Frequency.quarterly :
      return 'Trimestriel';
    case Frequency.semiAnnually :
      return 'Semestriel';
    case Frequency.annually :
      return 'Annuel';
  }
}