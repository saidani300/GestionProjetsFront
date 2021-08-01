import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';

class MultiOptionsButton extends StatefulWidget {
  final double height;
  final String text;
  final bool isMultiple;
  final Function() onTap;
  final bool withIcon;

  const MultiOptionsButton({
    Key? key,
    this.height = 35,
    required this.text,
    required this.onTap,
    this.isMultiple = true,
    this.withIcon = true,
  }) : super(key: key);

  @override
  _MultiOptionsButtonState createState() => _MultiOptionsButtonState();
}

class _MultiOptionsButtonState extends State<MultiOptionsButton> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
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
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(3),
                  topRight: widget.isMultiple
                      ? Radius.circular(0)
                      : Radius.circular(3),
                  bottomLeft: Radius.circular(3),
                  bottomRight: widget.isMultiple
                      ? Radius.circular(0)
                      : Radius.circular(3),
                ),
                color: isHover ? active.withAlpha(230) : active,
              ),
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Visibility(
                    visible: widget.withIcon,
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Icon(
                        Icons.add,
                        size: 15,
                        color: white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ]),
                  ),
                  Text(
                    widget.text,
                    style: TextStyle(
                        color: white,
                        fontSize: 12,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w500),
                  ),
                  Visibility(
                      visible: widget.withIcon,
                      child: SizedBox(
                        width: 5,
                      )),
                ],
              ),
            )),
        Visibility(
            visible: widget.isMultiple,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 1,
                ),
                Container(
                    height: widget.height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(3),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(3),
                      ),
                      color: active,
                    ),
                    padding: EdgeInsets.all(5),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 15,
                      color: white,
                    ))
              ],
            ))
      ],
    ));
  }
}
