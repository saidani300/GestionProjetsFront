import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/Data/project.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/bloc_provider.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/project_bloc.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data/phase.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data/user.dart';
import 'package:gestion_projets/routing/routes.dart';
import 'package:gestion_projets/services/navigation_service.dart';
import 'package:gestion_projets/widgets/custom_tag.dart';
import 'package:gestion_projets/widgets/profile_avatar.dart';
import 'package:intl/intl.dart';
import '../../../locator.dart';
import 'custom_icon_button.dart';
import 'dialogs.dart';

class ProjectItem extends StatefulWidget {
  final Project project;

  const ProjectItem({
    Key? key,
    required this.project,
  }) : super(key: key);

  @override
  _ProjectItemState createState() => _ProjectItemState();
}

class _ProjectItemState extends State<ProjectItem>
    with AutomaticKeepAliveClientMixin<ProjectItem>, TickerProviderStateMixin {
  String getText(DateTime date) => DateFormat.yMMMMd('fr_FR').format(date);
  late AnimationController _controller;
  late Animation<double> _animation;

  initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this, value: 0);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
  }

  @override
  dispose() {
    print("Disposed " + widget.hashCode.toString());
    _controller.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ProjectBloc>(context);
    super.build(context);
    return FadeTransition(
        opacity: _animation,
        child: SizeTransition(
            sizeFactor: _animation,
            child: Material(
                color: Colors.transparent,
                child: Column(children: [
                  InkWell(
                    hoverColor: active.withOpacity(0.015),
                    onTap: () {
                      print("tapped");
                      locator<NavigationService>()
                          .projectNavigateTo(projectDetailsPageRoute);
                    },
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Container(
                      height: 84,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Visibility(
                              replacement: SizedBox(
                                width: 2,
                              ),
                              visible: (widget.project.endDate
                                  .isBefore(DateTime.now())),
                              child: SizedBox(
                                width: 2,
                                child: Container(
                                  color: lightRed,
                                ),
                              )),
                          SizedBox(
                            width: 18,
                          ),
                          Expanded(
                            child: ProjectName(
                              projectName: widget.project.name,
                              projectType: widget.project.type,
                            ),
                            flex: 3,
                          ),
                          SizedBox(
                            width: 18,
                          ),
                          Expanded(
                            child: ProjectDeadline(
                              date: getText(widget.project.endDate),
                              days: (widget.project.endDate
                                      .isBefore(DateTime.now()))
                                  ? "En retard"
                                  : widget.project.endDate
                                              .difference(DateTime.now())
                                              .inDays ==
                                          0
                                      ? "Aujourd'hui"
                                      : "Dans " +
                                          widget.project.endDate
                                              .difference(DateTime.now())
                                              .inDays
                                              .toString() +
                                          " jours",
                            ),
                            flex: 2,
                          ),
                          SizedBox(
                            width: 18,
                          ),
                          Expanded(
                            child: ProjectTeamLeader(
                              teamLeader: widget.project.teamLeader,
                            ),
                            flex: 2,
                          ),
                          SizedBox(
                            width: 18,
                          ),
                          Expanded(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: StatusTag(
                                        status: widget.project.status),
                                  )
                                ]),
                            flex: 1,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          // ActionsMenu(),
                          CustomIconButton(
                            icon: Icons.edit_outlined,
                            message: 'Modifier',
                            size: 16,
                            onTap: () {},
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          CustomIconButton(
                              icon: Icons.delete_outline_rounded,
                              message: 'Supprimer',
                              color: Colors.redAccent,
                              onTap: () {
                                showDialogBox(context, () {
                                  _controller.reverse().whenComplete(
                                      () => bloc.remove(widget.project));
                                });
                              }),
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: dividerColor,
                  )
                ]))));
  }
}

class ProjectName extends StatelessWidget {
  final String projectName;
  final String projectType;

  const ProjectName(
      {Key? key, required this.projectName, required this.projectType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            projectName,
            overflow: TextOverflow.ellipsis,
            style: textStyle_Text_12_600
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            projectType,
            style: TextStyle(
                color: text.withOpacity(0.7),
                fontSize: 11,
                letterSpacing: 0,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class ProjectDeadline extends StatelessWidget {
  final String date;
  final String days;

  const ProjectDeadline({Key? key, required this.date, required this.days})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                child: Text(
              date,
              overflow: TextOverflow.ellipsis,
              style: textStyle_Text_12_600
            )),
            SizedBox(
              height: 5,
            ),
            Text(
              days,
              style: TextStyle(
                  color: (days.startsWith("En retard"))
                      ? lightRed
                      : text.withOpacity(0.7),
                  fontSize: 11,
                  letterSpacing: 0,
                  fontWeight: (days.startsWith("En retard"))
                      ? FontWeight.w600
                      : FontWeight.w500),
            ),
          ]),
    );
  }
}

String profileInitials(String name) {
  var nameParts = name.split(" ");
  String initials =
      nameParts[0][0].toUpperCase() + nameParts[1][0].toUpperCase();
  return initials;
}

final List<Color> colors = [
  Color(0xFFcbe11e),
  Color(0xFF1ecbe1),
  Color(0xFFB0C33C),
  Color(0xFF961ee1),
  Color(0xFFeab015),
  Color(0xFFf2497b),
  Color(0xFFf26b49),
  Color(0xFF2ED1C5),
  Color(0xFFFF5959),
  Color(0xFF808080)
];

class ProjectTeamLeader extends StatelessWidget {
  final User teamLeader;

  const ProjectTeamLeader({Key? key, required this.teamLeader})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
              height: 30,
              width: 30,
              child: Avatar(
                picture: teamLeader.avatar,
                name: teamLeader.name,
              )),
          SizedBox(
            width: 15,
          ),
          Flexible(
              child: Text(
            teamLeader.name,
            overflow: TextOverflow.ellipsis,
            style: textStyle_Text_12_600
          )),
        ],
      ),
    );
  }
}

class StatusTag extends StatelessWidget {
  final Status status;
  final String date;

  const StatusTag({Key? key, required this.status, this.date = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case Status.completed:
        return CustomTag(text: 'Terminé', color: lightBlue, date: date
            /* icon: Padding(padding: EdgeInsets.only(right: 3), child: Icon(Icons.check_rounded , color: white, size: 12,),),*/
            );
      case Status.inProgress:
        return CustomTag(
          text: 'En cours',
          color: lightOrange,
          /*icon: Padding(padding: EdgeInsets.only(right: 3), child: Icon(Icons.more_horiz_rounded , color: white, size: 12,),),*/
        );
      case Status.approved:
        return CustomTag(text: 'Approuvé', color: lightPurple, date: date
            /*icon: Padding(padding: EdgeInsets.only(right: 3), child: Icon(Icons.more_horiz_rounded , color: white, size: 12,),),*/
            );
    }
  }
}
