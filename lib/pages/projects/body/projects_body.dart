import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/controllers.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/Data/items.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/pages/projects/widgets/project_item.dart';
import 'package:gestion_projets/pages/projects/widgets/show_by_status_item.dart';

class ProjectsPageBody extends StatelessWidget {
  const ProjectsPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 20),
        child: SizedBox(child:Container(
            decoration: BoxDecoration(
              border: Border.all(color: lightGrey.withOpacity(0.3), width: 1),
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
            child: Column(
              children: [
                Container(
                    alignment: Alignment.bottomLeft,
                    child: Row(children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: ShowByStatusItems.map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: ShowByStatusItem(
                              itemName: e.name,
                              onTap: () {
                                if (!showbystatusController.isActive(e.name)) {
                                  showbystatusController
                                      .changeActiveItemTo(e.name);
                                }
                              })),
                        ).toList(),
                      ),
                      Expanded(child: Container(
                        )),
                      CustomIconButton(icon: Icons.calendar_today_outlined, message: 'Tri par date', size: 15,),
                      SizedBox(width: 15,),
                      CustomIconButton(icon: Icons.sort,message: 'Trier'),
                      SizedBox(width: 15,),
                      CustomIconButton(icon: Icons.filter_list_rounded, message: 'Filter'),
                      SizedBox(width: 15,),

                    ]),
                ),
                Divider(height: 1, color: dark.withOpacity(0.15),),
                ProjectsListHeader(),
                Divider(height: 1, color: dark.withOpacity(0.15),),

            Expanded(child:ProjectsList()),
              Container(),
              ],
            )),
      )),
    );
  }
}

class ProjectsListHeader extends StatelessWidget {
  const ProjectsListHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(
              'Projet',
              style: TextStyle(
                  color: text,
                  fontSize: 12,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w600),
            ),]),),
            flex: 2,
          ),
          SizedBox(
            width: 18,
          ),
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(
              'Date limite',
              style: TextStyle(
                  color: text,
                  fontSize: 12,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w600),
            ),]),),
            flex: 1,
          ),
          SizedBox(
            width: 18,
          ),
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(
              "Chef d'équipe",
              style: TextStyle(
                  color: text,
                  fontSize: 12,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w600),
            ),]),),
            flex: 1,
          ),
          SizedBox(
            width: 18,
          ),
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(
              "Statut",
              style: TextStyle(
                  color: text,
                  fontSize: 12,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w600),
            ),]),),
            flex: 1,
          ),
          SizedBox(
            width: 80,
          ),

        ],
      ),
    );
  }
}

class ProjectsList extends StatelessWidget {
  const ProjectsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
    Expanded(child: Container( child:
    ListView(shrinkWrap: true,
        children: [
          ProjectItem(projectName: "Développement d'une nouvelle interface utilisateur"),
          Divider(height: 1, color: dark.withOpacity(0.15),),
          ProjectItem(projectName: "Développement d'une nouvelle interface utilisateur pour le Tableau de board"),
          Divider(height: 1, color: dark.withOpacity(0.15),),
          ProjectItem(projectName: "Développement d'une nouvelle interface utilisateur"),
          Divider(height: 1, color: dark.withOpacity(0.15),),
          /*ProjectItem(projectName: "Développement d'une nouvelle interface utilisateur"),
          Divider(height: 1, color: dark.withOpacity(0.15),),
          ProjectItem(projectName: "Développement d'une nouvelle interface utilisateur"),
          Divider(height: 1, color: dark.withOpacity(0.15),),
          ProjectItem(projectName: "Développement d'une nouvelle interface utilisateur"),
          Divider(height: 1, color: dark.withOpacity(0.15),),

          ProjectItem(projectName: "Développement d'une nouvelle interface utilisateur"),
          Divider(height: 1, color: dark.withOpacity(0.15),),
          ProjectItem(projectName: "Développement d'une nouvelle interface utilisateur"),
          Divider(height: 1, color: dark.withOpacity(0.15),),
          ProjectItem(projectName: "Développement d'une nouvelle interface utilisateur"),
          Divider(height: 1, color: dark.withOpacity(0.15),),
          ProjectItem(projectName: "Développement d'une nouvelle interface utilisateur"),
          Divider(height: 1, color: dark.withOpacity(0.15),),*/
        ])));
  }
}
