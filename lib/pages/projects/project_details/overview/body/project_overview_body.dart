import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/Data/items.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/bloc_provider.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/phase_bloc.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data_layer/document.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data_layer/phase.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data_layer/task.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data_layer/user.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data_layer/action.dart' as Model;
import 'package:gestion_projets/pages/projects/project_details/widgets/messages.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/multi_options_button.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/open_close_animated_arrow.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/phase_item.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/pages/projects/widgets/search_text_field.dart';
import 'package:gestion_projets/pages/projects/widgets/show_by_status_item.dart';
import 'package:gestion_projets/services/navigation_service.dart';

import '../../../../../locator.dart';

final ScrollController scrollController = ScrollController();

class ProjectOverviewHeader extends StatelessWidget {
  const ProjectOverviewHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   final bloc = BlocProvider.of<PhaseBloc>(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
       /* Icon(
          Icons.layers_rounded,
          size: 20,
          color: active,
        ),*/
        TextButton(onPressed: (){locator<NavigationService>().projectGoBack();}, child: Text("Projets",style: TextStyle(
            color: active,
            fontSize: 12,
            letterSpacing: 0,
            fontWeight: FontWeight.w600),),),
        Padding(padding: EdgeInsets.only(top: 2) ,child :Icon(Icons.keyboard_arrow_right_rounded , size: 16, color: active,)),
        SizedBox(width: 2,),
        Text(
          "Développement d'une nouvelle interface utilisateur",
          style: TextStyle(
              color: text,
              fontSize: 12,
              letterSpacing: 0,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(width: 2,),
        Padding(padding: EdgeInsets.only(top: 2) ,child :Icon(Icons.keyboard_arrow_right_rounded , size: 16, color: active,)),
        SizedBox(width: 2,),
        Text("Aperçu",style: TextStyle(
            color: text,
            fontSize: 12,
            letterSpacing: 0,
            fontWeight: FontWeight.w600),),
        SizedBox(width: 2,),
    Padding(padding: EdgeInsets.only(top: 2) ,child :CustomIconButton(icon: Icons.info, message: "Aperçu", onTap: (){} , size: 17,)),
        Expanded(child: Container()),
        MultiOptionsButton(text: "Créer une phase", onTap: () { bloc.add(new Phase(new Random.secure().nextInt(1000), new Random.secure().hashCode.toString(), DateTime.now(), DateTime.now(), [

          Model.Action(
              16,
              "Développement d'une nouvelle interface utilisateur.",
              DateTime.now(),
              DateTime.now().add(Duration(days: 36)),
              Status.inProgress,
              User(1, "Saidani Wael", "7"),
              [
                Task(
                    2,
                    "Développement d'une nouvelle interface utilisateur.",
                    DateTime.now(),
                    DateTime.now().add(Duration(days: 64)),
                    Status.completed,
                    User(1, "Saidani Wael", "5"),
                    [],
                    Priority.Important),
                Task(
                    6,
                    "Développement d'une nouvelle interface",
                    DateTime.now(),
                    DateTime.now().add(Duration(days: 10)),
                    Status.inProgress,
                    User(2, "Saidani Wael", "https://i.imgur.com/kieKRFZ.jpeg"),
                    [
                      Document(1, "Document1"),
                      Document(1, "Document2"),
                    ],
                    Priority.Low),
              ],
              [
                Document(1, "Document1"),
                Document(1, "Document2"),
              ],
              Priority.Normal),
        ]));
        //ScrollUp when Adding new Phase
        if (scrollController.hasClients)
        scrollController.animateTo(
          0.0,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
        ); }, ),
        /*TextButton.icon(
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
          onPressed: () {
            *//*TODO: Create Add Phase Logic in BLoC*//*
          *//*  locator<NavigationService>().projectGoBack();*//*

          },
          icon: Icon(
            Icons.add,
            color: Colors.white,
            size: 16,
          ),
          label: Text(
            'Créer une phase',
            style: TextStyle(
                color: Colors.white,
                fontSize: 11.5,
                letterSpacing: 0,
                fontWeight: FontWeight.w400),
          ),
        )*/
      ],
    );
  }
}

class ProjectOverviewBody extends StatefulWidget {
  const ProjectOverviewBody({Key? key}) : super(key: key);

  @override
  _ProjectOverviewBodyState createState() => _ProjectOverviewBodyState();
}

class _ProjectOverviewBodyState extends State<ProjectOverviewBody> {
  final ScrollController controller = ScrollController();
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   // final bloc = BlocProvider.of<PhaseBloc>(context);
   // bloc.fetch();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ProjectOverviewHeader(),
        Expanded(
            child: Container(
                margin: EdgeInsets.only(top: 20),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: lightGrey.withOpacity(0.3),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        spreadRadius: 0.5,
                        blurRadius: 0.5,
                        // offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white,
                  ),
                  child: Column(children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(3),
                            topRight: Radius.circular(3),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0)),
                        color: Colors.white,
                      ),
                      alignment: Alignment.bottomLeft,
                      child: Row(children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: ShowByStatusItems.map(
                            (e) => Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: ShowByStatusItem(
                                    itemName: e.name, onTap: () {})),
                          ).toList(),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(child: Container()),
                        SearchWidget(
                          text: "",
                          hintText: 'Rechercher',
                          onChanged: (value) {},
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        CustomIconButton(
                            icon: Icons.save_alt_rounded,
                            message: 'Exporter',
                            onTap: () {
                            /*  bloc.fetch();*/
                            }),
                        SizedBox(
                          width: 15,
                        ),
                        CustomIconButton(
                          icon: Icons.filter_alt_outlined,
                          message: 'Filter',
                          onTap: () {},
                        ),
                        SizedBox(
                          width: 15,
                        ),
                      ]),
                    ),
                    Divider(
                      height: 1,
                      color: dark.withOpacity(0.15),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: 45,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 25,
                            ),
                            Expanded(
                              child: Container(
                                  child: Row(children: [
                                Flexible(
                                    child: Text(
                                  "Nom",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: text,
                                      fontSize: 12,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w600),
                                ))
                              ])),
                              flex: 5,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Container(
                                  child: Row(children: [
                                Flexible(
                                    child: Text(
                                  "Date limite",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: text,
                                      fontSize: 12,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w600),
                                ))
                              ])),
                              flex: 2,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Container(
                                  child: Row(children: [
                                Flexible(
                                    child: Text(
                                  "Responsable",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: text,
                                      fontSize: 12,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w600),
                                ))
                              ])),
                              flex: 2,
                            ),
                            Expanded(
                              child: Container(
                                  child: Row(children: [
                                Flexible(
                                    child: Text(
                                  "Priorité",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: text,
                                      fontSize: 12,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w600),
                                ))
                              ])),
                              flex: 1,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Container(
                                  child: Row(children: [
                                Flexible(
                                    child: Text(
                                  "Avancement",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: text,
                                      fontSize: 12,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w600),
                                ))
                              ])),
                              flex: 1,
                            ),
                            Expanded(
                              child: Container(
                                  child: Row(children: [
                                Expanded(child: Container()),
                                Text(
                                  "Actions",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: text,
                                      fontSize: 12,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w600),
                                )
                              ])),
                              flex: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: dark.withOpacity(0.15),
                    ),
                    Expanded(
                        child: PhasesList(parentContext: context,)),
                  ]),
                )))
      ],
    );
  }
}

class PhasesList extends StatefulWidget {
  final BuildContext parentContext;
  const PhasesList({Key? key ,required this.parentContext}) : super(key: key);

  @override
  _PhasesListState createState() => _PhasesListState();
}

class _PhasesListState extends State<PhasesList>{

  late final bloc;
@override
  void initState() {
  bloc = BlocProvider.of<PhaseBloc>(widget.parentContext);
  super.initState();
  bloc.init();
  //Future.delayed(Duration(milliseconds: 50) , () async => await bloc.fetch());

  }


  @override
  Widget build(BuildContext context) {

    return Container(
        child: StreamBuilder<List<Phase>>(
            stream: bloc.phaseStream,
            builder: (context, snapshot) {
              print(
                  "snapshot " + snapshot.data.toString());
              final results = snapshot.data;
              return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child:

                  (snapshot.hasData) ?
                  (results!.isEmpty) ?
                  NoPhases() :
              ListView(
                key: ValueKey(Random.secure()),
                controller: scrollController,
                children: results.map((e) => _buildItem(e)).toList(),
              )
              :
                 Center(
                  child: SpinKitFadingCube(
                    color: active,
                    size: 25,
                    duration:
                    Duration(milliseconds: 1200),
                  ),

                ));

            })
    );

}
  Widget _buildItem(Phase phase) {
    return TestProxy(
      key: ValueKey(phase),
      child: new PhaseItem(phase: phase,)
    );
  }


}

class TestProxy extends SingleChildRenderObjectWidget {
  TestProxy({Key? key, required Widget child}) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    print('createRenderObject $key');
    return RenderProxyBox();
  }

  @override
  void updateRenderObject(BuildContext context, RenderObject renderObject) {
    print('updateRenderObject $key');
  }
}