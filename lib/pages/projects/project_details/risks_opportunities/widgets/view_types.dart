import 'package:flutter/material.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/event_bloc.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/data/event.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/data/event_filter_data.dart';

class ViewItem {
  final String name;
  final EventType? type;
  ViewItem(this.name , this.type);
}

List<ViewItem> views = [
  ViewItem(
    "Tous",
    null,
  ),
  ViewItem(
    "Opportunités",
      EventType.Opportunity,
  ),
  ViewItem(
    "Risques",
      EventType.Risk,
  ),
];

class EventShowByViewMenu extends StatefulWidget {
  const EventShowByViewMenu({Key? key}) : super(key: key);

  @override
  _EventShowByViewMenuState createState() => _EventShowByViewMenuState();
}

class _EventShowByViewMenuState extends State<EventShowByViewMenu> {
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
     final bloc = BlocProvider.of<EventBloc>(context);

    return InkWell(
        onTap: () {
          widget.onTap();
           eventFilter.type = widget.item.type;
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
