import 'package:flutter/material.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/filter/meeting_filter_bloc.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/project_details/meetings/data/meeting_filter_data.dart';

class MeetingDateFilterCheck extends StatefulWidget {
  const MeetingDateFilterCheck({Key? key}) : super(key: key);

  @override
  _MeetingDateFilterCheckState createState() => _MeetingDateFilterCheckState();
}

class _MeetingDateFilterCheckState extends State<MeetingDateFilterCheck>
    with AutomaticKeepAliveClientMixin<MeetingDateFilterCheck> {
  late final filterBloc;

  @override
  void initState() {
    filterBloc = BlocProvider.of<MeetingFilterBloc>(context);
    super.initState();
    filterBloc.init();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<MeetingFilter>(
        stream: filterBloc.filterStream,
        builder: (context, snapshot) {
          MeetingFilter? filter = snapshot.data;
          return InkWell(
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            onTap: () async {

              meetingFilter.date = !meetingFilter.date;
              filterBloc.fetch();
            },
            child: Container(
              color: Colors.transparent,
              height: 40,
              child: Row(
                children: [

                  //  SizedBox(width: 10,),
                  Row( mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          "Utiliser le filtre par date",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textStyle_Text_11_500,
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: Container()),
                  Transform.scale(
                    scale: 0.8,
                    child: SizedBox(
                      width: 15.0,
                      child: Checkbox(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: snapshot.hasData ? filter!.date : meetingFilter.date ,
                        onChanged: (value) {
                          meetingFilter.date = !meetingFilter.date;
                          filterBloc.fetch();
                        },
                        activeColor: active,
                      ),),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
