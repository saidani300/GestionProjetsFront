import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';

class DialogButton extends StatefulWidget {
  final String text;
  final Function() onTap;
  final Color color;

  const DialogButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.color = active,
  }) : super(key: key);

  @override
  _DialogButtonState createState() => _DialogButtonState();
}

class _DialogButtonState extends State<DialogButton> {
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
                    fontSize: 12,
                    letterSpacing: 0,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ));
  }
}

class DialogOutlinedButton extends StatefulWidget {
  final String text;
  final Function() onTap;

  const DialogOutlinedButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  _DialogOutlinedButtonState createState() => _DialogOutlinedButtonState();
}

class _DialogOutlinedButtonState extends State<DialogOutlinedButton> {
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
                style: TextStyle(
                    color: text,
                    fontSize: 12,
                    letterSpacing: 0,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ));
  }
}
