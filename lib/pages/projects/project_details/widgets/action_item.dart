import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/progress%20indicator.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/widgets/profile_avatar.dart';

import 'change_status_button.dart';
import 'open_close_animated_arrow.dart';

class ActionItem extends StatefulWidget {
  const ActionItem({Key? key}) : super(key: key);

  @override
  _ActionItemState createState() => _ActionItemState();
}

class _ActionItemState extends State<ActionItem> {
  bool isExpanded = false;
  bool isCompleted = false;
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(horizontal: 20) ,child : Container(
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
          Visibility(visible: isHover,
              maintainState: true,
              maintainSize: true,
              maintainAnimation: true,
              child: Container(
            width:
                25,
            child: Row( children :[OpenCloseArrowButton(
              onTap: () { isExpanded ?
              setState(() {
                isExpanded = false;
              }) : setState(() {
                isExpanded = true;
              }) ;},
              color: active,
              isExpanded: isExpanded,
            ),])
          )),
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
                   // SizedBox(width: 15,),
                    ChangeStatusButton(onTap: () { isCompleted ?
                    setState(() {
                      isCompleted = false;
                    }) : setState(() {
                      isCompleted = true;
                    }) ;},
                      completedColor: Colors.lightGreen,
                      inProgressColor: Colors.grey,
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
                      Progress(completed: 2, inProgress: 6,),
                     // Expanded(child: Container()),
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
