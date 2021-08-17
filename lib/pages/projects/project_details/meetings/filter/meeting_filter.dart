import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/filter/meeting_filter_bloc.dart';
import 'package:gestion_projets/BLoC/meeting_bloc.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/dialogs/forms/widgets/date_picker.dart';
import 'package:gestion_projets/dialogs/forms/widgets/time_picker.dart';
import 'package:gestion_projets/helpers/buttons.dart';
import 'package:gestion_projets/pages/projects/project_details/meetings/data/meeting.dart';
import 'package:gestion_projets/pages/projects/project_details/meetings/data/meeting_filter_data.dart';
import 'package:gestion_projets/pages/projects/project_details/meetings/filter/widgets/meeting_date_filter_check.dart';
import 'package:gestion_projets/pages/projects/project_details/meetings/filter/widgets/meeting_status_pick.dart';
import 'package:gestion_projets/pages/projects/project_details/meetings/filter/widgets/meeting_time_filter_check.dart';


class MeetingFilterMenu extends StatefulWidget {
  const MeetingFilterMenu({Key? key}) : super(key: key);

  @override
  _MeetingFilterMenuState createState() => _MeetingFilterMenuState();
}

class _MeetingFilterMenuState extends State<MeetingFilterMenu> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MeetingFilterBloc>(
        bloc: MeetingFilterBloc(),
        child: Theme(
            data: Theme.of(context).copyWith(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              hoverColor: active.withOpacity(0.03),
              dividerTheme: DividerThemeData(
                thickness: 0.5,
                space: 0,
              ),
              popupMenuTheme: PopupMenuThemeData(
                textStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
            ),
            child: Tooltip(
              message: 'Filtre',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Material(
                  color: Colors.transparent,
                  child: PopupMenuButton(
                      padding: EdgeInsets.all(0),
                      elevation: 5,
                      offset: Offset(0, 38),
                      child: MouseRegion(
                        onEnter: (PointerEvent event) => setState(() => isHover = true),
                        onExit: (PointerEvent event) => setState(() => isHover = false),
                        child: Icon(
                          Icons.filter_alt_outlined,
                          color: isHover ? active : text.withOpacity(0.7),
                          size: 17,
                        ),
                      ),
                      itemBuilder: (context) {
                        return listItems(context);
                      }),
                ),
              ),
            )));
  }
}

List<PopupMenuEntry<Object>> listItems(BuildContext context) {
  final bloc = BlocProvider.of<MeetingBloc>(context);
  final filterBloc = BlocProvider.of<MeetingFilterBloc>(context);
  final double widgetHeight = 35;
  return [
    PopupMenuItem(
      enabled: false,
      padding: EdgeInsets.all(0),
      value: 0,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Text(
                "Filtre",
                style: textStyle_Text_12_500,
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
      ),
    ),
    PopupMenuDivider(
      height: 0.5,
    ),
    PopupMenuItem(
      padding: EdgeInsets.all(0),
      enabled: false,
      value: 0,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    "Statuts",
                    style: textStyle_Text_11_500,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              BlocProvider<MeetingFilterBloc>(
                  bloc: MeetingFilterBloc(),
                  child: Container(width: 250, child: MeetingStatutesPicker(widgetHeight: widgetHeight,))),
              BlocProvider<MeetingFilterBloc>(
                  bloc: MeetingFilterBloc(), child: MeetingDateFilterCheck()),
              Row(
                children: [
                  Text(
                    "Date de début",
                    style: textStyle_Text_11_500,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              DatePickerWidget(
                textSize: 11,
                setDate: (DateTime date) {
                  meetingFilter.startDate = date;
                },
                initDate: meetingFilter.startDate,
                height: widgetHeight,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Date de fin",
                    style: textStyle_Text_11_500,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              DatePickerWidget(
                textSize: 11,
                setDate: (DateTime date) {
                  meetingFilter.endDate = date;
                },
                initDate: meetingFilter.endDate,
                height: widgetHeight,
              ),
              BlocProvider<MeetingFilterBloc>(
                  bloc: MeetingFilterBloc(), child: MeetingTimeFilterCheck()),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Text(
                                "Heure de début",
                                style: textStyle_Text_11_500,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                              ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TimePickerWidget(
                          textSize: 11,
                          setTime: (TimeOfDay time) {
                            meetingFilter.startTime = time;
                          },
                          initTime: meetingFilter.startTime,
                          height: widgetHeight,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                           Text(
                                "Heure de fin",
                                overflow: TextOverflow.ellipsis,
                                style: textStyle_Text_11_500,
                                textAlign: TextAlign.start,
                              ),
                            
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TimePickerWidget(
                          textSize: 11,
                          setTime: (TimeOfDay time) {
                            meetingFilter.endTime = time;
                          },
                          initTime: meetingFilter.endTime,
                          height: widgetHeight,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
    PopupMenuDivider(
      height: 0.5,
    ),
    PopupMenuItem(
      enabled: false,
      padding: EdgeInsets.all(0),
      value: 4,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(child: Container()),
              FilterOutlinedButton(
                onTap: () {
                  meetingFilter = MeetingFilter(true, false, false, List.from(MeetingStatus.values),DateTime(DateTime.now().year, DateTime.now().month -2 , DateTime.now().day),
                      DateTime(DateTime.now().year, DateTime.now().month +2 , DateTime.now().day) , TimeOfDay(hour: 7 , minute: 0 ) ,TimeOfDay(hour: 19 , minute: 0 ), "" );
                  bloc.fetch();
                  Navigator.pop(context);
                },
                text: 'Effacer tout',
              ),
              SizedBox(
                width: 10,
              ),
              FilterButton(
                  text: 'Appliquer',
                  onTap: () {
                    bloc.fetch();
                  }),
            ],
          ),
        ),
      ),
    ),
  ];
}
