import 'package:flutter/material.dart';
import 'package:gestion_projets/widgets/custom_outlined_button.dart';
import 'package:intl/intl.dart';

class DatePickerWidget extends StatefulWidget {
  late DateTime date;

  DatePickerWidget({Key? key,required this.date}) : super(key: key);
  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {


  String getText() => DateFormat.yMMMMd('fr_FR').format(widget.date);

  @override
  Widget build(BuildContext context) => CustomOutlinedButton(buttonText: getText(), icon: Icons.date_range_rounded, onTap: () { pickDate(context); },);

  Future pickDate(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: widget.date,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (newDate == null) return;
    setState(() => widget.date = newDate);
  }
}
