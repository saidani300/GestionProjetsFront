import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:get/get.dart';

class CustomOutlinedButton extends StatelessWidget {
  final IconData icon;
  final String buttonText;
  final bool clickable;
  final VoidCallback onTap;
  var borderColor = text.withOpacity(0.25).obs;
  final double height;
  final double width;
  final Widget? secondary;

  CustomOutlinedButton(
      {Key? key,
      required this.icon,
      required this.buttonText,
      this.height = 34,
      this.width = 180,
      required this.onTap,
      this.secondary,
      this.clickable = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (clickable)
        ? InkWell(
            enableFeedback: false,
            canRequestFocus: false,
            excludeFromSemantics: true,
            onTap: onTap,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onHover: (value) {
              value
                  ? borderColor.value = active
                  : borderColor.value = text.withOpacity(0.25);
            },
            child: Obx(
              () => Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: borderColor.value, width: 1.4),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      secondary ?? Container(),
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                              child: Text(
                                buttonText,
                                style: TextStyle(
                                    color: text,
                                    fontSize: 12.5,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w500),
                              ))),
                      Container(
                          width: 34,
                          child: Icon(
                            icon,
                            color: text.withOpacity(0.7),
                            size: 18,
                          )),
                    ],
                  )),
            ),
          )
        : Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: borderColor.value, width: 1.4),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 15,
                ),
                secondary ?? Container(),
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                        child: Text(
                          buttonText,
                          style: TextStyle(
                              color: text,
                              fontSize: 12.5,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w500),
                        ))),
                Container(
                    width: 34,
                    child: Icon(
                      icon,
                      color: text.withOpacity(0.7),
                      size: 18,
                    )),
              ],
            ));
  }
}
