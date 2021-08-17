import 'package:flutter/material.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/event_bloc.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/helpers/custom_icon_popupmenu.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/data/evaluation_filter_data.dart';

class EvaluationOrderBy extends StatefulWidget {
  final double widgetHeight;
  final double popupMenuWidth;
  const EvaluationOrderBy({
    Key? key,
    this.widgetHeight = 40,
    this.popupMenuWidth = 200,
  }) : super(key: key);

  @override
  _EvaluationOrderByState createState() => _EvaluationOrderByState();
}

class _EvaluationOrderByState extends State<EvaluationOrderBy> {
  String orderBy = evaluationOrderByAsText(evaluationListOrder.orderBy);
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
              onEnter: (PointerEvent evaluation) => setState(() => isHover = true),
              onExit: (PointerEvent evaluation) => setState(() => isHover = false),
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
                    width: 180,
                    child:EvaluationOrderByListView(onSelectPropriety: (String value) { setState(() {orderBy = value;}); },
                      setAscending: (bool value) { },)))
          ];
        });
  }
}

class EvaluationOrderByListView extends StatefulWidget {
  final Function(String value) onSelectPropriety;
  final Function(bool value) setAscending;
  const EvaluationOrderByListView({Key? key,required this.onSelectPropriety , required this.setAscending}) : super(key: key);

  @override
  _EvaluationOrderByListViewState createState() => _EvaluationOrderByListViewState();
}

class _EvaluationOrderByListViewState extends State<EvaluationOrderByListView> {
  bool isAscending = evaluationListOrder.isAscending;
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<EventBloc>(context);
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
                evaluationListOrder.isAscending = true;
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
                evaluationListOrder.isAscending = false;
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
            ...EvaluationOrderByProperties.values
                .map((e) {
              bool isChecked = evaluationListOrder.orderBy == e;
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
                        evaluationOrderByAsText(e),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textStyle_Text_12_500,
                      ),
                    ),
                  ],
                ),
                onTap: () async {
                  widget.onSelectPropriety(evaluationOrderByAsText(e));
                  evaluationListOrder.orderBy = e;
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
