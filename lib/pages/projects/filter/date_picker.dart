import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:intl/intl.dart';

class DatePickerWidget extends StatefulWidget {
  final double width;

  final String dateAsText;
  final double height;
  final Function() onTap;

  DatePickerWidget(
      {Key? key,
      required this.height,
      required this.width,
      required this.onTap,
      required this.dateAsText})
      : super(key: key);

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

bool isHover = false;

class _DatePickerWidgetState extends State<DatePickerWidget> {
  @override
  Widget build(BuildContext context) => InkWell(
      enableFeedback: false,
      canRequestFocus: false,
      excludeFromSemantics: true,
      onTap: widget.onTap,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onHover: (value) {
        value
            ? setState(() {
                isHover = true;
              })
            : setState(() {
                isHover = false;
              });
      },
      child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
                color: isHover ? active : text.withOpacity(0.35), width: 1.4),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                      child: Text(
                        widget.dateAsText,
                        style: TextStyle(
                            color: text,
                            fontSize: 12.5,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w500),
                      ))),
              Container(
                  width: 34,
                  child: Icon(
                    Icons.date_range_rounded,
                    color: active,
                    size: 18,
                  )),
            ],
          )));
}
