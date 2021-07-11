import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/progress%20indicator.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/pages/projects/widgets/project_item.dart';
import 'package:gestion_projets/widgets/profile_avatar.dart';

import 'change_status_button.dart';
import 'open_close_animated_arrow.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({Key? key}) : super(key: key);

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool isCompleted = false;
  bool isExpanded = false;
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(horizontal: 0) ,child : Container(
      height: 60,
      child: InkWell(
          onTap: () {
            print("tapped");
          },
          onHover: (value) {
            value
                ? setState(() {
              isHover = true;
            })
                : setState(() {
              isHover = false;
            });
          },
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          child: Row(
            children: [
              Container(
                      width:
                      25,
                      ),
              Expanded(
                  child: Container(
                    height: 60,
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(

                              child: Row(
                                children: [
                                  DottedLine(
                                    direction: Axis.vertical,
                                    lineLength: double.infinity,
                                    lineThickness: 1.0,
                                    dashLength: 2,
                                    dashColor: text.withOpacity(0.3),
                                    dashRadius: 0.0,
                                    dashGapLength: 2,
                                    dashGapColor: Colors.transparent,
                                    dashGapRadius: 0.0,
                                  ),
                                  Container(width: 29,),
                                  Padding(padding: EdgeInsets.symmetric(vertical: 2) , child: Container(
                                    width: 2,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      color: Color(0xFF0AC1EC),
                                  ))),
                                  Container(width: 20,),
                                  ChangeStatusButton(onTap: () { isCompleted ?
                                  setState(() {
                                    isCompleted = false;
                                  }) : setState(() {
                                    isCompleted = true;
                                  }) ;},
                                    completedColor: Colors.lightGreen,
                                    inProgressColor: text.withOpacity(0.3),
                                    isCompleted: isCompleted,),
                                  SizedBox(width: 10),
                                  Flexible( child : Text(
                                    "Créer un nouveau plan marketing",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: text,
                                        fontSize: 12,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w600),
                                  )),
                                  SizedBox(width: 5),
                                  CustomIconButton(icon: Icons.attach_file_rounded, message: "1 Attachement", onTap: (){}, size: 15,),
                                  /* SizedBox(width: 5),
                    Icon(Icons.swap_vertical_circle_outlined , color: Colors.orangeAccent, size: 16,)*/
                                ],
                              )),
                          flex: 4,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Container(
                              child: Row(children: [
                                Flexible( child : Text(
                                  "10 juillet 2021",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: text,
                                      fontSize: 12,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w600),
                                )),
                                // Expanded(child: Container()),
                              ])),
                          flex: 1,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Container(
                              child: Row(children: [
                                Avatar(name: "Saidani Wael", picture: "3" , size: 25,),
                                SizedBox(width: 10,),
                                Flexible( child : Text(
                                  "Saidani Wael",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: text,
                                      fontSize: 12,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w600),
                                )),
                                // Expanded(child: Container()),
                              ])),
                          flex: 2,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Container(
                              child: Row(children: [
                                Tooltip(message: "Normale" ,child: Icon(Icons.flag_rounded , size: 18, color: active,)),
                                /*SizedBox(width: 6.5,),
                      Text(
                        "Normale",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: active,
                            fontSize: 12,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w600),
                      ),*/
                                //  Expanded(child: Container()),
                              ])),
                          flex: 1,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Container(
                              child: Row(children: [
                                StatusLabel(status: statusType.Completed,),
                                // Expanded(child: Container()),
                              ])),
                          flex: 1,
                        ),
                        Expanded(
                          child: Container(
                              child: Row(children: [
                                Expanded(child: Container()),
                                ActionsMenu(),
                              ])),
                          flex: 1,
                        ),
                      ],
                    ),)),

            ],
          )),
    ));
  }
}


class ActionButton extends StatefulWidget {
  final Color color;
  final IconData icon;
  final double topLeftRadius;
  final double bottomLeftRadius;
  final String message;
  final double size;
  const ActionButton(
      {Key? key,
        required this.color,
        required this.icon,
        this.topLeftRadius = 0,
        this.bottomLeftRadius = 0,
        required this.message, this.size = 0})
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
                height: (widget.size !=0) ? widget.size : null,
                width: (widget.size !=0) ? widget.size : null,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(widget.topLeftRadius),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(widget.bottomLeftRadius),
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


class ActionsMenu extends StatelessWidget {
  const ActionsMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          textTheme: TextTheme(),
          hoverColor: active.withOpacity(0.03),
          dividerTheme: DividerThemeData(
            thickness: 0.5,
            space: 0,),
          tooltipTheme: TooltipThemeData(
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
          )),
      child: PopupMenuButton<Object>(
          offset: Offset(-10, 30),
          padding: EdgeInsets.symmetric(vertical: 0),
          tooltip: "",
          icon: Icon(
            Icons.more_horiz_rounded,
            size: 25,
            color: text.withOpacity(0.5),
          ),
          // child: CustomIconButton(icon: Icons.more_vert_rounded, message: 'Actions'),
          onSelected: (selectedValue) {
            // print(selectedValue);
          },
          itemBuilder: (context) => [
            PopupMenuItem(
                height: 35,
                child: Row(children: [
                  Icon(
                    Icons.add_circle_rounded,
                    size: 18,
                    color: active,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Ajouter une tâche',
                    style: TextStyle(
                      color: text,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  )
                ]),
                value: 1),
            PopupMenuItem(
                height: 35,
                child: Row(children: [
                  Icon(
                    Icons.edit,
                    size: 18,
                    color: text,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Modifier',
                    style: TextStyle(
                      color: text,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  )
                ]),
                value: 1),
            PopupMenuDivider(
              height: 1,
            ),
            PopupMenuItem(
                height: 35,
                child: Row(children: [
                  Icon(
                    Icons.delete_rounded,
                    size: 18,
                    color: lightRed,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Supprimer',
                    style: TextStyle(
                      color: lightRed,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  )
                ]),
                value: 2),
          ]),
    );
  }
}