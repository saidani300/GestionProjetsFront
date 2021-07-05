import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';

import 'custom_icon_button.dart';

class SearchWidget extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;

  const SearchWidget({
    Key? key,
    required this.text,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final styleActive = TextStyle(color: text, fontSize: 13,fontWeight: FontWeight.w500);
    final styleHint = TextStyle(
      color: text.withOpacity(0.7),
      fontSize: 13, fontWeight: FontWeight.w500
    );
    return Row(
      children: [
        Icon(
          Icons.search_rounded,
          size: 20,
          color: text,
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          width: 160,
          child: TextField(
            cursorWidth: 1.5,
            controller: controller,
            decoration: InputDecoration(
              suffixIconConstraints: BoxConstraints(
                minWidth: 2,
                minHeight: 2,
              ),
              suffixIcon: widget.text.isNotEmpty
                  ?
              CustomIconButton(icon: Icons.close_rounded, onTap: () { controller.clear();
              widget.onChanged('');
              FocusScope.of(context).requestFocus(FocusNode()); }, message: '', size: 15, enableToolTip: false,)
                  : null,
              hintText: widget.hintText,
              hintStyle: styleHint,
              border: InputBorder.none,
            ),
            style: styleActive,
            onChanged: widget.onChanged,
          ),
        )
      ],
    );
    /*,
        ]
    );*/
  }
}
