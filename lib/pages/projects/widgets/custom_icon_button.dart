import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:get/get.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final String message;
  final Color color;
  final VoidCallback onTap;
  final bool enableToolTip;
  var iconColor = text.withOpacity(0.7).obs;
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
  Widget build(BuildContext context) {
    return (enableToolTip)
        ? Tooltip(
            message: message,
            child: SizedBox(
              child: InkWell(
                onTap: onTap,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onHover: (value) {
                  value
                      ? iconColor.value = color
                      : iconColor.value = text.withOpacity(0.7);
                },
                child: Obx(
                  () => Icon(
                    icon,
                    color: iconColor.value,
                    size: size,
                  ),
                ),
              ),
            ),
          )
        : SizedBox(
            child: InkWell(
              onTap: onTap,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onHover: (value) {
                value
                    ? iconColor.value = color
                    : iconColor.value = text.withOpacity(0.7);
              },
              child: Obx(
                () => Icon(
                  icon,
                  color: iconColor.value,
                  size: size,
                ),
              ),
            ),
          );
  }
}
