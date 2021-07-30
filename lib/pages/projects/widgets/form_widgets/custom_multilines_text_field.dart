
import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';

import '../project_item.dart';


class MultiLinesTextFieldWidget extends StatefulWidget {
final  Function(String value) onChange;
final String? hintText;
  final TextEditingController descriptionController;
   MultiLinesTextFieldWidget({
    Key? key,
     required this.onChange,
    this.hintText,
    required this.descriptionController,
  }) : super(key: key);

  @override
  _MultiLinesTextFieldWidgetState createState() =>
      _MultiLinesTextFieldWidgetState();
}

class _MultiLinesTextFieldWidgetState extends State<MultiLinesTextFieldWidget> {

  @override
  Widget build(BuildContext context) {

    final styleHint =
        TextStyle(fontSize: 12, fontWeight: FontWeight.w500);
    return Container(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: TextField(
            controller: widget.descriptionController,
            scrollPadding: EdgeInsets.all(0),
            expands: false,
            textAlignVertical: TextAlignVertical.top,
            textCapitalization: TextCapitalization.sentences,
            maxLines: 5,
            cursorWidth: 1.5,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.all(12),
              enabledBorder: OutlineInputBorder(
                borderRadius:BorderRadius.all(Radius.circular(3)),
                borderSide: BorderSide(width: 1.2 , color: text.withAlpha(50)),
              ),
              border: OutlineInputBorder(
                borderRadius:BorderRadius.all(Radius.circular(3)),
                borderSide: BorderSide(width: 1.2 , color: text.withAlpha(50)),
              ),
              hintStyle: styleHint,
              hintText: widget.hintText,
                focusedBorder: const OutlineInputBorder(
                  borderRadius:BorderRadius.all(Radius.circular(3)),
                  borderSide: const BorderSide(
                      color: active, width: 1.2),
                )
            ),
            style: textStyle_Text_13_500,
              onChanged: (value)
            {
              widget.onChange(value);
            },
          ),
        )
      ],
    ));
  }
}
