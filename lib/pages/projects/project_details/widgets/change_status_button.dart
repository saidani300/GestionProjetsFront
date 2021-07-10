import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';

class ChangeStatusButton extends StatefulWidget {
  final Function() onTap;
  final Color completedColor;
  final Color inProgressColor;
  bool isCompleted;
  ChangeStatusButton(
      {Key? key,
        required this.onTap,
        this.isCompleted = false,
        this.completedColor = active,
      this.inProgressColor = text,
      })
      : super(key: key);

  @override
  _ChangeStatusButtonState createState() => _ChangeStatusButtonState();
}

class _ChangeStatusButtonState extends State<ChangeStatusButton>{
  bool onHover = false;
 bool isCompleted = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: (){
          print("Status Changed " + widget.isCompleted.toString());

          widget.onTap();
          setState(() {
          onHover = false;
          });
         /* setState(() {
            isCompleted = widget.isCompleted;
          });*/
        },
        onHover: (value) {
          setState(() {
            value ? onHover = true : onHover = false;
          });
        },
        child: Tooltip(message: widget.isCompleted?  "Marquer comme en cours" : "Marquer comme terminé", child :Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
                border: Border.all(
                  color: onHover ? widget.isCompleted ? widget.inProgressColor : widget.completedColor : widget.isCompleted ? widget.completedColor : widget.inProgressColor,
                  width: 1.5,
                ),
                color: onHover ?  widget.isCompleted ? Colors.transparent : widget.completedColor : widget.isCompleted? widget.completedColor : Colors.transparent,
                shape: BoxShape.circle),

              child: Icon(
                Icons.check_rounded,
                size: 10,
                color: onHover ? widget.isCompleted? Colors.transparent : Colors.white : widget.isCompleted? Colors.white : Colors.transparent,
              ),
            )));
  }
}
