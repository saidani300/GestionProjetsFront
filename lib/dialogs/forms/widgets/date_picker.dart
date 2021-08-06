import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:intl/intl.dart';

class DatePickerWidget extends StatefulWidget {
  final Function(DateTime date) setDate;
  final DateTime initDate;
  final double height;

  DatePickerWidget({
    Key? key,
    required this.height,
    required this.setDate,
    required this.initDate,
  }) : super(key: key);

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

bool isHover = false;

class _DatePickerWidgetState extends State<DatePickerWidget>
    with AutomaticKeepAliveClientMixin<DatePickerWidget> {
  late DateTime date;

  String getDateAsText(DateTime date) =>
      DateFormat.yMMMMd('fr_FR').format(date);

  @override
  void initState() {
    date = widget.initDate;
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return InkWell(
        enableFeedback: false,
        canRequestFocus: false,
        excludeFromSemantics: true,
        onTap: (){pickDate(context); FocusManager.instance.primaryFocus!.unfocus();},
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
                          getDateAsText(date),
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

  Future pickDate(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(DateTime.now().year - 10),
      lastDate: DateTime(DateTime.now().year + 20),
    );
    if (newDate == null) {
      return;
    } else {
      setState(() => date = newDate);
      widget.setDate(newDate);
    }
  }
}
