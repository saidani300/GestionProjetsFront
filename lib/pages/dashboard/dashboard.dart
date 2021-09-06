import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';

import 'body/dashboard_body.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: DashboardPageBody(),
    );
  }
}
