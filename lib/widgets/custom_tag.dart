import 'package:flutter/material.dart';
class CustomTag extends StatelessWidget {
  final double height;
  final String text;
  final Color? color;
  final Widget? icon;
  const CustomTag({Key? key, this.height = 22 , required this.text , required this.color , this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color!,
      ),
      child: Row( mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [ icon ?? Container(), Text(
          text,
          style: TextStyle(
              color: Colors.white,
              fontSize: 8.5,
              letterSpacing: 0,
              fontWeight: FontWeight.w600),
        )],
      ),
    );
  }
}
