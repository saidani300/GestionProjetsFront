import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';

class CustomTag extends StatelessWidget {
  final double height;
  final String text;
  final Color? color;
  final Widget? icon;
  final String date;

  const CustomTag(
      {Key? key,
      this.height = 22,
      required this.text,
      required this.color,
      this.icon,
      this.date = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (date.isNotEmpty)
        ? Tooltip(
            message: date,
            /*   decoration: BoxDecoration(
        color: color,
          borderRadius: BorderRadius.all(Radius.circular(2)),
    )
        ,*/
            child: Container(
              height: height,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: color!,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon ?? Container(),
                  Text(
                    text,
                    style: TextStyle(
                        color: white,
                        fontSize: 8.5,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ))
        : Container(
            height: height,
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: color!,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon ?? Container(),
                Text(
                  text,
                  style: TextStyle(
                      color: white,
                      fontSize: 8.5,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          );
  }
}
