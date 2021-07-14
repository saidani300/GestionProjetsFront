import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/Data/items.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/bloc_provider.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/phase_bloc.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/task_bloc.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data_layer/phase.dart';
import 'package:gestion_projets/pages/projects/project_details/tasks/data/task_model.dart';
import 'package:gestion_projets/pages/projects/project_details/tasks/widgets/project_task_item.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/messages.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/multi_options_button.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/phase_item.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/pages/projects/widgets/search_text_field.dart';
import 'package:gestion_projets/pages/projects/widgets/show_by_status_item.dart';
import 'package:gestion_projets/services/navigation_service.dart';

import '../../../../../locator.dart';

final ScrollController scrollController = ScrollController();

class ProjectTasksHeader extends StatelessWidget {
  const ProjectTasksHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final bloc = BlocProvider.of<TaskBloc>(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(onPressed: (){locator<NavigationService>().projectGoBack();}, child: Text("Projets",style: TextStyle(
            color: active,
            fontSize: 12,
            letterSpacing: 0,
            fontWeight: FontWeight.w600),),),
        Padding(padding: EdgeInsets.only(top: 2) ,child :Icon(Icons.keyboard_arrow_right_rounded , size: 16, color: active,)),
        SizedBox(width: 2,),
        Text(
          "Développement d'une nouvelle interface utilisateur",
          style: TextStyle(
              color: text,
              fontSize: 12,
              letterSpacing: 0,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(width: 2,),
        Padding(padding: EdgeInsets.only(top: 2) ,child :Icon(Icons.keyboard_arrow_right_rounded , size: 16, color: active,)),
        SizedBox(width: 2,),
        Text("Tâches",style: TextStyle(
            color: text,
            fontSize: 12,
            letterSpacing: 0,
            fontWeight: FontWeight.w600),),
        SizedBox(width: 2,),
        Padding(padding: EdgeInsets.only(top: 2) ,child :CustomIconButton(icon: Icons.info, message: "Tâches", onTap: (){} , size: 17,)),
        Expanded(child: Container()),
        MultiOptionsButton(text: "Créer une tâche", onTap: () {}, ),
      ],
    );
  }
}

class ProjectTasksBody extends StatefulWidget {
  const ProjectTasksBody({Key? key}) : super(key: key);

  @override
  _ProjectTasksBodyState createState() => _ProjectTasksBodyState();
}

class _ProjectTasksBodyState extends State<ProjectTasksBody> {
  final ScrollController controller = ScrollController();
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final bloc = BlocProvider.of<PhaseBloc>(context);
    // bloc.fetch();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ProjectTasksHeader(),
        Expanded(
            child: Container(
                margin: EdgeInsets.only(top: 20),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: lightGrey.withOpacity(0.3),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        spreadRadius: 0.5,
                        blurRadius: 0.5,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white,
                  ),
                  child: Column(children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(3),
                            topRight: Radius.circular(3),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0)),
                        color: Colors.white,
                      ),
                      alignment: Alignment.bottomLeft,
                      child: Row(children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: ShowByStatusItems.map(
                                (e) => Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: ShowByStatusItem(
                                    itemName: e.name, onTap: () {})),
                          ).toList(),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(child: Container()),
                        SearchWidget(
                          text: "",
                          hintText: 'Rechercher des tâches',
                          onChanged: (value) {},
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        CustomIconButton(
                            icon: Icons.save_alt_rounded,
                            message: 'Exporter',
                            onTap: () {
                              /*  bloc.fetch();*/
                            }),
                        SizedBox(
                          width: 15,
                        ),
                        CustomIconButton(
                          icon: Icons.filter_alt_outlined,
                          message: 'Filter',
                          onTap: () {},
                        ),
                        SizedBox(
                          width: 15,
                        ),
                      ]),
                    ),
                    Divider(
                      height: 1,
                      color: dark.withOpacity(0.15),
                    ),
                    Expanded(
                        child: TasksList(parentContext: context,)),
                  ]),
                )))
      ],
    );
  }
}

class TasksList extends StatefulWidget {
  final BuildContext parentContext;
  const TasksList({Key? key ,required this.parentContext}) : super(key: key);

  @override
  _TasksListState createState() => _TasksListState();
}

class _TasksListState extends State<TasksList>{

  late final bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<TaskBloc>(widget.parentContext);
    super.initState();
    bloc.init();

  }


  @override
  Widget build(BuildContext context) {

    return Container(
        child: StreamBuilder<List<TaskModel>>(
            stream: bloc.actionStream,
            builder: (context, snapshot) {
              print(
                  "snapshot " + snapshot.data.toString());
              final results = snapshot.data;
              return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child:

                  (snapshot.hasData) ?
                  (results!.isEmpty) ?
                  NoPhases() :
                  ListView(
                    key: ValueKey(Random.secure()),
                    controller: scrollController,
                    children: results.map((e) => _buildItem(e)).toList(),
                  )
                      :
                  Center(
                    child: SpinKitFadingCube(
                      color: active,
                      size: 25,
                      duration:
                      Duration(milliseconds: 1200),
                    ),

                  ));

            })
    );

  }
  Widget _buildItem(TaskModel task) {
    return TestProxy(
        key: ValueKey(task),
        child: new ProjectTaskItem(task: task, onTap: () {  },)
    );
  }


}

class TestProxy extends SingleChildRenderObjectWidget {
  TestProxy({Key? key, required Widget child}) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    print('createRenderObject $key');
    return RenderProxyBox();
  }

  @override
  void updateRenderObject(BuildContext context, RenderObject renderObject) {
    print('updateRenderObject $key');
  }
}