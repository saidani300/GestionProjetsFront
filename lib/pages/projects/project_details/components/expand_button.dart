import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gestion_projets/constants/style.dart';

class ExpandButton extends StatefulWidget {
  final Function() onTap;
  final Color color;
  bool isExpanded;

  ExpandButton(
      {Key? key,
      required this.onTap,
      this.isExpanded = false,
      this.color = active})
      : super(key: key);

  @override
  _ExpandButtonState createState() => _ExpandButtonState();
}

class _ExpandButtonState extends State<ExpandButton>
    with TickerProviderStateMixin {
  late AnimationController rotationController;
  bool onHover = false;

  @override
  void initState() {
    rotationController = AnimationController(
        duration: const Duration(milliseconds: 0), vsync: this);
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

          widget.onTap();
        },
        onHover: (value) {
          setState(() {
            value ? onHover = true : onHover = false;
          });
        },
        child: RotationTransition(
          turns: Tween(begin: 0.0, end: 0.5).animate(rotationController),
          child: SvgPicture.asset(
            "icons/expand.svg",
            color: onHover ? active : text.withAlpha(150),
            width: 23,
            height: 23,
          ),
        ));
  }
}
