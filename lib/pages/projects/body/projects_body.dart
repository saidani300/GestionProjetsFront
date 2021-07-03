import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/controllers.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/Data/items.dart';
import 'package:gestion_projets/pages/projects/Data/project.dart';
import 'package:gestion_projets/pages/projects/filter/filter_container.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/pages/projects/widgets/project_item.dart';
import 'package:gestion_projets/pages/projects/widgets/search_text_field.dart';
import 'package:gestion_projets/pages/projects/widgets/show_by_status_item.dart';
bool _firstChild = true;

List<ProjectDataItem> projects = Data.projectsList;
String query = '';

class ProjectsPageBody extends StatefulWidget {
  @override
  ProjectsList createState() => ProjectsList();
}

/*_______________________________________________________________________*/
/*_______________________________________________________________________*/
/*_______________________________________________________________________*/
/*_______________________________________________________________________*/
/*_______________________________________________________________________*/

class ProjectsPageHeader extends StatelessWidget {
  final GlobalKey<AnimatedListState> listKey;

  const ProjectsPageHeader({Key? key, required this.listKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //SvgPicture.asset("icons/Projects.svg" , width: 20, height: 20,),
        Icon(
          Icons.layers_rounded,
          size: 20,
          color: active,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          'Projets',
          style: TextStyle(
              color: dark,
              fontSize: 20,
              letterSpacing: 0,
              fontWeight: FontWeight.w500),
        ),
        Expanded(child: Container()),
        Tooltip(
          message: 'Exporter CSV',
          child: OutlinedButton(
            onPressed: () {},
            child: Icon(
              Icons.download_rounded,
              size: 20,
              color: active,
            ),
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all<Size>(Size(35, 35)),
              side: MaterialStateProperty.resolveWith<BorderSide?>((states) {
                return BorderSide(
                    color: (states.contains(MaterialState.hovered))
                        ? active
                        : active.withOpacity(0.5),
                    width: 1.2);
              }),
              backgroundColor:
                  MaterialStateProperty.resolveWith<Color?>((states) {
                return (states.contains(MaterialState.hovered))
                    ? active.withOpacity(0.02)
                    : Colors.transparent;
              }),
              //foregroundColor: Colors.white,
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        TextButton.icon(
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
          onPressed: () => insertItem(0, Data.projectsList.first),
          icon: Icon(
            Icons.add,
            color: Colors.white,
            size: 16,
          ),
          label: Text(
            'Créer un projet ',
            style: TextStyle(
                color: Colors.white,
                fontSize: 11.5,
                letterSpacing: 0,
                fontWeight: FontWeight.w400),
          ),
        )
      ],
    );
  }

  insertItem(int index, ProjectDataItem item) {
    projects.insert(index, item);
    listKey.currentState!.insertItem(index);

  }
}

/*_______________________________________________________________________*/
/*_______________________________________________________________________*/
/*_______________________________________________________________________*/
/*_______________________________________________________________________*/
/*_______________________________________________________________________*/

class ProjectsList extends State<ProjectsPageBody> {
  var listKey = GlobalKey<AnimatedListState>();
  List<ProjectDataItem> _foundProjects = [];
  /*initState() {
    super.initState();
    projects = Data.projectsList;
  }*/

  /////////First method
  ////////////////////////////////////////////
  @override
  initState() {
    _foundProjects = Data.projectsList;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    listKey = new GlobalKey<AnimatedListState>();

    List<ProjectDataItem> results = [];
    if (enteredKeyword.isEmpty) {
      results = Data.projectsList;
    } else {
      results = Data.projectsList
          .where((project) =>
          project.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundProjects = results;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ProjectsPageHeader(listKey: listKey),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(top: 20),
            child: Container(
                decoration: BoxDecoration(
                  border:
                      Border.all(color: lightGrey.withOpacity(0.3), width: 1),
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
                                      if (!showbystatusController
                                          .isActive(e.name)) {
                                        showbystatusController
                                            .changeActiveItemTo(e.name);
                                      }
                                    })),
                          ).toList(),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(child: Container()),
                        buildSearch(),
                        SizedBox(
                          width: 15,
                        ),
                        CustomIconButton(
                            icon: Icons.calendar_today_outlined,
                            message: 'Tri par date',
                            size: 15,
                            onTap: () {}),
                        SizedBox(
                          width: 15,
                        ),
                        CustomIconButton(
                            icon: Icons.sort, message: 'Trier', onTap: () {}),
                        SizedBox(
                          width: 15,
                        ),
                        CustomIconButton(
                          icon: Icons.filter_alt_outlined,
                          message: 'Filter',
                          onTap: () {
                            setState(() {
                              _firstChild = !_firstChild;
                            });
                          },
                        ),
                        SizedBox(
                          width: 15,
                        ),
                      ]),
                    ),
                    /* Divider(
                      height: 1,
                      color: dark.withOpacity(0.15),
                    ),*/
                    /*   Filter(),
                    Divider(
                      height: 1,
                      color: dark.withOpacity(0.15),
                    ),*/

                    AnimatedCrossFade(
                      firstCurve: Curves.easeIn,
                      secondCurve: Curves.easeOut,
                      firstChild: Container(),
                      secondChild: Column(children: [
                        Container(
                          height: 1,
                          color: dark.withOpacity(0.15),
                        ),
                        Filter(),
                      ]),
                      crossFadeState: _firstChild
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      duration: Duration(milliseconds: 300),
                    ),
                    Divider(
                      height: 1,
                      color: dark.withOpacity(0.15),
                    ),
                    ProjectsListHeader(),
                    Divider(
                      height: 1,
                      color: dark.withOpacity(0.15),
                    ),
                    Expanded(
                      child: (_foundProjects.length > 0)
                          ? /*ListView.builder(
                              itemCount: projects.length,
                              itemBuilder: (context, index) {
                                final project = projects[index];

                                return buildItem(5project, 0);
                              },
                            )*/
                      AnimatedList(

                      key: listKey,
                      shrinkWrap: true,
                      initialItemCount: _foundProjects.length,
                      itemBuilder: (context, index, animation) {
                        final project = _foundProjects[index];
                      return  buildItem(project, index, animation);
                      }
                    )
                          : Text(
                              'No results found',
                              style: TextStyle(fontSize: 24),
                            ),
                    ),
                    Container(),
                  ],
                )),
          ),
  )
      ],
    );
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Rechercher des projets...',
        onChanged: (value) => _runFilter(value),
      );

  void searchProject(String searchQuery) {
    listKey = new GlobalKey<AnimatedListState>();
    final newProjects = Data.projectsList.where((project) {
      final nameLower = project.name.toLowerCase();
      final leaderLower = project.teamLeader.name.toLowerCase();
      final searchLower = searchQuery.toLowerCase();

      return nameLower.contains(searchLower) ||
          leaderLower.contains(searchLower);
    }).toList();
    setState(() {
      query = searchQuery;
      projects = newProjects;
    });
  }

  Widget buildItem(item, int index , Animation<double> animation) {
    //print(_foundProjects.length.toString());
    return ProjectItem(
      item: item,
       animation: animation,
       onTap: () => removeItem(index),
    );
  }

   void removeItem(int index) {
    final item = Data.projectsList.removeAt(index);

    listKey.currentState!.removeItem(
      index,
      (context, animation) => buildItem(item, index, animation),
    );
  }

}
/*_______________________________________________________________________*/
/*_______________________________________________________________________*/
/*_______________________________________________________________________*/
/*_______________________________________________________________________*/
/*_______________________________________________________________________*/

class ProjectsListHeader extends StatelessWidget {
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
                  children: [
                    Text(
                      'Projet',
                      style: TextStyle(
                          color: text,
                          fontSize: 12,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w600),
                    ),
                  ]),
            ),
            flex: 3,
          ),
          SizedBox(
            width: 18,
          ),
          Expanded(
            child: Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Date limite',
                      style: TextStyle(
                          color: text,
                          fontSize: 12,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w600),
                    ),
                  ]),
            ),
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
                  children: [
                    Text(
                      "Chef d'équipe",
                      style: TextStyle(
                          color: text,
                          fontSize: 12,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w600),
                    ),
                  ]),
            ),
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
                  children: [
                    Text(
                      "Statut",
                      style: TextStyle(
                          color: text,
                          fontSize: 12,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w600),
                    ),
                  ]),
            ),
            flex: 1,
          ),
          SizedBox(
            width: 18,
          ),
          Text(
            "Actions",
            style: TextStyle(
                color: text,
                fontSize: 12,
                letterSpacing: 0,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}

class AnimatedFilterContainer extends StatelessWidget {
  const AnimatedFilterContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
