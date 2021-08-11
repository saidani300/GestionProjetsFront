import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/phase_bloc.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/dialogs/create_phase_dialog.dart';
import 'package:gestion_projets/pages/projects/project_details/structure/data/phase.dart';
import 'package:gestion_projets/pages/projects/project_details/structure/widgets/phase_item.dart';
import 'package:gestion_projets/pages/projects/project_details/structure/widgets/view_types.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/messages.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/multi_options_button.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/pages/projects/widgets/search_text_field.dart';
import 'package:gestion_projets/services/navigation_service.dart';

import '../../../../../locator.dart';

class ProjectOverviewHeader extends StatelessWidget {
  final ScrollController controller;

  const ProjectOverviewHeader({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            locator<NavigationService>().projectGoBack();
          },
          child: Text("Projets", style: textStyle_active_12_600),
        ),
        Padding(
            padding: EdgeInsets.only(top: 2),
            child: Icon(
              Icons.keyboard_arrow_right_rounded,
              size: 16,
              color: active,
            )),
        SizedBox(
          width: 2,
        ),
        Text("Développement d'une nouvelle interface utilisateur",
            style: textStyle_Text_12_600),
        SizedBox(
          width: 2,
        ),
        Padding(
            padding: EdgeInsets.only(top: 2),
            child: Icon(
              Icons.keyboard_arrow_right_rounded,
              size: 16,
              color: active,
            )),
        SizedBox(
          width: 2,
        ),
        Text("Structure", style: textStyle_Text_12_600),
        SizedBox(
          width: 2,
        ),
        Padding(
            padding: EdgeInsets.only(top: 2),
            child: CustomIconButton(
              icon: Icons.info,
              message: "Structure",
              onTap: () {},
              size: 17,
            )),
        Expanded(child: Container()),
        MultiOptionsButton(
          text: "Créer une phase",
          onTap: () {
            createPhaseDialogBox(context, controller);
          },
        ),
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
        ProjectOverviewHeader(
          controller: controller,
        ),
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
                    color: white,
                  ),
                  child: Column(children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(3),
                            topRight: Radius.circular(3),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0)),
                        color: white,
                      ),
                      alignment: Alignment.bottomLeft,
                      child: Row(children: [
                        ShowByViewMenu(),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(child: Container()),
                        SearchWidget(
                          hintText: 'Rechercher des phases...',
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
                      color: dividerColor,
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
                                    child: Text("Nom",
                                        overflow: TextOverflow.ellipsis,
                                        style: textStyle_Text_12_600))
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
                                    child: Text("Date limite",
                                        overflow: TextOverflow.ellipsis,
                                        style: textStyle_Text_12_600))
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
                                    child: Text("Responsable",
                                        overflow: TextOverflow.ellipsis,
                                        style: textStyle_Text_12_600))
                              ])),
                              flex: 2,
                            ),
                            Expanded(
                              child: Container(
                                  child: Row(children: [
                                Flexible(
                                    child: Text("Priorité",
                                        overflow: TextOverflow.ellipsis,
                                        style: textStyle_Text_12_600))
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
                                    child: Text("Avancement",
                                        overflow: TextOverflow.ellipsis,
                                        style: textStyle_Text_12_600))
                              ])),
                              flex: 1,
                            ),
                            Expanded(
                              child: Container(
                                  child: Row(children: [
                                Expanded(child: Container()),
                                Text("Actions",
                                    overflow: TextOverflow.ellipsis,
                                    style: textStyle_Text_12_600)
                              ])),
                              flex: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: dividerColor,
                    ),
                    Expanded(
                        child: PhasesList(
                      parentContext: context,
                      scrollController: controller,
                    )),
                  ]),
                )))
      ],
    );
  }
}

class PhasesList extends StatefulWidget {
  final BuildContext parentContext;
  final ScrollController scrollController;

  const PhasesList(
      {Key? key, required this.parentContext, required this.scrollController})
      : super(key: key);

  @override
  _PhasesListState createState() => _PhasesListState();
}

class _PhasesListState extends State<PhasesList> {
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
              final results = snapshot.data;
              return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: (snapshot.hasData)
                      ? (results!.isEmpty)
                          ? NoItems(
                              icon: "icons/no-phase.svg",
                              message:
                                  "Il n'y a aucune phase ou action à afficher pour vous, actuellement vous n'en avez pas mais vous pouvez en créer une nouvelle.",
                              title: "Aucune phase ou action trouvée",
                              buttonText: "Créer",
                              onTap: () {
                                createPhaseDialogBox(
                                    context, widget.scrollController);
                              },
                            )
                          : ListView(
                              key: ValueKey(Random.secure()),
                              controller: widget.scrollController,
                              children:
                                  results.map((e) => _buildItem(e)).toList(),
                            )
                      : Center(
                          child: SpinKitFadingCube(
                            color: active,
                            size: 25,
                            duration: Duration(milliseconds: 1200),
                          ),
                        ));
            }));
  }

  Widget _buildItem(Phase phase) {
    return TestProxy(
        key: ValueKey(phase),
        child: new PhaseItem(
          phase: phase,
        ));
  }
}

class TestProxy extends SingleChildRenderObjectWidget {
  TestProxy({Key? key, required Widget child}) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderProxyBox();
  }

  @override
  void updateRenderObject(BuildContext context, RenderObject renderObject) {}
}
