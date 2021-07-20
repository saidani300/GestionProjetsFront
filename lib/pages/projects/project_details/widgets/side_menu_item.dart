import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/Data/project_details_menu.dart';

class SideMenuItemExpanded extends StatefulWidget {
  final ProjectDetailsMenuItem item;
  final bool isActive;
  final Function() onTap;
  final bool isExpanded;

  const SideMenuItemExpanded(
      {Key? key,
      required this.item,
      required this.isActive,
      required this.onTap,
      required this.isExpanded})
      : super(key: key);

  @override
  _SideMenuItemExpandedState createState() => _SideMenuItemExpandedState();
}

class _SideMenuItemExpandedState extends State<SideMenuItemExpanded> {
  Color onHover = text.withOpacity(0.65);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: widget.onTap,
        onHover: (value) {
          value
              ? setState(() {
                  onHover = active;
                })
              : setState(() {
                  onHover = text.withOpacity(0.65);
                });
        },
        child: Container(
            color:
                widget.isActive ? active.withOpacity(0.04) : Colors.transparent,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.end,
                // mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  SvgPicture.asset(
                    widget.item.icon,
                    color: widget.isActive ? active : onHover,
                    width: 18,
                    height: 18,
                  ),

                  /*
                  Icon(
                    widget.item.icon,
                    size: 20,
                    color: widget.isActive ? active : onHover,
                  ),*/
                  SizedBox(
                    width: 15,
                  ),
                  Visibility(
                      visible: widget.isExpanded,
                      child: SingleChildScrollView(
                          child: Text(
                        widget.item.name,
                        style: TextStyle(
                            color: widget.isActive ? active : onHover,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ))),
                  Expanded(child: Container()),
                  Container(
                    width: 2,
                    height: 50,
                    color: widget.isActive ? active : Colors.transparent,
                  ),
                ],
              ),
            )));
  }
}
