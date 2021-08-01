import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/bloc_provider.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/document_bloc.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/event_bloc.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/meeting_bloc.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/objective_bloc.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/phase_bloc.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/project_bloc.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/task_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants/style.dart';
import 'controllers/top_nav_menu_controller.dart';
import 'layout.dart';
import 'locator.dart';

void main() {
  setupLocator();
  Get.put(TopNavMenuController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DocumentBloc>(
        bloc: DocumentBloc(),
        child: BlocProvider<MeetingBloc>(
            bloc: MeetingBloc(),
            child: BlocProvider<ProjectBloc>(
                bloc: ProjectBloc(),
                child: BlocProvider<PhaseBloc>(
                    bloc: PhaseBloc(),
                    child: BlocProvider<TaskBloc>(
                        bloc: TaskBloc(),
                        child: BlocProvider<ObjectiveBloc>(
                            bloc: ObjectiveBloc(),
                            child: BlocProvider<EventBloc>(
                                bloc: EventBloc(),
                                child:MaterialApp(
                                      localizationsDelegates: [
                                        GlobalMaterialLocalizations.delegate,
                                        GlobalWidgetsLocalizations.delegate,
                                      ],
                                      supportedLocales: [
                                        const Locale('en'),
                                        const Locale('fr')
                                      ],

                                      /*initialRoute: rootRoute,
        unknownRoute: GetPage(name: '/not-found', page: () => PageNotFound(), transition: Transition.fadeIn),
        getPages: [
          GetPage(name: rootRoute, page: () {
            return SiteLayout();
          }),
        //  GetPage(name: dashboardPageRoute, page: () => DashboardPage()),
        ],*/
                                      debugShowCheckedModeBanner: false,
                                      title: "Qalitas",
                                      theme: ThemeData(
                                        scrollbarTheme: ScrollbarThemeData(
                                          isAlwaysShown: false,
                                        ),
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        fontFamily: 'Montserrat',
                                        hoverColor: active.withOpacity(0.05),
                                        tooltipTheme: TooltipThemeData(
                                          padding: EdgeInsets.all(7),
                                          textStyle: TextStyle(
                                              fontSize: 11, color: white),
                                          decoration: BoxDecoration(
                                            color: text,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(2.0)),
                                          ),
                                        ),
                                        buttonTheme: ButtonThemeData(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                        ),
                                       /* popupMenuTheme: PopupMenuThemeData(
                                          color: white,
                                          textStyle: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 13,
                                              color: dark),
                                        ),*/
                                        scaffoldBackgroundColor: white,
                                        textTheme:
                                            GoogleFonts.montserratTextTheme(
                                                    Theme.of(context).textTheme)
                                                .apply(bodyColor: Colors.black),
                                        pageTransitionsTheme:
                                            PageTransitionsTheme(builders: {
                                          TargetPlatform.windows:
                                              FadeUpwardsPageTransitionsBuilder(),
                                        }),
                                        primaryColor: active,
                                        colorScheme:
                                            ColorScheme.light(primary: active),
                                      ),
                                      home: SiteLayout(),
                                    ))))))));
    // home: SiteLayout()
  }
}
