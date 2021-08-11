import 'package:flutter/material.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/objective_bloc.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/data/objective.dart';

class MultiOptionsStatusChange extends StatefulWidget {
  final Objective objective;

  const MultiOptionsStatusChange({Key? key, required this.objective})
      : super(key: key);

  @override
  _MultiOptionsStatusChangeState createState() =>
      _MultiOptionsStatusChangeState();
}

class _MultiOptionsStatusChangeState extends State<MultiOptionsStatusChange>
    with TickerProviderStateMixin {
  late OverlayEntry _overlayEntry;

  final LayerLink _layerLink = LayerLink();

  OverlayEntry _createOverlayEntry(Objective objective, ObjectiveBloc bloc) {
    AnimationController _controller = AnimationController(
        duration: const Duration(milliseconds: 150), vsync: this, value: 0);
    Animation<double> _animation =
        CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
    RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    var size = renderBox!.size;

    return OverlayEntry(
        builder: (_) => Stack(
              children: <Widget>[
                Positioned.fill(
                    child: GestureDetector(
                  onTap: () async {
                    await _controller.reverse();
                    this._overlayEntry.remove();
                  },
                  child: Container(
                    color: Colors.transparent,
                  ),
                )),
                Positioned(
                  child: CompositedTransformFollower(
                    link: this._layerLink,
                    showWhenUnlinked: false,
                    offset: Offset(0.0, size.height + 5.0),
                    child: Material(
                      borderRadius: BorderRadius.all(Radius.circular(2)),
                      elevation: 4.0,
                      child: Container(
                        width: 150,
                        child: FadeTransition(
                            opacity: _animation,
                            child: SizeTransition(
                                sizeFactor: _animation,
                                child: ListView(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  children: ObjectiveStatus.values
                                      .where((element) =>
                                          element != objective.status)
                                      .map((e) => ListTile(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 10),
                                            horizontalTitleGap: 0,
                                            dense: true,
                                            tileColor: white,
                                            leading: statusAsset(e),
                                            title: Row(
                                              children: [
                                                Text(
                                                  objectiveStatusAsText(e),
                                                  style: textStyle_Text_12_500,
                                                ),
                                              ],
                                            ),
                                            onTap: () async {
                                              objective.status = e;
                                              bloc.fetch();
                                              await _controller.reverse();
                                              this._overlayEntry.remove();
                                            },
                                          ))
                                      .toList(),
                                  // Divider(height: 1, thickness: 1, color: dividerColor,),
                                ))),
                      ),
                    ),
                  ),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ObjectiveBloc>(context);

    return CompositedTransformTarget(
      link: this._layerLink,
      child: StatusButton(
        onTap: () {
          this._overlayEntry = this._createOverlayEntry(widget.objective, bloc);
          Overlay.of(context)!.insert(this._overlayEntry);
        },
        status: widget.objective.status,
      ),
    );
  }
}

class StatusButton extends StatefulWidget {
  final Function() onTap;
  final ObjectiveStatus status;

  StatusButton({
    Key? key,
    required this.onTap,
    required this.status,
  }) : super(key: key);

  @override
  _StatusButtonState createState() => _StatusButtonState();
}

class _StatusButtonState extends State<StatusButton> {
  bool onHover = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          widget.onTap();
          setState(() {
            onHover = false;
          });
        },
        onHover: (value) {
          setState(() {
            value ? onHover = true : onHover = false;
          });
        },
        child: Tooltip(
            message: 'Changer le statut',
            decoration: BoxDecoration(
              color: text,
              borderRadius: BorderRadius.all(Radius.circular(2)),
            ),
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  color: onHover
                      ? statusColor(widget.status).withAlpha(200)
                      : statusColor(widget.status),
                  shape: BoxShape.circle),
              child: Icon(statusIcon(widget.status), size: 10, color: white),
            )));
  }
}

Color statusColor(ObjectiveStatus status) {
  switch (status) {
    case ObjectiveStatus.inProgress:
      return lightOrange;
    case ObjectiveStatus.notAchieved:
      return lightRed;
    case ObjectiveStatus.achieved:
      return lightPurple;
  }
}

IconData statusIcon(ObjectiveStatus status) {
  switch (status) {
    case ObjectiveStatus.inProgress:
      return Icons.more_horiz_rounded;
    case ObjectiveStatus.notAchieved:
      return Icons.close_rounded;
    case ObjectiveStatus.achieved:
      return Icons.check_rounded;
  }
}

Widget statusAsset(ObjectiveStatus status) {
  return Container(
    height: 20,
    width: 20,
    decoration:
        BoxDecoration(color: statusColor(status), shape: BoxShape.circle),
    child: Icon(statusIcon(status), size: 10, color: white),
  );
}
