import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/controllers.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:get/get.dart';

class TopNavMenuItem extends StatelessWidget {
  final String itemName;
  final Function() onTap;
  const TopNavMenuItem({
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
                ? menuController.onHover(itemName)
                : menuController.onHover("not hovering");
          },
          child: Obx(() => Container(
                color: menuController.isHovering(itemName)
                    ? Colors.transparent
                    : Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // color: Colors.blue,
                    if (!menuController.isActive(itemName))
                      Expanded(
                        child: Center(
                            child: Text(
                          itemName,
                          style: TextStyle(
                                color: menuController.isHovering(itemName)
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
                            style: textStyle_active_13_500,

                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    Visibility(
                      visible: menuController.isActive(itemName),
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      child: Container(
                        height: 2,
                        width: itemName.length * 7,
                        decoration: BoxDecoration(
                          color: active,
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                    ),
                  ],
                ),
              ))),
    );
  }
}
