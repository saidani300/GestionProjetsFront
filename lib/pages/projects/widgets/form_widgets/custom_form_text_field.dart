import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';

class TextFieldWidget extends StatefulWidget {
  final String text;
  final double width;
  final double height;

  const TextFieldWidget({
    Key? key,
    required this.text,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final styleActive =
        TextStyle(color: text, fontSize: 13, fontWeight: FontWeight.w500);
    return Container(
      width: widget.width,
      height: widget.height,
      child: TextFormField(
        cursorWidth: 1.5,
        controller: controller,
        decoration: InputDecoration(
          isDense: true,
          border: OutlineInputBorder(),
        ),
        style:
            TextStyle(color: text, fontSize: 13, fontWeight: FontWeight.w500),
        maxLines: 1,
        //  onChanged: widget.onChanged,
      ),
    );
  }
}
