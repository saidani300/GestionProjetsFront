import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';

import 'body/risks_opportunities.dart';



class ProjectRisksOpportunities extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container(
      color: backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      child:
      ProjectRisksOpportunitiesBody(),
    );


  }
}
