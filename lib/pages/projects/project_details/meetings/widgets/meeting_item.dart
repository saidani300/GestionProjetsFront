import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/meeting_bloc.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/dialogs/attachments_dialog.dart';
import 'package:gestion_projets/dialogs/dialogs.dart';
import 'package:gestion_projets/dialogs/show_more_dialog.dart';
import 'package:gestion_projets/pages/projects/project_details/meetings/data/meeting.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/widgets/custom_tag.dart';
import 'package:gestion_projets/widgets/profile_avatar.dart';
import 'package:intl/intl.dart';

class MeetingItem extends StatefulWidget {
  final Function() onTap;
  final Meeting meeting;

  const MeetingItem({Key? key, required this.meeting, required this.onTap})
      : super(key: key);

  @override
  _MeetingItemState createState() => _MeetingItemState();
}

class _MeetingItemState extends State<MeetingItem>
    with AutomaticKeepAliveClientMixin<MeetingItem>, TickerProviderStateMixin {
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
    final bloc = BlocProvider.of<MeetingBloc>(context);
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
                    onTap: () {},
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Container(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 2,
                            child: Container(
                              color: statusToColor(widget.meeting.status),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                              child: Row(
                                children: [
                                  Flexible(
                                    child: AutoSizeText(
                                      widget.meeting.name,
                                      maxLines: 1,
                                      style: textStyle_Text_12_600,
                                      overflowReplacement: Row(
                                        children: [
                                          Flexible(
                                            child: Tooltip(
                                                message: widget.meeting.name,
                                                child: Text(widget.meeting.name,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        textStyle_Text_12_600)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Visibility(
                                      visible:
                                          widget.meeting.documents.isNotEmpty,
                                      child: CustomIconButton(
                                        icon: Icons.attach_file_rounded,
                                        message:
                                            "${widget.meeting.documents.length.toString()} Attachement",
                                        onTap: () {
                                          attachmentsDialogBox(context,
                                              widget.meeting.documents);
                                        },
                                        size: 15,
                                      )),
                                ],
                              ),
                            ),
                            flex: 4,
                          ),
                          SizedBox(
                            width: 20,
                          ),

                          Expanded(
                            child: Container(
                              child: Row(
                                children: [
                                  Flexible(
                                      child: Text(getText(widget.meeting.date),
                                          overflow: TextOverflow.ellipsis,
                                          style: textStyle_Text_12_600)),
                                ],
                              ),
                            ),
                            flex: 3,
                          ),

                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                                child: Row(
                              children: [
                                Flexible(
                                    child: Text(widget.meeting.time,
                                        overflow: TextOverflow.ellipsis,
                                        style: textStyle_Text_12_600)),
                              ],
                            )),
                            flex: 2,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                                child: RowSuper(
                              children: widget.meeting.participants.reversed
                                  .map((e) => Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              width: 2, color: white)),
                                      child: Tooltip(
                                        message: e.name,
                                        child: Avatar(
                                            name: e.name, picture: e.avatar),
                                      )))
                                  .toList(),
                              innerDistance: -10.0,
                            )),
                            flex: 2,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                              child: Row(
                                children: [
                                  Flexible(
                                    child: AutoSizeText(
                                      widget.meeting.comment.isEmpty
                                          ? "Pas de commentaire"
                                          : widget.meeting.comment,
                                      maxLines: 1,
                                      style: widget.meeting.comment.isEmpty
                                          ? textStyle_Text_11_500
                                          : textStyle_Text_12_600,
                                      overflowReplacement: Row(
                                        children: [
                                          Flexible(
                                              child: Text(
                                                  widget.meeting.comment.isEmpty
                                                      ? "Pas de commentaire"
                                                      : widget.meeting.comment,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: widget.meeting.comment
                                                          .isEmpty
                                                      ? textStyle_Text_11_500
                                                      : textStyle_Text_12_600)),
                                          widget.meeting.comment.isNotEmpty
                                              ? CustomIconButton(
                                                  icon: Icons.open_in_new,
                                                  message: "Afficher plus",
                                                  onTap: () {
                                                    showMoreDialogBox(
                                                        context,
                                                        'Commentaire',
                                                        widget.meeting.comment);
                                                  },
                                                  size: 15,
                                                )
                                              : Container()
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            flex: 3,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTag(
                                      text: statusToText(widget.meeting.status),
                                      color:
                                          statusToColor(widget.meeting.status))
                                ]),
                            flex: 2,
                          ),
                          // ActionsMenu(),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 40,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(child: Container()),
                                CustomIconButton(
                                    icon: Icons.delete_forever_rounded,
                                    message: 'Supprimer',
                                    color: Colors.redAccent,
                                    onTap: () {
                                      deleteDialogBox(
                                          context,
                                          () => _controller
                                              .reverse()
                                              .whenComplete(() =>
                                                  bloc.remove(widget.meeting)),
                                          DeleteType.file,
                                          widget.meeting.name);
                                      //showDialogBox(context, onTap);
                                    }),
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

Color statusToColor(MeetingStatus status) {
  switch (status) {
    case MeetingStatus.programmed:
      return text;
    case MeetingStatus.inProgress:
      return lightOrange;
    case MeetingStatus.completed:
      return lightBlue;
  }
}

String statusToText(MeetingStatus status) {
  switch (status) {
    case MeetingStatus.programmed:
      return "Programmée";
    case MeetingStatus.inProgress:
      return "En cours";
    case MeetingStatus.completed:
      return "Terminé";
  }
}

Widget relatedItemToWidget(RelatedItem item) {
  String string;
  switch (item.type) {
    case ItemType.Phase:
      string = "P";
      break;
    case ItemType.Action:
      string = "A";
      break;
    case ItemType.Task:
      string = "T";
      break;
    case ItemType.Objective:
      string = "Ob";
      break;
    case ItemType.Risk:
      string = "R";
      break;
    case ItemType.Opportunity:
      string = "Op";
  }
  return Tooltip(
      message: item.name,
      child: Container(
        height: 20,
        width: 20,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(3)), color: text),
        child: Center(
            child: Text(
          string,
          textAlign: TextAlign.center,
          style:
              TextStyle(color: white, fontSize: 9, fontWeight: FontWeight.w600),
        )),
      ));
}
