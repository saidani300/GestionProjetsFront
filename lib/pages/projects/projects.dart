import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/body/projects_body.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(child : Container(
      color: backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 35),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ProjectsPageHeader(),
          ProjectsPageBody(),
        ],
      ),
    ));
  }
}

class ProjectsPageHeader extends StatelessWidget {
  const ProjectsPageHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //SvgPicture.asset("icons/Projects.svg" , width: 20, height: 20,),
        Icon(
          Icons.layers_rounded,
          size: 20,
          color: active,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          'Projets',
          style: TextStyle(
              color: dark,
              fontSize: 20,
              letterSpacing: 0,
              fontWeight: FontWeight.w500),
        ),
        Expanded(child: Container()),
        Tooltip(
          message: 'Exporter CSV',
          child: OutlinedButton(
            onPressed: () {},
            child: Icon(
              Icons.download_rounded,
              size: 20,
              color: active,
            ),
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all<Size>(Size(35, 35)),
              side: MaterialStateProperty.resolveWith<BorderSide?>((states) {
                return BorderSide(
                    color: (states.contains(MaterialState.hovered))
                        ? active
                        : active.withOpacity(0.5),
                    width: 1.2);
              }),
              backgroundColor:
                  MaterialStateProperty.resolveWith<Color?>((states) {
                return (states.contains(MaterialState.hovered))
                    ? active.withOpacity(0.02)
                    : Colors.transparent;
              }),
              //foregroundColor: Colors.white,
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        TextButton.icon(
          style: ButtonStyle(
            fixedSize:
                MaterialStateProperty.all<Size>(Size(double.infinity, 35)),
            // backgroundColor: MaterialStateProperty.all<Color>(active),
            backgroundColor:
                MaterialStateProperty.resolveWith<Color?>((states) {
              if (states.contains(MaterialState.hovered)) {
                return buttonHover;
              } else {
                return active;
              }
            }),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(horizontal: 20, vertical: 16)),
          ),
          onPressed: () {},
          icon: Icon(
            Icons.add,
            color: Colors.white,
            size: 16,
          ),
          label: Text(
            'Créer un projet ',
            style: TextStyle(
                color: Colors.white,
                fontSize: 11.5,
                letterSpacing: 0,
                fontWeight: FontWeight.w400),
          ),
        )
      ],
    );
  }
}
