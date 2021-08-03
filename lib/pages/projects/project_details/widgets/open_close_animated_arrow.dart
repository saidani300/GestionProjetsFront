import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';

class OpenCloseArrowButton extends StatefulWidget {
  final Function() onTap;
  final Color color;
  bool isExpanded;
  late final AnimationController rotationController;
  OpenCloseArrowButton(
      {Key? key,
      required this.onTap,
      this.isExpanded = false,
      this.color = active,
      required this.rotationController})
      : super(key: key);

  @override
  _OpenCloseArrowButtonState createState() => _OpenCloseArrowButtonState();
}

class _OpenCloseArrowButtonState extends State<OpenCloseArrowButton>
    with TickerProviderStateMixin {
  bool onHover = false;

  @override
  void initState() {

    super.initState();
    widget.isExpanded
        ? widget.rotationController.value = 1
        : widget.rotationController.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          widget.isExpanded
              ? widget.rotationController.reverse()
              : widget.rotationController.forward();

          widget.onTap();

        },
        onHover: (value) {
          setState(() {
            value ? onHover = true : onHover = false;
          });
        },
        child: Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
                border: Border.all(
                  color: widget.color,
                  width: 1.2,
                ),
                color: onHover ? widget.color : Colors.transparent,
                shape: BoxShape.circle),
            child: RotationTransition(
              turns: Tween(begin: 0.0, end: 0.25).animate(widget.rotationController),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 8,
                color: onHover ? white : widget.color,
              ),
            )));
  }
}
