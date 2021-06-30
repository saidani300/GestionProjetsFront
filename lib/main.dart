import 'package:flutter/material.dart';
import 'package:gestion_projets/pages/404/not_found.dart';
import 'package:gestion_projets/pages/dashboard/dashboard.dart';
import 'package:gestion_projets/pages/projects/controllers/show_by_status_controller.dart';
import 'package:gestion_projets/routing/routes.dart';
import 'package:gestion_projets/widgets/top_nav_menu_item.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants/style.dart';
import 'controllers/navigation_controller.dart';
import 'controllers/top_nav_menu_controller.dart';
import 'layout.dart';

void main() {
  Get.put(TopNavMenuController());
  Get.put(NavigationController());
  Get.put(ShowByStatusController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        initialRoute: rootRoute,
        unknownRoute: GetPage(name: '/not-found', page: () => PageNotFound(), transition: Transition.fadeIn),
        getPages: [
          GetPage(name: rootRoute, page: () {
            return SiteLayout();
          }),
        //  GetPage(name: dashboardPageRoute, page: () => DashboardPage()),
        ],
        debugShowCheckedModeBanner: false,
        title: "Qalitas",
        theme: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            focusColor: Colors.transparent,
            fontFamily: 'Montserrat',
            hoverColor: active.withOpacity(0.05),
            tooltipTheme: TooltipThemeData(
              textStyle: TextStyle(fontSize: 11, color: Colors.white),
              decoration: BoxDecoration(
                color: dark.withOpacity(0.8),
                borderRadius: BorderRadius.all(Radius.circular(2.0)),
              ),
            ),
            buttonTheme: ButtonThemeData(),
            popupMenuTheme: PopupMenuThemeData(
              color: Colors.white,
              textStyle: TextStyle(fontFamily: 'Montserrat', fontSize: 13, color: dark),
            ),

            scaffoldBackgroundColor: Colors.white,
            textTheme:
                GoogleFonts.montserratTextTheme(Theme.of(context).textTheme)
                    .apply(bodyColor: Colors.black),
            pageTransitionsTheme: PageTransitionsTheme(builders: {
              TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
            }),
            primaryColor: Colors.blue),

       // home: SiteLayout()
    );
  }
}
