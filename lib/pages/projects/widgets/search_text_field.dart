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
            controller: controller,
            decoration: InputDecoration(
              suffixIcon: widget.text.isNotEmpty
                  ? GestureDetector(
                      child: Icon(
                        Icons.close_rounded,
                        color: active,
                        size: 19,
                      ),
                      onTap: () {
                        controller.clear();
                        widget.onChanged('');
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                    )
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
