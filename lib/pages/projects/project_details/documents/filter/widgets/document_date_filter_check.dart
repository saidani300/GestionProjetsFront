import 'package:flutter/material.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/filter/document_filter_bloc.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/project_details/documents/data/document_filter_data.dart';

class DocumentDateFilterCheck extends StatefulWidget {
  const DocumentDateFilterCheck({Key? key}) : super(key: key);

  @override
  _DocumentDateFilterCheckState createState() => _DocumentDateFilterCheckState();
}

class _DocumentDateFilterCheckState extends State<DocumentDateFilterCheck>
    with AutomaticKeepAliveClientMixin<DocumentDateFilterCheck> {
  late final filterBloc;

  @override
  void initState() {
    filterBloc = BlocProvider.of<DocumentFilterBloc>(context);
    super.initState();
    filterBloc.init();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<DocumentFilter>(
        stream: filterBloc.filterStream,
        builder: (context, snapshot) {
          DocumentFilter? filter = snapshot.data;
          return InkWell(
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            onTap: () async {

              documentFilter.date = !documentFilter.date;
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
                        value: snapshot.hasData ? filter!.date : documentFilter.date ,
                        onChanged: (value) {
                          documentFilter.date = !documentFilter.date;
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
