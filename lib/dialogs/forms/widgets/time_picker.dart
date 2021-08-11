import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';

class TimePickerWidget extends StatefulWidget {
  final Function(TimeOfDay time) setTime;
  final TimeOfDay initTime;
  final double height;

  TimePickerWidget({
    Key? key,
    required this.height,
    required this.setTime,
    required this.initTime,
  }) : super(key: key);

  @override
  _TimePickerWidgetState createState() => _TimePickerWidgetState();
}

bool isHover = false;

class _TimePickerWidgetState extends State<TimePickerWidget>
    with AutomaticKeepAliveClientMixin<TimePickerWidget> {
  late TimeOfDay time;

  @override
  void initState() {
    time = widget.initTime;
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
        onTap: () {
          FocusManager.instance.primaryFocus!.unfocus();
          pickTime(context);
        },
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
                          time.format(context),
                          style: TextStyle(
                              color: text,
                              fontSize: 12.5,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w500),
                        ))),
                Container(
                    width: 34,
                    child: Icon(
                      Icons.access_time,
                      color: active,
                      size: 18,
                    )),
              ],
            )));
  }

  Future pickTime(BuildContext context) async {
    final newTime = await showTimePicker(
      context: context,
      initialTime: time,
    );
    if (newTime == null) {
      return;
    } else {
      setState(() => time = newTime);
      widget.setTime(newTime);
    }
  }
}
