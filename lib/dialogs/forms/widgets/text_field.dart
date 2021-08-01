import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';

class FormTextField extends StatefulWidget {
  final Function(String value) seText;
  final String initText;

  const FormTextField({Key? key, required this.seText, this.initText = ''})
      : super(key: key);

  @override
  _FormTextFieldState createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField>
    with AutomaticKeepAliveClientMixin<FormTextField> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      height: 40,
      child: TextFormField(
        initialValue: widget.initText,
        cursorWidth: 1.5,
        decoration: InputDecoration(
            isDense: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(3)),
              borderSide: BorderSide(color: text.withAlpha(50), width: 1.2),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(3)),
              borderSide: const BorderSide(color: active, width: 1.2),
            )),
        style:
            TextStyle(color: text, fontSize: 13, fontWeight: FontWeight.w500),
        maxLines: 1,
        onChanged: (value) {
          widget.seText(value);
        },
      ),
    );
  }
}
