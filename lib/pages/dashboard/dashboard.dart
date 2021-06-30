import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(

      child:  Text(
        'Tableau de bord',
        style: TextStyle(
              color: dark,
              fontSize: 15,
              letterSpacing: 0,
              fontWeight: FontWeight.w500),

      ),

    );
  }
}
