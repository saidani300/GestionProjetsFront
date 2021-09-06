import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';

import 'body/personnes_body.dart';

class PeoplePage extends StatelessWidget {
  const PeoplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child:UsersPageBody(),
    );
  }
}
