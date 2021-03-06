import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';

class Avatar extends StatelessWidget {
  final String name;
  final String picture;
  final double size;

  const Avatar(
      {Key? key, required this.name, required this.picture, this.size = 30})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String profileInitials(String name) {
      var nameParts = name.split(" ");
      String initials =
          nameParts[0][0].toUpperCase() + nameParts[1][0].toUpperCase();
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
        child: (picture.characters.length < 3)
            ? Text(profileInitials(name),
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: size / 3.33,
                    letterSpacing: 1))
            : null,
        foregroundColor: white,
        backgroundColor: /*Colors.deepPurpleAccent*/ colors[
            int.tryParse(picture) ?? 0],
        backgroundImage: (picture.characters.length > 3)
            ? Image.network(picture).image
            : null,
      ),
    );
  }
}
