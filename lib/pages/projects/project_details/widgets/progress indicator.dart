import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';

int percentage(int a, int b) {
  int percentage = 0;
  if (!(a == 0 && b == 0)) percentage = (a / (a + b) * 100).round();
  return percentage;
}

class Progress extends StatelessWidget {
  final int completed;
  final int inProgress;

  const Progress({Key? key, required this.inProgress, required this.completed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(2)),
          color: text,
        ),
        padding: EdgeInsets.all(10),
        textStyle: TextStyle(
            height: 2,
            color: white,
            fontSize: 11,
            letterSpacing: 0,
            fontWeight: FontWeight.w600),
        message:
            " Tâches terminé: ${completed.toString().padLeft(2, '0')}\n Tâches en cours: ${inProgress.toString().padLeft(2, '0')}",
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(
            percentage(completed, inProgress).toString() + "%",
            style: TextStyle(
                color: text,
                fontSize: 11,
                letterSpacing: 0,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 4,
          ),
          (completed == 0 && inProgress == 0)
              ? Container(
                  height: 4,
                  width: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Color(0xFFFFA800),
                  ),
                )
              : Container(
                  height: 4,
                  width: 55,
                  child: Row(
                    children: [
                      Visibility(
                          visible: completed != 0,
                          child: Expanded(
                            child: Container(
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          topRight: inProgress == 0
                                              ? Radius.circular(5)
                                              : Radius.circular(0),
                                          bottomLeft: Radius.circular(5),
                                          bottomRight: inProgress == 0
                                              ? Radius.circular(5)
                                              : Radius.circular(0)),
                                      color: Color(0xFF0AC1EC),
                                    ),
                                  ))
                                ],
                              ),
                            ),
                            flex: completed,
                          )),
                      Visibility(
                          visible: (inProgress != 0 || completed != 0),
                          child: SizedBox(
                            width: 1,
                          )),
                      Visibility(
                          visible: inProgress != 0,
                          child: Expanded(
                            child: Container(
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: completed == 0
                                              ? Radius.circular(5)
                                              : Radius.circular(0),
                                          topRight: Radius.circular(5),
                                          bottomLeft: completed == 0
                                              ? Radius.circular(5)
                                              : Radius.circular(0),
                                          bottomRight: Radius.circular(5)),
                                      color: Color(0xFFFFA800),
                                    ),
                                  ))
                                ],
                              ),
                            ),
                            flex: inProgress,
                          )),
                      Visibility(
                          visible: completed.isNaN && inProgress.isNaN,
                          child: Expanded(
                            child: Container(
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Container(
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
                )
        ]));
  }
}
