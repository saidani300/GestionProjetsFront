import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';

class ShowByStatusItem extends StatefulWidget {
  final String itemName;
  final String activeName;
  final Function() onTap;

  const ShowByStatusItem({
    Key? key,
    required this.itemName,
    required this.activeName,
    required this.onTap,
  }) : super(key: key);

  @override
  _ShowByStatusItemState createState() => _ShowByStatusItemState();
}

class _ShowByStatusItemState extends State<ShowByStatusItem> {
  bool isActive = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          widget.onTap();
          setState(() {
            isActive = widget.activeName == widget.itemName;
          });
        },
        hoverColor: white,
        onHover: (value) {},
        child: IntrinsicWidth(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.itemName,
                style: TextStyle(
                    color: text,
                    fontSize: 13,
                    letterSpacing: 0,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              Visibility(
                visible: isActive,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: Container(
                  height: 2,
                  decoration: BoxDecoration(
                    color: active,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
