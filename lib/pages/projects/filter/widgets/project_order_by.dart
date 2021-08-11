import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/project_bloc.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/filter/Data/project_filter.dart';

import '../../../../helpers/custom_icon_popupmenu.dart';

class ProjectOrderBy extends StatefulWidget {
  final double widgetHeight;
  final double popupMenuWidth;
  const ProjectOrderBy({
    Key? key,
    this.widgetHeight = 40,
    this.popupMenuWidth = 200,
  }) : super(key: key);

  @override
  _ProjectOrderByState createState() => _ProjectOrderByState();
}

class _ProjectOrderByState extends State<ProjectOrderBy> {
  String orderBy = projectOrderByAsText(projectListOrder.orderBy);
  bool isAscending = true;
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return CustomIconListPopupMenuButton(
                    containerHeight: widget.widgetHeight,
                    offset: Offset(0, widget.widgetHeight + 2),
                    child:
                    Tooltip(
                      message: 'Trier par',
                      child: SizedBox(
                        child: MouseRegion(
                          onEnter: (PointerEvent event) => setState(() => isHover = true),
                          onExit: (PointerEvent event) => setState(() => isHover = false),
                          child: Icon(
                            Icons.sort_by_alpha_rounded,
                            color: isHover ? active : text.withOpacity(0.7),
                            size: 17,
                          ),
                        ),
                      ),
                    ),
                    enabled: true,
                    itemBuilder: (context) {
                      return [
                      CustomIconListPopupMenuItem(
                          value: 1,
                          enabled: false,
                          child: Container(
                              height: 161,
                              width: 150,
                              child:ProjectOrderByListView(onSelectPropriety: (String value) { setState(() {orderBy = value;}); },
                              setAscending: (bool value) { },)))
                      ];
              });
  }
}

class ProjectOrderByListView extends StatefulWidget {
   final Function(String value) onSelectPropriety;
   final Function(bool value) setAscending;
  const ProjectOrderByListView({Key? key,required this.onSelectPropriety , required this.setAscending}) : super(key: key);

  @override
  _ProjectOrderByListViewState createState() => _ProjectOrderByListViewState();
}

class _ProjectOrderByListViewState extends State<ProjectOrderByListView> {
  bool isAscending = projectListOrder.isAscending;
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ProjectBloc>(context);
    ScrollController controller = new ScrollController();
    return Scrollbar(
            isAlwaysShown: true,
            controller: controller,
            child: ListView(
                controller: controller,
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    horizontalTitleGap: 0,
                    dense: true,
                    tileColor: white,
                    minLeadingWidth: 0,
                    leading: isAscending ? Icon(Icons.check_rounded , size: 15, color: active,) : Container(height: 15, width: 15,),
                    title: Row(children: [ SizedBox(width: 10,), Flexible(child: Text('Ascendant',overflow: TextOverflow.ellipsis, style: textStyle_Text_12_500,)),],),
                    onTap: () async {
                      projectListOrder.isAscending = true;
                      setState(() {
                        isAscending = true;
                      });
                      bloc.fetch();
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    horizontalTitleGap: 0,
                    dense: true,
                    tileColor: white,
                    minLeadingWidth: 0,
                    leading: !isAscending ? Icon(Icons.check_rounded , size: 15, color: active,) : Container(height: 15, width: 15,),
                    title: Row(children: [ SizedBox(width: 10,), Flexible(child: Text('Descendant',overflow: TextOverflow.ellipsis, style: textStyle_Text_12_500,)),],),
                    onTap: () async {
                      projectListOrder.isAscending = false;
                      setState(() {
                        isAscending = false;
                      });
                      bloc.fetch();
                    },
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: dividerColor,
                  ),
                  ...ProjectOrderByProperties.values
                      .map((e) {
                        bool isChecked = projectListOrder.orderBy == e;
                        return ListTile(
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 10),
                    horizontalTitleGap: 0,
                    minLeadingWidth: 0,
                    dense: true,
                    tileColor: white,
                    leading: isChecked ? Icon(Icons.check_rounded , size: 15, color: active,) : Container(height: 15, width: 15,),
                    title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 10,),
                          Flexible(
                            child: Text(
                              projectOrderByAsText(e),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: textStyle_Text_12_500,
                            ),
                          ),
                        ],
                      ),
                    onTap: () async {
                      widget.onSelectPropriety(projectOrderByAsText(e));
                      projectListOrder.orderBy = e;
                      setState(() {
                        isChecked = true;
                      });
                      bloc.fetch();
                    },
                  );})
                      .toList()
                ]),
          );
  }
}
