
import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';

import '../project_item.dart';

Color iconColor = colors[0];

class MultiLinesTextFieldWidget extends StatefulWidget {
  final String text;

  const MultiLinesTextFieldWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  _MultiLinesTextFieldWidgetState createState() =>
      _MultiLinesTextFieldWidgetState();
}

class _MultiLinesTextFieldWidgetState extends State<MultiLinesTextFieldWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final styleActive =
        TextStyle(color: text, fontSize: 13, fontWeight: FontWeight.w500);
    final styleHint =
        TextStyle(color: text, fontSize: 12.5, fontWeight: FontWeight.w500);
    return Container(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: TextFormField(
            expands: false,
            textAlignVertical: TextAlignVertical.top,
            textCapitalization: TextCapitalization.sentences,
            maxLines: 5,
            cursorWidth: 1.5,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.all(21),
              border: OutlineInputBorder(),
            ),
            style: styleActive,
            //  onChanged: widget.onChanged,
          ),
        )
      ],
    ));
  }
}
