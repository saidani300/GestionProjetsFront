import 'package:flutter/material.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/objective_bloc.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/helpers/custom_icon_popupmenu.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/data/indicator_filter_data.dart';

class IndicatorOrderBy extends StatefulWidget {
  final double widgetHeight;
  final double popupMenuWidth;
  const IndicatorOrderBy({
    Key? key,
    this.widgetHeight = 40,
    this.popupMenuWidth = 200,
  }) : super(key: key);

  @override
  _IndicatorOrderByState createState() => _IndicatorOrderByState();
}

class _IndicatorOrderByState extends State<IndicatorOrderBy> {
  String orderBy = indicatorOrderByAsText(indicatorListOrder.orderBy);
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
                    child:IndicatorOrderByListView(onSelectPropriety: (String value) { setState(() {orderBy = value;}); },
                      setAscending: (bool value) { },)))
          ];
        });
  }
}

class IndicatorOrderByListView extends StatefulWidget {
  final Function(String value) onSelectPropriety;
  final Function(bool value) setAscending;
  const IndicatorOrderByListView({Key? key,required this.onSelectPropriety , required this.setAscending}) : super(key: key);

  @override
  _IndicatorOrderByListViewState createState() => _IndicatorOrderByListViewState();
}

class _IndicatorOrderByListViewState extends State<IndicatorOrderByListView> {
  bool isAscending = indicatorListOrder.isAscending;
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ObjectiveBloc>(context);
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
                indicatorListOrder.isAscending = true;
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
                indicatorListOrder.isAscending = false;
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
            ...IndicatorOrderByProperties.values
                .map((e) {
              bool isChecked = indicatorListOrder.orderBy == e;
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
                        indicatorOrderByAsText(e),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textStyle_Text_12_500,
                      ),
                    ),
                  ],
                ),
                onTap: () async {
                  widget.onSelectPropriety(indicatorOrderByAsText(e));
                  indicatorListOrder.orderBy = e;
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
