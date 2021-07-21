import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/bloc_provider.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/meeting_bloc.dart';
import 'package:gestion_projets/pages/projects/project_details/meetings/data/meeting.dart';
import 'package:gestion_projets/pages/projects/project_details/meetings/widgets/meeting_item.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/body/project_overview_body.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data/user.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/messages.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/multi_options_button.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/pages/projects/widgets/search_text_field.dart';
import 'package:gestion_projets/services/navigation_service.dart';

import '../../../../../locator.dart';

final ScrollController scrollController = ScrollController();

class ProjectMeetingsHeader extends StatelessWidget {
  const ProjectMeetingsHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<MeetingBloc>(context);

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
        Text("Réunions", style: textStyle_Text_12_600),
        SizedBox(
          width: 2,
        ),
        Padding(
            padding: EdgeInsets.only(top: 2),
            child: CustomIconButton(
              icon: Icons.info,
              message: "Réunions",
              onTap: () {},
              size: 17,
            )),
        Expanded(child: Container()),
        MultiOptionsButton(
          text: "Créer une réunion",
          isMultiple: false,
          onTap: () {
            bloc.add(new Meeting(
                new Random().nextInt(99999),
                "Retard potentiel pour une tâche",
                DateTime.now().add(Duration(days: 13)),
                "",
                [User(1, "Saidani Wael", "3"), User(3, "Saidani Wael", "5")],
                [
                  RelatedItem(
                      121, "Retard potentiel pour une tâche", ItemType.Risk),
                  RelatedItem(
                      487,
                      "Développement d'une nouvelle interface utilisateur",
                      ItemType.Task),
                ],
                MeetingStatus.programmed,
                []));
          },
        ),
      ],
    );
  }
}

class ProjectMeetingsBody extends StatefulWidget {
  const ProjectMeetingsBody({Key? key}) : super(key: key);

  @override
  _ProjectMeetingsBodyState createState() => _ProjectMeetingsBodyState();
}

class _ProjectMeetingsBodyState extends State<ProjectMeetingsBody> {
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
        ProjectMeetingsHeader(),
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
                        //Menu
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(child: Container()),
                        SearchWidget(
                          text: "",
                          hintText: 'Rechercher des réunions',
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
                    MeetingsListHeader(),
                    Divider(
                      height: 1,
                      color: dividerColor,
                    ),
                    Expanded(child: MeetingsList()),
                  ]),
                )))
      ],
    );
  }
}

class MeetingsList extends StatefulWidget {
  const MeetingsList({
    Key? key,
  }) : super(key: key);

  @override
  _MeetingsListState createState() => _MeetingsListState();
}

class _MeetingsListState extends State<MeetingsList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<MeetingBloc>(context);
    bloc.init();
    return Container(
        child: StreamBuilder<List<Meeting>>(
            stream: bloc.meetingStream,
            builder: (context, snapshot) {
              final results = snapshot.data;
              return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: (snapshot.hasData)
                      ? (results!.isEmpty)
                          ? NoObjectives() //
                          : ListView(
                              key: ValueKey(Random.secure()),
                              controller: scrollController,
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

  Widget _buildItem(Meeting meeting) {
    return TestProxy(
        key: ValueKey(meeting),
        child: new MeetingItem(
          onTap: () {},
          meeting: meeting,
        ));
  }
}

class MeetingPropertiesHeader {
  final String name;
  final int flex;

  MeetingPropertiesHeader(this.name, this.flex);
}

class MeetingsListHeader extends StatelessWidget {
  const MeetingsListHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MeetingPropertiesHeader> properties = [
      MeetingPropertiesHeader("Réunion", 4),
      MeetingPropertiesHeader("Date", 3),
      MeetingPropertiesHeader("Relié à", 3),
      MeetingPropertiesHeader("Participants", 2),
      MeetingPropertiesHeader("Commentaire", 3),
      MeetingPropertiesHeader("Statut", 2),
    ];
    return Container(
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
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: properties
                      .map(
                        (e) => Expanded(
                          child: Container(
                            child: Row(
                              children: [
                                Flexible(
                                    child: Text(e.name,
                                        overflow: TextOverflow.ellipsis,
                                        style: textStyle_Text_12_600)),
                              ],
                            ),
                          ),
                          flex: e.flex,
                        ),
                      )
                      .toList())),
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
    );
  }
}
