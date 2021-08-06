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
        child: widget.isExpanded ? Container(
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
                    width: 20,
                    height: 20,
                  ),
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
                    width: 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(3),
                          bottomLeft: Radius.circular(3)),
                      color: widget.isActive ? active : Colors.transparent,
                    ),
                    height: 50,
                  ),
                ],
              ),
            )):Tooltip(
          message: widget.item.name,
              decoration: BoxDecoration(
                color: active,
                borderRadius: BorderRadius.all(Radius.circular(2)),

              ),
              verticalOffset: -15,
              margin: EdgeInsets.only(left: 52),
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
                      width: 3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(3),
                            bottomLeft: Radius.circular(3)),
                        color: widget.isActive ? active : Colors.transparent,
                      ),
                      height: 50,
                    ),
                  ],
                ),
              )),
            ));
  }
}
