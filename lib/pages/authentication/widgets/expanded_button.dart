import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';

class ExpandedButton extends StatefulWidget {
  final double height;
  final String text;
  final Function() onTap;

  const ExpandedButton({
    Key? key,
    this.height = 35,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  _ExpandedButtonState createState() => _ExpandedButtonState();
}

class _ExpandedButtonState extends State<ExpandedButton> {
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
                  height: widget.height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                    color: isHover ? active.withAlpha(230) : active,
                  ),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(child: Container()),
                      Text(
                        widget.text,
                        style: TextStyle(
                            color: white,
                            fontSize: 12,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w500),
                      ),
                      Expanded(child: Container()),
                    ],
                  ),
                ));
  }
}
