import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';

class FilterButton extends StatefulWidget {
  final String text;
  final Function() onTap;
  final Color color;

  const FilterButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.color = active,
  }) : super(key: key);

  @override
  _FilterButtonState createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onTap: widget.onTap,
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
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(3)),
            color: isHover ? widget.color.withAlpha(230) : widget.color,
          ),
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.text,
                style: TextStyle(
                    color: white,
                    fontSize: 11,
                    letterSpacing: 0,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ));
  }
}

class FilterOutlinedButton extends StatefulWidget {
  final String text;
  final Function() onTap;

  const FilterOutlinedButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  _FilterOutlinedButtonState createState() => _FilterOutlinedButtonState();
}

class _FilterOutlinedButtonState extends State<FilterOutlinedButton> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onTap: widget.onTap,
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
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(3)),
            border: Border.all(
                width: 1,
                color: isHover ? text.withAlpha(150) : text.withAlpha(100)),
          ),
          padding: EdgeInsets.all(9),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.text,
                style: textStyle_Text_11_500
              ),
            ],
          ),
        ));
  }
}
