import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gestion_projets/constants/style.dart';

class ViewItem {
  final String name;
  final String icon;

  ViewItem(this.name, this.icon);
}

List<ViewItem> views = [
  ViewItem("Liste", "icons/views/List.svg"),
  ViewItem("Gantt", "icons/views/Gantt.svg"),
];

class ShowByViewMenu extends StatefulWidget {
  const ShowByViewMenu({Key? key}) : super(key: key);

  @override
  _ShowByViewMenuState createState() => _ShowByViewMenuState();
}

class _ShowByViewMenuState extends State<ShowByViewMenu> {
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
    // final bloc = BlocProvider.of<ProjectBloc>(context);

    return InkWell(
        onTap: () {
          widget.onTap();
          /* projectsFilterData.status = widget.item.status;
          bloc.fetch();*/
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
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        widget.item.icon,
                        color: widget.isActive
                            ? active
                            : isHover
                                ? text
                                : text.withOpacity(0.7),
                        width: 12,
                        height: 12,
                      ),
                      SizedBox(
                        width: 5,
                      ),
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
                    ],
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
