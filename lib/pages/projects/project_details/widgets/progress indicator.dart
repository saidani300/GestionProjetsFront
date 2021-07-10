import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';

class Progress extends StatefulWidget {
  final int completed;
  final int inProgress;
  const Progress(
      {Key? key, required this.completed, required this.inProgress})
      : super(key: key);

  @override
  _ProgressState createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4,
      width: 50,
      child: Row(
        children: [
      Visibility(visible: widget.completed !=0 , child:
          Expanded(
            child: Container(
              child: Row(
                children: [
                  Expanded(child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: widget.inProgress==0 ? Radius.circular(5) : Radius.circular(0),
                          bottomLeft:
                          Radius.circular(5),
                          bottomRight:
                          widget.inProgress==0 ? Radius.circular(5) : Radius.circular(0)),
                      color: Color(0xFF0AC1EC),
                    ),
                  ))
                ],
              ),
            ),
            flex: widget.completed,
          )),
          Visibility(visible: (widget.inProgress !=0 || widget.completed !=0),child: SizedBox(width: 1,)),
          Visibility(visible: widget.inProgress !=0 , child:
          Expanded(
            child: Container(
              child: Row(
                children: [
                  Expanded(child:
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: widget.completed==0 ? Radius.circular(5) : Radius.circular(0),
                          topRight:  Radius.circular(5),
                          bottomLeft:
                          widget.completed==0 ? Radius.circular(5) : Radius.circular(0),
                          bottomRight:
                          Radius.circular(5)),
                      color: Color(0xFFFFA800),
                    ),
                  ))
                ],
              ),
            ),
            flex: widget.inProgress,
          )),
          Visibility(visible: widget.completed ==0 &&  widget.inProgress ==0 , child:
          Expanded(
            child: Container(
              child: Row(
                children: [
                  Expanded(child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5)),
                      color: text.withOpacity(0.2),
                    ),
                  ))
                ],
              ),
            ),
            flex: 1,
          )),
          
        ],
      ),
    );
  }
}
