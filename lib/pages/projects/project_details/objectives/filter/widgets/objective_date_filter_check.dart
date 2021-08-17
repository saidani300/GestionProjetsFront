import 'package:flutter/material.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/filter/objective_filter_bloc.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/data/objective_filter_data.dart';

class ObjectiveDateFilterCheck extends StatefulWidget {
  const ObjectiveDateFilterCheck({Key? key}) : super(key: key);

  @override
  _ObjectiveDateFilterCheckState createState() => _ObjectiveDateFilterCheckState();
}

class _ObjectiveDateFilterCheckState extends State<ObjectiveDateFilterCheck>
    with AutomaticKeepAliveClientMixin<ObjectiveDateFilterCheck> {
  late final filterBloc;

  @override
  void initState() {
    filterBloc = BlocProvider.of<ObjectiveFilterBloc>(context);
    super.initState();
    filterBloc.init();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<ObjectiveFilter>(
        stream: filterBloc.filterStream,
        builder: (context, snapshot) {
          ObjectiveFilter? filter = snapshot.data;
          return InkWell(
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            onTap: () async {

              objectiveFilter.date = !objectiveFilter.date;
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
                        value: snapshot.hasData ? filter!.date : objectiveFilter.date ,
                        onChanged: (value) {
                          objectiveFilter.date = !objectiveFilter.date;
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
