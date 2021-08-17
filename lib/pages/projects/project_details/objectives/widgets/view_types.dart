import 'package:flutter/material.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/objective_bloc.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/data/objective.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/data/objective_filter_data.dart';

class ViewItem {
  final String name;
  final ObjectiveStatus? status;
  ViewItem(this.name , this.status);
}

List<ViewItem> views = [
  ViewItem(
    "Tous",
    null,
  ),
  ViewItem(
    "Atteint",
    ObjectiveStatus.achieved
  ),
  ViewItem(
    "Non atteint",
      ObjectiveStatus.notAchieved
  ),
  ViewItem(
    "En cours",
      ObjectiveStatus.inProgress
  ),
];

class ObjectiveShowByViewMenu extends StatefulWidget {
  const ObjectiveShowByViewMenu({Key? key}) : super(key: key);

  @override
  _ObjectiveShowByViewMenuState createState() =>
      _ObjectiveShowByViewMenuState();
}

class _ObjectiveShowByViewMenuState extends State<ObjectiveShowByViewMenu> {
  ViewItem selectedItem = views.first;

  @override
  initState() {
    super.initState();
  }

  _onSelectItem(ViewItem menuItem) {
    setState(() {
      selectedItem = menuItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: views
            .map((e) => Padding(
                padding: EdgeInsets.only(left: 20),
                child: ShowByViewItem(
                  item: e,
                  isActive: e == selectedItem,
                  onTap: () {
                    _onSelectItem(e);
                  },
                )))
            .toList(),
      ),
    );
  }
}

class ShowByViewItem extends StatefulWidget {
  final ViewItem item;
  final bool isActive;
  final Function() onTap;

  const ShowByViewItem({
    Key? key,
    required this.item,
    required this.onTap,
    required this.isActive,
  }) : super(key: key);

  @override
  _ShowByViewItemState createState() => _ShowByViewItemState();
}

class _ShowByViewItemState extends State<ShowByViewItem> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ObjectiveBloc>(context);

    return InkWell(
        onTap: () {
          widget.onTap();
           objectiveFilter.status = widget.item.status;
          bloc.fetch();
        },
        onHover: (value) {
          value
              ? setState(() {
                  isHover = true;
                })
              : setState(() {
                  isHover = false;
                });
        },
        child: Container(
            height: 50,
            child: IntrinsicWidth(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: Container()),
                  Text(
                    widget.item.name,
                    style: TextStyle(
                        color: widget.isActive
                            ? active
                            : isHover
                                ? text
                                : text.withOpacity(0.7),
                        fontSize: 12,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  Expanded(child: Container()),
                  Visibility(
                    visible: widget.isActive,
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    child: Container(
                      height: 3,
                      decoration: BoxDecoration(
                        color: active,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(3),
                            topRight: Radius.circular(3)),
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
