import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/body/projects_body.dart';

import 'Data/project.dart';


class ProjectsPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return Container(
      color: backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 35),
      child:
          ProjectsPageBody(),
    );
  }
}
