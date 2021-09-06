import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/widgets/profile_avatar.dart';
import 'package:intl/intl.dart';
import 'package:gestion_projets/pages/notifications/data/notification.dart'
as Model;
import 'package:timeago/timeago.dart' as timeAgo;

class ActivityItem extends StatefulWidget {
  final Model.Notification activity;

  const ActivityItem({Key? key, required this.activity,})
      : super(key: key);

  @override
  _ActivityItemState createState() => _ActivityItemState();
}

class _ActivityItemState extends State<ActivityItem>
    with AutomaticKeepAliveClientMixin<ActivityItem>, TickerProviderStateMixin {
  String getText(DateTime date) => DateFormat.yMMMMd('fr_FR').format(date);
  late AnimationController _controller;
  late Animation<double> _animation;

  initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this, value: 0);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return FadeTransition(
        opacity: _animation,
        child: SizeTransition(
            sizeFactor: _animation,
            child: Material(
                color: Colors.transparent,
                child: Column(children: [
                  InkWell(
                    hoverColor: active.withOpacity(0.015),
                    onTap: () {

                    },
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Container(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Icon(Icons.task_rounded , size: 18, color: text,),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                              child: Row(
                                children: [
                                  Flexible(
                                      child: Text( "Création d'une nouvelle tâche ",
                                          overflow: TextOverflow.ellipsis,
                                          style: textStyle_Text_12_500)),
                                  Flexible(
                                      child: Text(widget.activity.itemName,
                                          overflow: TextOverflow.ellipsis,
                                          style: textStyle_Text_12_600)),
                                ],
                              ),
                            ),
                            flex: 4,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                    height: 30,
                                    width: 30,
                                    child: Avatar(
                                      picture: widget.activity.user.avatar,
                                      name: widget.activity.user.name,
                                    )),
                                SizedBox(
                                  width: 15,
                                ),
                                Flexible(
                                    child: Text(widget.activity.user.name,
                                        overflow: TextOverflow.ellipsis,
                                        style: textStyle_Text_12_500)),
                              ],
                            ),
                            flex: 2,
                          ),
                          Expanded(child: Container()),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                      child: Text(
                              'Il y a ' + timeAgo.format(widget.activity.date, locale: 'en_short'),
                              style: TextStyle(
                                  color: text.withOpacity(0.8),
                                  fontSize: 11,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w400),
                            )),
                                ],
                              ),
                            ),
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: dividerColor,
                  ),
                  // Container(height: 60,)
                ]))));
  }
}
