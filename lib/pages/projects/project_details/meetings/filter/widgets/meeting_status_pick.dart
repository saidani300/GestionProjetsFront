import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/filter/meeting_filter_bloc.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/project_details/meetings/data/meeting.dart';
import 'package:gestion_projets/pages/projects/project_details/meetings/data/meeting_filter_data.dart';
import 'package:gestion_projets/pages/projects/widgets/form_widgets/custom_select_list.dart';

class MeetingStatutesPicker extends StatefulWidget {
  final double widgetHeight;
  const MeetingStatutesPicker({
    Key? key,
    this.widgetHeight = 40,
  }) : super(key: key);

  @override
  _MeetingStatutesPickerState createState() => _MeetingStatutesPickerState();
}

class _MeetingStatutesPickerState extends State<MeetingStatutesPicker>{
  late final filterBloc;

  @override
  void initState() {
    filterBloc = BlocProvider.of<MeetingFilterBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomListPopupMenuButton(
        containerHeight: widget.widgetHeight,
        offset: Offset(0, 38),
        child: StatusText(filterBloc),
        enabled: true,
        itemBuilder: (context) {
          return[
            CustomListPopupMenuItem(
                value: 1,
                enabled: false,
                child: Container(
                    height: 161,
                    width: 250,
                    child: BlocProvider<MeetingFilterBloc>(
                        bloc: MeetingFilterBloc(),
                        child: MeetingStatutesListView(MeetingStatus.values,filterBloc))))
          ];
        });
  }
}

class MeetingStatutesListView extends StatefulWidget {
  final List<MeetingStatus> statutes;
  final MeetingFilterBloc bloc;
  MeetingStatutesListView(this.statutes , this.bloc) ;

  @override
  _MeetingStatutesListViewState createState() => _MeetingStatutesListViewState();
}

class _MeetingStatutesListViewState extends State<MeetingStatutesListView>{

  @override
  void initState() {
    super.initState();
    widget.bloc.init();
  }

  @override
  Widget build(BuildContext context) {
    Function eq = const DeepCollectionEquality.unordered().equals;
    ScrollController controller = new ScrollController();
    return StreamBuilder<MeetingFilter>(
        stream: widget.bloc.filterStream,
        builder: (context, snapshot) {
          MeetingFilter? filter = snapshot.data;
          return snapshot.hasData
              ? Scrollbar(
            isAlwaysShown: true,
            controller: controller,
            child: ListView(
                controller: controller,
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
                    horizontalTitleGap: 0,
                    dense: true,
                    tileColor: white,
                    leading: Transform.scale(
                      scale: 0.8,
                      child: Checkbox(
                        value: (snapshot.hasData)
                            ? eq(filter!.statutes, MeetingStatus.values)
                            : false,
                        onChanged: (value) {

                          if (eq(filter!.statutes, MeetingStatus.values))
                          {
                            meetingFilter.statutes = [];
                            widget.bloc.fetch();
                          }
                          else{
                            meetingFilter.statutes = List.from(MeetingStatus.values);
                            widget.bloc.fetch();
                          }
                          meetingFilter.allStatutes = eq(filter.statutes, MeetingStatus.values);
                        },
                        activeColor: active,
                      ),
                    ),
                    title: Row(
                      children: [
                        Text(
                          'Tous',
                          style: textStyle_Text_12_500,
                        ),
                      ],
                    ),
                    onTap: () async {

                      if (eq(filter!.statutes, MeetingStatus.values))
                      {
                        meetingFilter.statutes = [];
                        widget.bloc.fetch();
                      }
                      else
                      {
                        meetingFilter.statutes = List.from(MeetingStatus.values);
                        widget.bloc.fetch();
                      }
                      meetingFilter.allStatutes = eq(filter.statutes, MeetingStatus.values);
                    },
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: dividerColor,
                  ),
                  ...widget.statutes
                      .map((e) => ListTile(
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 0),
                    horizontalTitleGap: 0,
                    dense: true,
                    tileColor: white,
                    leading: Transform.scale(
                      scale: 0.8,
                      child: Checkbox(
                        value: (snapshot.hasData)
                            ? filter!.statutes.contains(e)
                            : true,
                        onChanged: (value) {
                          meetingFilter.statutes.contains(e)
                              ? widget.bloc.removeStatus(e)
                              : widget.bloc.addStatus(e);
                          meetingFilter.allStatutes = eq(filter!.statutes, MeetingStatus.values);
                        },
                        activeColor: active,
                      ),
                    ),
                    title: Row(
                      children: [
                        Container( decoration: BoxDecoration(
                            color: meetingStatusToColor(e),
                            shape: BoxShape.circle
                        ),
                          height: 15, width: 15,
                        ) ,
                         SizedBox(width: 10,),
                        Text(
                          meetingStatusToText(e),
                          style: textStyle_Text_12_500,
                        ),
                      ],
                    ),
                    onTap: () async {
                      meetingFilter.statutes.contains(e)
                          ? widget.bloc.removeStatus(e)
                          : widget.bloc.addStatus(e);
                      meetingFilter.allStatutes = eq(filter!.statutes, MeetingStatus.values);
                    },
                  ))
                      .toList()
                ]),
          )
              : Container();
        });
  }
}

class StatusText extends StatefulWidget {
  final MeetingFilterBloc bloc;
  StatusText(this.bloc);

  @override
  _StatusTextState createState() => _StatusTextState();
}

class _StatusTextState extends State<StatusText>{
  String status = "Par défaut";
  @override
  void initState() {
    super.initState();
    widget.bloc.init();
  }

  @override
  Widget build(BuildContext context) {
    Function eq = const DeepCollectionEquality.unordered().equals;
    return StreamBuilder<MeetingFilter>(
        stream: widget.bloc.filterStream,
        builder: (context, filterSnapshot) {
          return Text(
            filterSnapshot.hasData ? eq(filterSnapshot.data!.statutes, MeetingStatus.values) ? "Par défaut" : "Personnalisé" : "Par défaut",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 11,
            ),
          );});
  }
}