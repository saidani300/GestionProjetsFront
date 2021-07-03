import 'package:flutter/material.dart';
import 'package:gestion_projets/widgets/top_nav.dart';

import 'helpers/local_navigator.dart';



class SiteLayout extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: topNavigationBar(context, scaffoldKey),
        drawer: Drawer(),
        body: localNavigator());
  }
}
