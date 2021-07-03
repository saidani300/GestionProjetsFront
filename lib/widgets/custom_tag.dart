import 'package:flutter/material.dart';
class CustomTag extends StatelessWidget {
  final double height;
  final String text;
  final Color? color;
  const CustomTag({Key? key, this.height = 22 , required this.text , required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: color!.withOpacity(0.15),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              color: color,
              fontSize: 9,
              letterSpacing: 0,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
