import 'package:flutter/material.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/filter/task_filter_bloc.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/project_details/tasks/data/task_filter_data.dart';

class TaskDateFilterCheck extends StatefulWidget {
  const TaskDateFilterCheck({Key? key}) : super(key: key);

  @override
  _TaskDateFilterCheckState createState() => _TaskDateFilterCheckState();
}

class _TaskDateFilterCheckState extends State<TaskDateFilterCheck>
    with AutomaticKeepAliveClientMixin<TaskDateFilterCheck> {
  late final filterBloc;

  @override
  void initState() {
    filterBloc = BlocProvider.of<TaskFilterBloc>(context);
    super.initState();
    filterBloc.init();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<TaskFilter>(
        stream: filterBloc.filterStream,
        builder: (context, snapshot) {
          TaskFilter? filter = snapshot.data;
          return InkWell(
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            onTap: () async {

              taskFilter.date = !taskFilter.date;
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
                        value: snapshot.hasData ? filter!.date : taskFilter.date ,
                        onChanged: (value) {
                          taskFilter.date = !taskFilter.date;
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
