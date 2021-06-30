import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/Data/items.dart';

import 'custom_icon_button.dart';

class ProjectItem extends StatelessWidget {
  final String projectName;
  const ProjectItem({Key? key, required this.projectName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Visibility(
              visible: false,
              child: SizedBox(
                width: 2,
                child: Container(
                  color: Colors.lightGreen,
                ),
              )),
          SizedBox(
            width: 18,
          ),
          Expanded(
            child: ProjectName(
              projectName: projectName,
            ),
            flex: 2,
          ),
          SizedBox(
            width: 18,
          ),
          Expanded(
            child: ProjectDeadline(),
            flex: 1,
          ),
          SizedBox(
            width: 18,
          ),
          Expanded(
            child: ProjectTeamLeader(),
            flex: 1,
          ),
          SizedBox(
            width: 18,
          ),
          Expanded(
            child: ProjectStatus(),
            flex: 1,
          ),
          SizedBox(
            width: 20,
          ),
          ActionsMenu(),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}

class ProjectName extends StatelessWidget {
  final String projectName;
  const ProjectName({Key? key, required this.projectName}) : super(key: key);

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
            'Développement',
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
  const ProjectDeadline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '10 juillet 2021',
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
              'Dans 12 jours',
              style: TextStyle(
                  color: text.withOpacity(0.7),
                  fontSize: 11,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w500),
            ),
          ]),
    );
  }
}

class ProjectTeamLeader extends StatelessWidget {
  const ProjectTeamLeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            height: 30,
            width: 30,
            child: CircleAvatar(
              backgroundColor: Colors.white70,
              backgroundImage: AssetImage('images/uiface.jpg'),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            'Saidani Wael',
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
  const ProjectStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(child: StatusLabel(status: statusType.Completed)),
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
        return Container(
          height: 22,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: Colors.lightGreen.withOpacity(0.5),
          ),
          child: Center(
            child: Text(
              'Terminé',
              style: TextStyle(
                  color: Colors.lightGreen[900],
                  fontSize: 9,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w600),
            ),
          ),
        );
      case statusType.InProgress:
        return Container(
          height: 22,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: Colors.orangeAccent.withOpacity(0.5),
          ),
          child: Center(
            child: Text(
              'En cours',
              style: TextStyle(
                  color: Colors.orange[900],
                  fontSize: 9,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w600),
            ),
          ),
        );
    }
  }
}

class ActionsMenu extends StatelessWidget {
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
                          fontWeight : FontWeight.w500,
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
                      Text('Supprimer', style: TextStyle(
                        color: text,
                        fontSize: 12,
                        fontWeight : FontWeight.w500,
                      ),),
                      SizedBox(
                        width: 20,
                      )
                    ]),
                    value: 2),
              ]),
    );
  }
}
