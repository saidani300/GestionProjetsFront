import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/Data/project.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/bloc_provider.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/task_bloc.dart';
import 'package:gestion_projets/pages/projects/project_details/documents/data/document.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data/phase.dart'
    as Model;
import 'package:gestion_projets/pages/people/Data/user.dart';
import 'package:gestion_projets/pages/projects/project_details/tasks/data/task_model.dart';
import 'package:gestion_projets/pages/projects/project_details/tasks/widgets/project_task_item.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/messages.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/multi_options_button.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/pages/projects/widgets/search_text_field.dart';
import 'package:gestion_projets/services/navigation_service.dart';
import 'package:gestion_projets/widgets/toast.dart';

import '../../../../../locator.dart';



class ProjectTasksHeader extends StatelessWidget {
  final ScrollController scrollController;
  const ProjectTasksHeader({
    Key? key,
    required this.scrollController
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<TaskBloc>(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            locator<NavigationService>().projectGoBack();
          },
          child: Text("Projets", style: textStyle_active_12_600),
        ),
        Padding(
            padding: EdgeInsets.only(top: 2),
            child: Icon(
              Icons.keyboard_arrow_right_rounded,
              size: 16,
              color: active,
            )),
        SizedBox(
          width: 2,
        ),
        Text("Développement d'une nouvelle interface utilisateur",
            style: textStyle_Text_12_600),
        SizedBox(
          width: 2,
        ),
        Padding(
            padding: EdgeInsets.only(top: 2),
            child: Icon(
              Icons.keyboard_arrow_right_rounded,
              size: 16,
              color: active,
            )),
        SizedBox(
          width: 2,
        ),
        Text("Tâches", style: textStyle_Text_12_600),
        SizedBox(
          width: 2,
        ),
        Padding(
            padding: EdgeInsets.only(top: 2),
            child: CustomIconButton(
              icon: Icons.info,
              message: "Tâches",
              onTap: () {},
              size: 17,
            )),
        Expanded(child: Container()),
        MultiOptionsButton(
          text: "Créer une tâche",
          isMultiple: false,
          onTap: () {
            bloc.add(new TaskModel(
                new Random().nextInt(99999),
                "Développement d'une nouvelle interface utilisateur",
                DateTime.now(),
                DateTime.now().add(Duration(days: 17)),
                Model.Status.inProgress,
                User(30, "Saidani Wael", "5"),
                [        Document(55, "Développement d'une nouvelle interface utilisateur", "url", "PDF", User(12,"Saidani Wael" , "3"), DateTime.now(), 656848),],
                Priority.Important,
                []));
            if (scrollController.hasClients)
              scrollController.animateTo(
                0.0,
                curve: Curves.easeOut,
                duration: const Duration(milliseconds: 300),
              );
            showToast(ToastType.success , "Développement d'une nouvelle interface utilisateur",event : ToastEvent.create);
          },
        ),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ProjectTasksHeader(scrollController: controller,),
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
                    color: white,
                  ),
                  child: Column(children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(3),
                            topRight: Radius.circular(3),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0)),
                        color: white,
                      ),
                      alignment: Alignment.bottomLeft,
                      child: Row(children: [
                        SizedBox(
                          width: 20,
                        ),
                        SearchWidget(
                          text: "",
                          hintText: 'Rechercher des tâches',
                          onChanged: (value) {},
                        ),
                        Expanded(child: Container()),
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
                      color: dividerColor,
                    ),
                    Container(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 2,
                            child: Container(
                              color: Colors.transparent,
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
                                      child: Text("Tâche",
                                          overflow: TextOverflow.ellipsis,
                                          style: textStyle_Text_12_600)),
                                ],
                              ),
                            ),
                            flex: 8,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                                child: Row(children: [
                              Flexible(
                                  child: Text("Date de début",
                                      overflow: TextOverflow.ellipsis,
                                      style: textStyle_Text_12_600)),
                            ])),
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
                                      child: Text("Date de fin",
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
                            child: Row(
                              children: [
                                Flexible(
                                    child: Text("Affecter à",
                                        overflow: TextOverflow.ellipsis,
                                        style: textStyle_Text_12_600)),
                              ],
                            ),
                            flex: 4,
                          ),
                          Expanded(
                            child: Container(
                                child: Row(children: [
                              Flexible(
                                  child: Text("Priorité",
                                      overflow: TextOverflow.ellipsis,
                                      style: textStyle_Text_12_600)),
                            ])),
                            flex: 2,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                      child: Text("Statut",
                                          overflow: TextOverflow.ellipsis,
                                          style: textStyle_Text_12_600)),
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
                              children: [],
                            ),
                          ),

                          SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: dividerColor,
                    ),
                    Expanded(
                        child: TasksList(
                      parentContext: context, scrollController: controller,
                    )),
                  ]),
                )))
      ],
    );
  }
}

class TasksList extends StatefulWidget {
  final BuildContext parentContext;
  final ScrollController scrollController;
  const TasksList({Key? key, required this.parentContext , required this.scrollController}) : super(key: key);

  @override
  _TasksListState createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
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
            stream: bloc.taskStream,
            builder: (context, snapshot) {

              final results = snapshot.data;
              return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: (snapshot.hasData)
                      ? (results!.isEmpty)
                          ? NoItems(icon: "icons/no-tasks.svg", message: "Il n'y a aucune tâche à afficher pour vous, actuellement vous n'en avez pas mais vous pouvez en créer une nouvelle.", title: "Aucune tâche trouvée", buttonText: "Créer")
                          : ListView(
                              key: ValueKey(Random.secure()),
                              controller: widget.scrollController,
                              children:
                                  results.map((e) => _buildItem(e)).toList(),
                            )
                      : Center(
                          child: SpinKitFadingCube(
                            color: active,
                            size: 25,
                            duration: Duration(milliseconds: 1200),
                          ),
                        ));
            }));
  }

  Widget _buildItem(TaskModel task) {
    return TestProxy(
        key: ValueKey(task),
        child: new ProjectTaskItem(
          task: task,
          onTap: () {},
        ));
  }
}

class TestProxy extends SingleChildRenderObjectWidget {
  TestProxy({Key? key, required Widget child}) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderProxyBox();
  }

  @override
  void updateRenderObject(BuildContext context, RenderObject renderObject) {
  }
}
