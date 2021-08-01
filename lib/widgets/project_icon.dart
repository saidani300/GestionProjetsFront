import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';

class ProjectIcon extends StatelessWidget {
  final String name;
  final double size;

  const ProjectIcon({Key? key, required this.name, this.size = 30})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String profileInitials(String name) {
      var nameParts = name.split(" ");
      String initials = nameParts[0][0].toUpperCase();
      return initials;
    }

    final List<Color> colors = [
      Color(0xFFcbe11e),
      Color(0xFF1ecbe1),
      Color(0xFFB0C33C),
      Color(0xFF961ee1),
      Color(0xFFeab015),
      Color(0xFFf2497b),
      Color(0xFFf26b49),
      Color(0xFF2ED1C5),
      Color(0xFFFF5959),
      Color(0xFF808080)
    ];
    return Container(
      height: size,
      width: size,
      child: CircleAvatar(
        radius: 100.0,
        child: Text(profileInitials(name),
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: size / 3.33,
                letterSpacing: 1)),
        foregroundColor: white,
        backgroundColor: colors[5],
      ),
    );
  }
}
