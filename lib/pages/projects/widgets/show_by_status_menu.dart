import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/project_bloc.dart';
import 'package:gestion_projets/pages/projects/project_details/structure/data/phase.dart';

class ShowByStatusItemData {
  final String name;
  final Status? status;

  ShowByStatusItemData(this.name, this.status);
}

List<ShowByStatusItemData> projectStatusMenuList = [
  ShowByStatusItemData("Tous", null),
  ShowByStatusItemData("Terminé", Status.completed),
  ShowByStatusItemData("En cours", Status.inProgress),
];

class ShowProjectsByStatusMenu extends StatefulWidget {
  const ShowProjectsByStatusMenu({Key? key}) : super(key: key);

  @override
  _ShowProjectsByStatusMenuState createState() =>
      _ShowProjectsByStatusMenuState();
}

class _ShowProjectsByStatusMenuState extends State<ShowProjectsByStatusMenu> {
  ShowByStatusItemData selectedMenuItem = projectStatusMenuList.first;

  @override
  initState() {
    super.initState();
  }

  _onSelectItem(ShowByStatusItemData menuItem) {
    setState(() {
      selectedMenuItem = menuItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: projectStatusMenuList
            .map((e) => Padding(
                padding: EdgeInsets.only(left: 20),
                child: ShowByStatusItem(
                  item: e,
                  isActive: e == selectedMenuItem,
                  onTap: () {
                    _onSelectItem(e);
                  },
                )))
            .toList(),
      ),
    );
  }
}

class ShowByStatusItem extends StatefulWidget {
  final ShowByStatusItemData item;
  final bool isActive;
  final Function() onTap;

  const ShowByStatusItem({
    Key? key,
    required this.item,
    required this.onTap,
    required this.isActive,
  }) : super(key: key);

  @override
  _ShowByStatusItemState createState() => _ShowByStatusItemState();
}

class _ShowByStatusItemState extends State<ShowByStatusItem> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ProjectBloc>(context);

    return InkWell(
        onTap: () {
          widget.onTap();
          projectsFilterData.status = widget.item.status;
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
                        fontSize: 13,
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
