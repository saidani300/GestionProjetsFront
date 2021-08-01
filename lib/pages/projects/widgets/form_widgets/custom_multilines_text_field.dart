import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';

class MultiLinesTextFieldWidget extends StatefulWidget {
  final Function(String value) onChange;
  final String? hintText;

  MultiLinesTextFieldWidget({
    Key? key,
    required this.onChange,
    this.hintText,
  }) : super(key: key);

  @override
  _MultiLinesTextFieldWidgetState createState() =>
      _MultiLinesTextFieldWidgetState();
}

class _MultiLinesTextFieldWidgetState extends State<MultiLinesTextFieldWidget>
    with AutomaticKeepAliveClientMixin<MultiLinesTextFieldWidget> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final styleHint = TextStyle(fontSize: 12, fontWeight: FontWeight.w500);
    return Container(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: TextField(
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
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  borderSide: BorderSide(width: 1.2, color: text.withAlpha(50)),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  borderSide: BorderSide(width: 1.2, color: text.withAlpha(50)),
                ),
                hintStyle: styleHint,
                hintText: widget.hintText,
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  borderSide: const BorderSide(color: active, width: 1.2),
                )),
            style: textStyle_Text_13_500,
            onChanged: (value) {
              widget.onChange(value);
            },
          ),
        )
      ],
    ));
  }
}
