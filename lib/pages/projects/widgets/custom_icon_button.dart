import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:get/get.dart';
class CustomIconButton extends StatelessWidget {

  final IconData icon;
  final String message;
  final double size;
  const CustomIconButton({Key? key , required this.icon , required this.message , this.size = 17}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var supportColor = text.obs;

    return Tooltip(message: message ,child : SizedBox(child: InkWell(
      onTap: () {},
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,

      onHover: (value) {
        value ? supportColor.value = active : supportColor.value = text;
      },
      child: Obx(
            () => Icon(
              icon,
              color: supportColor.value,
              size: size,
            ),

      ),),
    ),);
  }
}
