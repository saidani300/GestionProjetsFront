import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/controllers.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:get/get.dart';

class ShowByStatusItem extends StatelessWidget {
  final String itemName;
  final Function() onTap;
  const ShowByStatusItem({
    Key? key,
    required this.itemName,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      child: InkWell(
          onTap: onTap,
          hoverColor: Colors.white,
          onHover: (value) {
            value
                ? showbystatusController.onHover(itemName)
                : showbystatusController.onHover("not hovering");
          },
          child: Obx(() => Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // color: Colors.blue,
                if (!showbystatusController.isActive(itemName))
                  Expanded(
                    child: Center(
                        child: Text(
                          itemName,
                          style: TextStyle(
                              color: showbystatusController.isHovering(itemName)
                                  ? text
                                  : lightText,
                              fontSize: 13,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w500),

                          textAlign: TextAlign.center,
                        )),
                  )
                else
                  Expanded(
                    child: Center(
                      child: Text(
                        itemName,
                        style: TextStyle(
                            color: active,
                            fontSize: 13,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w600),

                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                Visibility(
                  visible: showbystatusController.isActive(itemName),
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: Container(
                    height: 2,
                    width: itemName.length * 7,
                    decoration: BoxDecoration(
                      color: active,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ],
            ),
          ))),
    );
  }
}