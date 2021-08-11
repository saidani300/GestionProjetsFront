import 'package:flutter/material.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/filter/project_filter_bloc.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/Data/project_filter_data.dart';

class ProjectDateFilterCheck extends StatefulWidget {
  const ProjectDateFilterCheck({Key? key}) : super(key: key);

  @override
  _ProjectDateFilterCheckState createState() => _ProjectDateFilterCheckState();
}

class _ProjectDateFilterCheckState extends State<ProjectDateFilterCheck>
    with AutomaticKeepAliveClientMixin<ProjectDateFilterCheck> {
  late final filterBloc;

  @override
  void initState() {
    filterBloc = BlocProvider.of<ProjectFilterBloc>(context);
    super.initState();
    filterBloc.init();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<ProjectFilter>(
        stream: filterBloc.filterStream,
        builder: (context, snapshot) {
          ProjectFilter? filter = snapshot.data;
          return InkWell(
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            onTap: () async {

          projectFilter.date = !projectFilter.date;
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
                        value: snapshot.hasData ? filter!.date : projectFilter.date ,
                        onChanged: (value) {
                          projectFilter.date = !projectFilter.date;
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
