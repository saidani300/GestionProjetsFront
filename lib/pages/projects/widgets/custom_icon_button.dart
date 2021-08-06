import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';

class CustomIconButton extends StatefulWidget {
  final IconData icon;
  final String message;
  final Color color;
  final VoidCallback onTap;
  final bool enableToolTip;
  final double size;

  CustomIconButton(
      {Key? key,
      required this.icon,
      required this.message,
      this.size = 17,
      this.color = active,
      required this.onTap,
      this.enableToolTip = true})
      : super(key: key);

  @override
  _CustomIconButtonState createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return (widget.enableToolTip)
        ? Tooltip(
            message: widget.message,
            child: SizedBox(
              child: InkWell(
                onTap: widget.onTap,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onHover: (value) {
                  value
                      ? setState(()=> isHover = true)
                      : setState(()=> isHover = false);
                },
                child: Icon(
                    widget.icon,
                    color: isHover ? widget.color : text.withOpacity(0.7),
                    size: widget.size,
                ),
              ),
            ),
          )
        : SizedBox(
            child: InkWell(
              onTap: widget.onTap,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onHover: (value) {
                value
                    ? setState(()=> isHover = true)
                    : setState(()=> isHover = false);
              },
              child:Icon(
                  widget.icon,
                  color: isHover ? widget.color : text.withOpacity(0.7),
                  size: widget.size,
              ),
            ),
          );
  }
}
