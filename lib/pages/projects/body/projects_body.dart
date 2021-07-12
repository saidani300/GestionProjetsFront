import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/controllers.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/Data/items.dart';
import 'package:gestion_projets/pages/projects/Data/project.dart';
import 'package:gestion_projets/pages/projects/filter/filter_container.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/pages/projects/widgets/dialogs.dart';
import 'package:gestion_projets/pages/projects/widgets/messages.dart';
import 'package:gestion_projets/pages/projects/widgets/project_item.dart';
import 'package:gestion_projets/pages/projects/widgets/search_text_field.dart';
import 'package:gestion_projets/pages/projects/widgets/show_by_status_item.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
//TODO : Add number of projects
//TODO: Change add project button, more height and make it global style
//TODO: Change project status tag , it's ugly
//TODO: Select multiple projects
bool _firstChild = true;
DateTime startDate = DateTime.now();
DateTime endDate = DateTime.now();
var orderBy = "Project".obs ;
var isAscending = true.obs ;
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
  final VoidCallback onTap;
  const ProjectsPageHeader({
    Key? key,
    required this.onTap,
  }) : super(key: key);

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
        //TODO : Active Export to files , Add more files types options, fix ugly button and change position.

        //TODO: Fix Button ,ugly too
        TextButton.icon(
          style: ButtonStyle(
            fixedSize:
                MaterialStateProperty.all<Size>(Size(double.infinity, 40)),
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
          onPressed: /*onTap*/(){showCreateProjectDialogBox(context , onTap);},
          icon: Icon(
            Icons.add,
            color: Colors.white,
            size: 16,
          ),
          label: Text(
            'Créer un projet',
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
}

/*_______________________________________________________________________*/
/*_______________________________________________________________________*/
/*_______________________________________________________________________*/
/*_______________________________________________________________________*/
/*_______________________________________________________________________*/
//GlobalKey<ProjectsList> _myKey = GlobalKey();
class ProjectsList extends State<ProjectsPageBody> {
  var listKey = GlobalKey<AnimatedListState>();
  var filterStatus = showbystatusController.activeItem.value;
  List<ProjectDataItem> _foundProjects = [];
  List<ProjectDataItem> projectsByStatus = Data.projectsList;

  @override
  initState() {
    _foundProjects = projectsByStatus;
    searchWithFilter(query);
    super.initState();
  }

  void searchWithFilter(String enteredKeyword) {
    listKey = new GlobalKey<AnimatedListState>();
    List<ProjectDataItem> results = [];

    switch (filterStatus) {
      case ('Tous'):
        projectsByStatus = Data.projectsList;
        break;
      case ('Terminé'):
        projectsByStatus = Data.projectsList
            .where((project) => identical(project.status, statusType.Completed))
            .toList();
        break;
      case ('En cours'):
        projectsByStatus = Data.projectsList
            .where(
                (project) => identical(project.status, statusType.InProgress))
            .toList();
        break;
    }
    if (enteredKeyword.isEmpty) {
      results = projectsByStatus;
    } else {
      results = projectsByStatus
          .where((project) =>
              project.name
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              project.teamLeader.name
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      query = enteredKeyword;
      _foundProjects = results;
    });
  }

  void OrderList(String orderBy , bool isAscending , )
  {
    setState(() {
    switch(orderBy){
      case('Project'):
        (isAscending) ? _foundProjects.sort((a, b) => a.name.compareTo(b.name)) :
        _foundProjects.sort((a, b) => b.name.compareTo(a.name));
        break;
        //TODO: fix Sort by Date

      case('DeadLine'):
        (isAscending) ? _foundProjects.sort((a, b) => a.deadline.compareTo(b.deadline)) :
        _foundProjects.sort((a, b) => b.deadline.compareTo(a.deadline));
        break;
      case('Leader'):
        (isAscending) ? _foundProjects.sort((a, b) => a.teamLeader.name.compareTo(b.teamLeader.name)) :
        _foundProjects.sort((a, b) => b.teamLeader.name.compareTo(a.teamLeader.name));
        break;
      case('Status'):
        (isAscending) ? _foundProjects.sort((a, b) => a.status.toString().compareTo(b.status.toString())) :
        _foundProjects.sort((a, b) => b.status.toString().compareTo(a.status.toString()));
        break;
    }
    });
  }

  void insertItem(int index, ProjectDataItem item) {
    Data.projectsList.insert(index, item);
    searchWithFilter(query);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ProjectsPageHeader(
          onTap: () {
            insertItem(
                0,
                new ProjectDataItem(
                    "Développement d'une nouvelle interface utilisateur",
                    "Développement",
                    "10 juillet 2021",
                    "Dans 12 jours",
                    new TeamLeader("Saidani Wael", "7"),
                    statusType.InProgress));
          },
        ),
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
                                        setState(() {
                                          filterStatus = e.name;
                                        });
                                        searchWithFilter(query);
                                        print(filterStatus);
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
                            icon: Icons.save_alt_rounded, message: 'Exporter', onTap: () {showExportDialogBox(context);}),
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
                        Filter(apply: () {
                          setState(() {
                            _firstChild = !_firstChild;
                          });
                        }),
                      ]),
                      crossFadeState: _firstChild
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      duration: Duration(milliseconds: 200),
                    ),
                    Divider(
                      height: 1,
                      color: dark.withOpacity(0.15),
                    ),
                    ProjectsListHeader(tapOrderBy: () { OrderList(orderBy.value ,isAscending.value); }, ),
                    Divider(
                      height: 1,
                      color: dark.withOpacity(0.15),
                    ),
                    Expanded(
                      child: (_foundProjects.length > 0)
                          ? AnimatedList(
                              key: listKey,
                              shrinkWrap: true,
                              initialItemCount: _foundProjects.length,
                              itemBuilder: (context, index, animation) {
                                final project = _foundProjects[index];
                                return buildItem(project, index, animation);
                              })
                          : (_foundProjects.length == 0 && query.isNotEmpty)
                              ? NoResultFound()
                              : (Data.projectsList
                                          .where((project) => identical(
                                              project.status,
                                              statusType.InProgress))
                                          .toList()
                                          .length !=
                                      0)
                                  ? NoCompletedProjects()
                                  : NoProjects(),
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
        onChanged: (value) => searchWithFilter(value),
      );

  Widget buildItem(item, int index, Animation<double> animation) {
    //print(_foundProjects.length.toString());
    return ProjectItem(
      item: item,
      animation: animation,
      onTap: () => removeItem(index, item),
    );
  }

  void removeItem(int index, ProjectDataItem item) {
    Data.projectsList.remove(item);
    listKey.currentState!.removeItem(
      index,
      (context, animation) => buildItem(item, index, animation),
    );
    Future.delayed(Duration(milliseconds: 350), () => searchWithFilter(query));
    print(filterStatus);
  }
}
/*_______________________________________________________________________*/
/*_______________________________________________________________________*/
/*_______________________________________________________________________*/
/*_______________________________________________________________________*/
/*_______________________________________________________________________*/

class ProjectsListHeader extends StatelessWidget {
  final Function() tapOrderBy;

  const ProjectsListHeader({Key? key,required this.tapOrderBy}) : super(key: key);
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
                    InkWell(onTap:(){
            orderBy.value = "Project";
            isAscending.value = !isAscending.value;
            tapOrderBy();
            }
                , child: Obx(() =>  Wrap( crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          "Projet",
                          style: TextStyle(
                              color: text,
                              fontSize: 12,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w600),
                        ),
                      Visibility(visible: (orderBy.value.contains("Project")), child:Icon((isAscending.value) ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded, size: 12)),
                      ]))),
                ])),
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
                    InkWell(onTap:(){
                      orderBy.value = "DeadLine";
                      isAscending.value = !isAscending.value;
                      tapOrderBy();
                      }
                    , child: Obx(() => Wrap( crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            "Date limite",
                            style: TextStyle(
                                color: text,
                                fontSize: 12,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w600),
                          ),
                          Visibility(visible: (orderBy.value.contains("DeadLine")), child:Icon((isAscending.value) ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded, size: 12)),
                        ])),
                    )]),
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
                  InkWell(onTap:(){
            orderBy.value = "Leader";
            isAscending.value = !isAscending.value;
            tapOrderBy();
            }
              , child: Obx(() =>  Wrap( crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            "Chef d'équipe",
                            style: TextStyle(
                                color: text,
                                fontSize: 12,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w600),
                          ),
                          Visibility(visible: (orderBy.value.contains("Leader")), child:Icon((isAscending.value) ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded, size: 12)),
                        ]))),

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
                  InkWell(onTap:(){
            orderBy.value = "Status";
            isAscending.value = !isAscending.value;
            tapOrderBy();
            }
              , child: Obx(() =>  Wrap( crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            "Statut",
                            style: TextStyle(
                                color: text,
                                fontSize: 12,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w600),
                          ),
                          Visibility(visible: (orderBy.value.contains("Status")), child:Icon((isAscending.value) ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded, size: 12)),
                        ]))),
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
