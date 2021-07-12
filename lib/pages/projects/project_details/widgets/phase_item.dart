import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/Data/items.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data_layer/phase.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/open_close_animated_arrow.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';

import 'action_item.dart';

class PhaseItem extends StatefulWidget {
  final Phase phase;
  const PhaseItem({Key? key , required this.phase}) : super(key: key);

  @override
  _PhaseItemState createState() => _PhaseItemState();
}

class _PhaseItemState extends State<PhaseItem> {
  bool isExpanded = false;
  bool actionsVisible = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 30,
          ),
          Container(
              child: Row(
            children: [
              SizedBox(width: 20),
              Expanded(
                  child: Container(
                child: Row(
                  children: [
                    OpenCloseArrowButton(
                      onTap: () { isExpanded ?
                      setState(() {
                        isExpanded = false;
                      }) : setState(() {
                        isExpanded = true;
                      }) ;},
                      color: active,
                      isExpanded: isExpanded,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        child: InkWell(
                            onTap: () {
                              print("tapped");

                            },
                            onHover: (value) {
                              value
                                  ? setState(() {
                                      actionsVisible = true;
                                    })
                                  : setState(() {
                                      actionsVisible = false;
                                    });
                            },
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: Container(
                                child: Column(children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(3),
                                                  topRight: actionsVisible
                                                      ? Radius.circular(0)
                                                      : Radius.circular(3),
                                                  bottomLeft:
                                                      Radius.circular(0),
                                                  bottomRight:
                                                      Radius.circular(0)),
                                              color: active/*Color(0xFF08ADFF)*/,
                                            ),
                                            child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 6,
                                                    horizontal: 15),
                                                child: Text(
                                                  widget.phase.name,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 11,
                                                      letterSpacing: 0,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  //  textAlign: TextAlign.center,
                                                ))),

                                        //Actions Buttons
                                        Visibility(
                                            maintainSize: true,
                                            maintainAnimation: true,
                                            maintainState: true,
                                            visible: actionsVisible,
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 1,
                                                  ),
                                                  ActionButton(
                                                      color: text,
                                                      icon: Icons.edit,
                                                    message: 'Modifier',
                                                  ),
                                                  SizedBox(
                                                    width: 1,
                                                  ),
                                                  ActionButton(
                                                    color: lightRed,
                                                    icon: Icons.delete,
                                                    topRightRadius: 3,
                                                    message: 'Supprimer',
                                                  ),
                                                 /* SizedBox(
                                                    width: 20,
                                                  ),
                                                  Text("3 Actions | 10 Tâches",
                                                    style: TextStyle(
                                                        color: text.withOpacity(0.7),
                                                        fontSize: 11,
                                                        letterSpacing: 0,
                                                        fontWeight:
                                                        FontWeight.w500),)*/
                                                ])),
                                        Expanded(child: Container())
                                      ],
                                    ),
                                    flex: 4,
                                  ),


                                  SizedBox(
                                    width: 15,
                                  ),
                                  CustomIconButton(
                                    icon: Icons.add_circle_rounded,
                                    message: "",
                                    enableToolTip: false,
                                    onTap: () {/*TODO : Create Add Action Logic in BLoC*/},
                                    size: 23,
                                  ),
                                  SizedBox( width: 1,)
                                ],
                              ),
                           //   SizedBox(height: 1,),
                              DottedLine(
                                direction: Axis.horizontal,
                                lineLength: double.infinity,
                                lineThickness: 1.0,
                                dashLength: 2,
                                dashColor: text.withOpacity(0.3),
                                dashRadius: 0.0,
                                dashGapLength: 2,
                                dashGapColor: Colors.transparent,
                                dashGapRadius: 0.0,
                              )
                            ]))))
                  ],
                ),
              )),
              SizedBox(width: 20),
            ],
          )),

          SizedBox(height: 1,),
          AnimatedCrossFade(
            firstCurve: Curves.easeIn,
            secondCurve: Curves.easeOut,
            firstChild: Container(),
            secondChild:Container(
              child : ListView(
              shrinkWrap: true,
              children:
                widget.phase.actions.map((e) => ActionItem(action: e,)).toList()
            ),),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: Duration(milliseconds: 200),
          ),

          SizedBox(height: 1,),
          Container(
            //height: 40,
            child: Padding(padding: EdgeInsets.symmetric(horizontal: 45),
            child: Row(children: [
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight:  Radius.circular(0),
                        bottomLeft:
                        Radius.circular(3),
                        bottomRight:
                        Radius.circular(0)),
                    color: active.withOpacity(0.05),
                  ),
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 15),
                      child: Text(
                        "4 Actions",
                        style: TextStyle(
                            color: text,
                            fontSize: 11,
                            letterSpacing: 0,
                            fontWeight:
                            FontWeight.w500),
                        //  textAlign: TextAlign.center,
                      ))),
              SizedBox(width: 1,),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight:  Radius.circular(0),
                        bottomLeft:
                        Radius.circular(0),
                        bottomRight:
                        Radius.circular(3)),
                    color: active.withOpacity(0.05),
                  ),
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 15),
                      child: Text(
                        "10 Tâches",
                        style: TextStyle(
                            color: text,
                            fontSize: 11,
                            letterSpacing: 0,
                            fontWeight:
                            FontWeight.w500),
                        //  textAlign: TextAlign.center,
                      ))),
              Expanded(child: Container())
            ],),
            ),
          ),
        ],
      ),
    );
  }
}

class ActionButton extends StatefulWidget {
  final Color color;
  final IconData icon;
  final double topRightRadius;
  final String message;
  const ActionButton(
      {Key? key,
      required this.color,
      required this.icon,
      this.topRightRadius = 0,
      required this.message})
      : super(key: key);

  @override
  _ActionButtonState createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  late Color onHoverColor;

  @override
  initState() {
    onHoverColor = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
        message: widget.message,
        preferBelow: false,
        child: InkWell(
            onTap: () {
              print("ActionButton tapped");
            },
            onHover: (value) {
              value
                  ? setState(() {
                      onHoverColor = widget.color.withAlpha(230);
                    })
                  : setState(() {
                      onHoverColor = widget.color;
                    });
            },
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(widget.topRightRadius),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0)),
                  color: onHoverColor,
                ),
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                    child: Icon(
                      widget.icon,
                      size: 13,
                      color: Colors.white,
                    )))));
  }
}
