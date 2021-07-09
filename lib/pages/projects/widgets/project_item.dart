import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/Data/project.dart';
import 'package:gestion_projets/routing/routes.dart';
import 'package:gestion_projets/services/navigation_service.dart';
import 'package:gestion_projets/widgets/custom_tag.dart';
import '../../../locator.dart';
import 'custom_icon_button.dart';
import 'dialogs.dart';

class ProjectItem extends StatelessWidget {
  final ProjectDataItem item;
  final Animation<double> animation;
  final VoidCallback onTap;
  const ProjectItem(
      {Key? key,
      required this.item,
      required this.animation,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      FadeTransition(
        opacity: animation,
        child: SizeTransition(
          sizeFactor: animation,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              hoverColor: active.withOpacity(0.015),
              onTap: () {
                print("tapped");
                locator<NavigationService>()
                    .navigateTo(projectDetailsPageRoute);
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
                        visible: (item.deadlineDays.isEmpty),
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
                        projectName: item.name,
                        projectType: item.type,
                      ),
                      flex: 3,
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    Expanded(
                      child: ProjectDeadline(
                        date: item.deadline,
                        days: (item.deadlineDays.isEmpty)
                            ? "En retard"
                            : item.deadlineDays,
                      ),
                      flex: 2,
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    Expanded(
                      child: ProjectTeamLeader(
                        teamLeader: item.teamLeader,
                      ),
                      flex: 2,
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    Expanded(
                      child: ProjectStatus(
                        status: item.status,
                      ),
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
                      onTap: () {
                        final snackBar = SnackBar(
                            behavior: SnackBarBehavior.fixed,
                            duration: Duration(milliseconds: 2000),
                            backgroundColor: dark.withOpacity(0.9),
                            content: Container(
                                child: Text(
                              "Modifier Développement d'une nouvelle interface utilisateur",
                              style: TextStyle(
                                  color: light,
                                  fontSize: 13,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w400),
                            )));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    CustomIconButton(
                        icon: Icons.delete_outline_rounded,
                        message: 'Supprimer',
                        color: Colors.redAccent,
                        onTap: () {
                          showDialogBox(context, onTap);
                        }),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      Divider(
        height: 1,
        color: dark.withOpacity(0.15),
      )
    ]);
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
            style: TextStyle(
                color: text,
                fontSize: 12,
                letterSpacing: 0,
                fontWeight: FontWeight.w600),
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
            Text(
              date,
              style: TextStyle(
                  color: text,
                  fontSize: 12,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w600),
            ),
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
  final TeamLeader teamLeader;

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
            child: CircleAvatar(
              child: Text(profileInitials(teamLeader.name),
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 9,
                      letterSpacing: 1)),
              foregroundColor: Colors.white,
              backgroundColor: /*Colors.deepPurpleAccent*/ colors[
                  int.tryParse(teamLeader.picture) ?? 0],
              // backgroundImage: AssetImage(teamLeader.picture),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            teamLeader.name,
            style: TextStyle(
                color: text,
                fontSize: 12,
                letterSpacing: 0,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class ProjectStatus extends StatelessWidget {
  final statusType status;

  const ProjectStatus({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(child: StatusLabel(status: status)),
        ]);
  }
}

enum statusType { Completed, InProgress }

class StatusLabel extends StatelessWidget {
  final statusType status;
  const StatusLabel({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case statusType.Completed:
        return CustomTag(
          text: 'Terminé',
          color: Color(0xFF0AC1EC),
          /* icon: Padding(padding: EdgeInsets.only(right: 3), child: Icon(Icons.check_rounded , color: Colors.white, size: 12,),),*/
        );
      case statusType.InProgress:
        return CustomTag(
          text: 'En cours',
          color: Color(0xFFFFA800),
          /*icon: Padding(padding: EdgeInsets.only(right: 3), child: Icon(Icons.more_horiz_rounded , color: Colors.white, size: 12,),),*/
        );
    }
  }
}
//old Action Menu with button

/*class ActionsMenu extends StatelessWidget {
  const ActionsMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
      )),
      child: PopupMenuButton<Object>(
          padding: EdgeInsets.symmetric(vertical: 0),
          tooltip: "",
          icon: Icon(
            Icons.more_vert_rounded,
            size: 20,
            color: text.withOpacity(0.7),
          ),
          // child: CustomIconButton(icon: Icons.more_vert_rounded, message: 'Actions'),
          onSelected: (selectedValue) {
            // print(selectedValue);
          },
          itemBuilder: (context) => [
                PopupMenuItem(
                    height: 40,
                    child: Row(children: [
                      Icon(
                        Icons.edit_rounded,
                        size: 20,
                        color: text,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Modifier',
                        style: TextStyle(
                          color: text,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      )
                    ]),
                    value: 1),
                PopupMenuDivider(
                  height: 1,
                ),
                PopupMenuItem(
                    height: 40,
                    child: Row(children: [
                      Icon(
                        Icons.delete_outline_rounded,
                        size: 20,
                        color: text,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Supprimer',
                        style: TextStyle(
                          color: text,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      )
                    ]),
                    value: 2),
              ]),
    );
  }
}*/
