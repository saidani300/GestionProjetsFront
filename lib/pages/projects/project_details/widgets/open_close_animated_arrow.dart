import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';

class OpenCloseArrowButton extends StatefulWidget {
  final Function() onTap;
  final Color color;
  bool isExpanded;
  OpenCloseArrowButton(
      {Key? key,
        required this.onTap,
        this.isExpanded = false,
        this.color = active})
      : super(key: key);

  @override
  _OpenCloseArrowButtonState createState() => _OpenCloseArrowButtonState();
}

class _OpenCloseArrowButtonState extends State<OpenCloseArrowButton>
    with TickerProviderStateMixin {
  late AnimationController rotationController;
  bool onHover = false;

  @override
  void initState() {
    rotationController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    super.initState();
    widget.isExpanded
        ? rotationController.value = 1
        : rotationController.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          widget.isExpanded
              ? rotationController.reverse()
              : rotationController.forward();
          widget.isExpanded = !widget.isExpanded;
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
                  width: 1,
                ),
                color: onHover ? widget.color : Colors.transparent,
                shape: BoxShape.circle),
            child: RotationTransition(
              turns: Tween(begin: 0.0, end: 0.25).animate(rotationController),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 8,
                color: onHover ? Colors.white : widget.color,
              ),
            )));
  }
}
