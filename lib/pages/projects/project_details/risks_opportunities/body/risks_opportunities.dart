import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/dialogs/create_event_dialog.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/bloc_provider.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/event_bloc.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/body/project_overview_body.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/data/event.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/widgets/event_item.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/widgets/view_types.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/messages.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/multi_options_button.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/pages/projects/widgets/search_text_field.dart';
import 'package:gestion_projets/services/navigation_service.dart';

import '../../../../../locator.dart';

class ProjectRisksOpportunitiesHeader extends StatelessWidget {
  final ScrollController scrollController;

  const ProjectRisksOpportunitiesHeader(
      {Key? key, required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<EventBloc>(context);

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
        Text("Risques/Opportunités", style: textStyle_Text_12_600),
        SizedBox(
          width: 2,
        ),
        Padding(
            padding: EdgeInsets.only(top: 2),
            child: CustomIconButton(
              icon: Icons.info,
              message: "Risques/Opportunités",
              onTap: () {},
              size: 17,
            )),
        Expanded(child: Container()),
        MultiOptionsButton(
          text: "Créer un risque/opportunité",
          isMultiple: false,
          onTap: () {
            createEventDialogBox(context, scrollController);
          },
        ),
      ],
    );
  }
}

class ProjectRisksOpportunitiesBody extends StatefulWidget {
  const ProjectRisksOpportunitiesBody({Key? key}) : super(key: key);

  @override
  _ProjectRisksOpportunitiesBodyState createState() =>
      _ProjectRisksOpportunitiesBodyState();
}

class _ProjectRisksOpportunitiesBodyState
    extends State<ProjectRisksOpportunitiesBody> {
  final ScrollController controller = ScrollController();

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ProjectRisksOpportunitiesHeader(
          scrollController: controller,
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
                        EventShowByViewMenu(),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(child: Container()),
                        SearchWidget(
                          hintText: 'Rechercher des opportunités...',
                          onChanged: (value) {},
                          width: 200,
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
                    Container(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 2,
                            child: Container(
                              color: Colors.transparent,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                              child: Row(
                                children: [
                                  Flexible(
                                      child: Text("Risque / Opportunité",
                                          overflow: TextOverflow.ellipsis,
                                          style: textStyle_Text_12_600)),
                                ],
                              ),
                            ),
                            flex: 3,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                              child: Row(
                                children: [
                                  Flexible(
                                      child: Text("Impact",
                                          overflow: TextOverflow.ellipsis,
                                          style: textStyle_Text_12_600)),
                                ],
                              ),
                            ),
                            flex: 3,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                              child: Row(
                                children: [
                                  Flexible(
                                      child: Text("Source",
                                          overflow: TextOverflow.ellipsis,
                                          style: textStyle_Text_12_600)),
                                ],
                              ),
                            ),
                            flex: 3,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                                child: Row(children: [
                              Flexible(
                                  child: Text("Évaluations",
                                      overflow: TextOverflow.ellipsis,
                                      style: textStyle_Text_12_600)),
                            ])),
                            flex: 2,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                              child: Row(
                                children: [
                                  Flexible(
                                      child: Text("Date d'identification",
                                          overflow: TextOverflow.ellipsis,
                                          style: textStyle_Text_12_600)),
                                ],
                              ),
                            ),
                            flex: 2,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Flexible(
                                    child: Text("Identifié par",
                                        overflow: TextOverflow.ellipsis,
                                        style: textStyle_Text_12_600)),
                              ],
                            ),
                            flex: 2,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Row(children: [
                              Flexible(
                                  child: Text("Niveau",
                                      overflow: TextOverflow.ellipsis,
                                      style: textStyle_Text_12_600)),
                            ]),
                            flex: 1,
                          ),
                          // ActionsMenu(),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 40,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [],
                            ),
                          ),

                          SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: dividerColor,
                    ),
                    Expanded(
                        child: RisksOpportunitiesList(
                      parentContext: context,
                      scrollController: controller,
                    )),
                  ]),
                )))
      ],
    );
  }
}

class RisksOpportunitiesList extends StatefulWidget {
  final BuildContext parentContext;
  final ScrollController scrollController;

  const RisksOpportunitiesList(
      {Key? key, required this.parentContext, required this.scrollController})
      : super(key: key);

  @override
  _RisksOpportunitiesListState createState() => _RisksOpportunitiesListState();
}

class _RisksOpportunitiesListState extends State<RisksOpportunitiesList> {
  late final bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<EventBloc>(widget.parentContext);
    super.initState();
    bloc.init();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: StreamBuilder<List<Event>>(
            stream: bloc.eventStream,
            builder: (context, snapshot) {
              final results = snapshot.data;
              return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: (snapshot.hasData)
                      ? (results!.isEmpty)
                          ? NoItems(
                              icon: "icons/no-phase.svg",
                              message:
                                  "Il n'y a aucun risque ou opportunité à afficher pour vous, actuellement vous n'en avez pas mais vous pouvez en créer un nouveau.",
                              title: "Aucun risque ou opportunité trouvé",
                              buttonText: "Créer")
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

  Widget _buildItem(Event event) {
    return TestProxy(
        key: ValueKey(event),
        child: new EventItem(
          onTap: () {},
          event: event,
        ));
  }
}
