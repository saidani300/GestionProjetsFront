import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/meeting_bloc.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/dialogs/create_meeting_dialog.dart';
import 'package:gestion_projets/pages/projects/project_details/meetings/data/meeting.dart';
import 'package:gestion_projets/pages/projects/project_details/meetings/data/meeting_filter_data.dart';
import 'package:gestion_projets/pages/projects/project_details/meetings/filter/meeting_filter.dart';
import 'package:gestion_projets/pages/projects/project_details/meetings/filter/widgets/meeting_order_by.dart';
import 'package:gestion_projets/pages/projects/project_details/meetings/widgets/meeting_item.dart';
import 'package:gestion_projets/pages/projects/project_details/meetings/widgets/view_types.dart';
import 'package:gestion_projets/pages/projects/project_details/structure/body/project_overview_body.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/messages.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/multi_options_button.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/pages/projects/widgets/search_text_field.dart';
import 'package:gestion_projets/services/navigation_service.dart';

import '../../../../../locator.dart';

class ProjectMeetingsHeader extends StatelessWidget {
  final ScrollController scrollController;

  const ProjectMeetingsHeader({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

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
        Text("D??veloppement d'une nouvelle interface utilisateur",
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
        Text("R??unions", style: textStyle_Text_12_600),
        SizedBox(
          width: 2,
        ),
        Padding(
            padding: EdgeInsets.only(top: 2),
            child: CustomIconButton(
              icon: Icons.info,
              message: "R??unions",
              onTap: () {},
              size: 17,
            )),
        Expanded(child: Container()),
        MultiOptionsButton(
          text: "Cr??er une r??union",
          isMultiple: false,
          onTap: () {
            createMeetingDialogBox(context, scrollController);
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
    final bloc = BlocProvider.of<MeetingBloc>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ProjectMeetingsHeader(
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
                        MeetingShowByViewMenu(),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(child: Container()),
                        SearchWidget(
                          hintText: 'Rechercher des r??unions...',
                          onChanged: (value) {
                            meetingFilter.searchQuery = value;
                            bloc.fetch();

                          },
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
                        MeetingFilterMenu(),
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
                    Expanded(
                        child: MeetingsList(
                      scrollController: controller,
                    )),
                  ]),
                )))
      ],
    );
  }
}

class MeetingsList extends StatefulWidget {
  final ScrollController scrollController;

  const MeetingsList({
    Key? key,
    required this.scrollController,
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
                          ? NoItems(
                              icon: "icons/no-phase.svg",
                              message:
                                  "Il n'y a aucune r??union planifi??e ?? afficher pour vous, actuellement vous n'en avez pas mais vous pouvez en cr??er une nouvelle et inviter des membres de l'??quipe.",
                              title: "Aucune r??union planifi??e",
                              buttonText: "Cr??er",
                              onTap: () {
                                createMeetingDialogBox(
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

  Widget _buildItem(Meeting meeting) {
    return TestProxy(
        key: ValueKey(meeting),
        child: new MeetingItem(
          onTap: () {},
          meeting: meeting,
        ));
  }
}

class MeetingsListHeader extends StatelessWidget {
  const MeetingsListHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            child: Container(
              child: Row(
                children: [
                  Flexible(
                      child: Text("R??union",
                          overflow: TextOverflow.ellipsis,
                          style: textStyle_Text_12_600)),
                ],
              ),
            ),
            flex: 4,
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              child: Row(
                children: [
                  Flexible(
                      child: Text("Date",
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
                      child: Text("Heure",
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
            child: Container(
              child: Row(
                children: [
                  Flexible(
                      child: Text("Participants",
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
            child: Container(
              child: Row(
                children: [
                  Flexible(
                      child: Text("Commentaire",
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
                      child: Text("Statut",
                          overflow: TextOverflow.ellipsis,
                          style: textStyle_Text_12_600)),
                ],
              ),
            ),
            flex: 2,
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: 40,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(child: Container()),
                MeetingOrderBy(widgetHeight: 30)
              ],
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
