import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gestion_projets/BLoC/user_bloc.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/dialogs/forms/widgets/add_project_type.dart';
import 'package:gestion_projets/dialogs/forms/widgets/date_picker.dart';
import 'package:gestion_projets/dialogs/forms/widgets/priority_picker.dart';
import 'package:gestion_projets/dialogs/forms/widgets/text_field.dart';
import 'package:gestion_projets/dialogs/forms/widgets/user_picker.dart';
import 'package:gestion_projets/pages/people/Data/user.dart';
import 'package:gestion_projets/pages/projects/Data/project.dart';
import 'package:gestion_projets/pages/projects/Data/project_type.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/file_upload_bloc.dart';
import 'package:gestion_projets/BLoC/project_type_bloc.dart';
import 'package:gestion_projets/pages/projects/project_details/documents/data/document.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/pages/projects/widgets/form_widgets/custom_multilines_text_field.dart';
import 'package:gestion_projets/pages/projects/widgets/form_widgets/custom_select_list.dart';

import 'widgets/add_attachments.dart';

//TODO: "Create Another one" Checkbox

class CreateProjectForm extends StatefulWidget {
  final Project project;

  const CreateProjectForm({Key? key, required this.project}) : super(key: key);

  @override
  _CreateProjectFormState createState() => _CreateProjectFormState();
}

class _CreateProjectFormState extends State<CreateProjectForm>
    with AutomaticKeepAliveClientMixin<CreateProjectForm> {
  List<Document> documents = [];
  final ScrollController scrollController = new ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return GestureDetector(
      onTap: (){FocusManager.instance.primaryFocus!.unfocus();},
      child: BlocProvider<UserBloc>(
          bloc: UserBloc(),
      child: BlocProvider<ProjectTypeBloc>(
          bloc: ProjectTypeBloc(),
          child: BlocProvider<UploadBloc>(
              bloc: UploadBloc(),
              child: Container(
                width: 500,
                constraints: BoxConstraints(maxHeight: 522),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      FormHeader(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 1),
                        child: Divider(
                          height: 1,
                          color: dividerColor,
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Scrollbar(
                            isAlwaysShown: true,
                            controller: scrollController,
                            child: ListView(
                                shrinkWrap: true,
                                controller: scrollController,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Container(
                                      child: Text(
                                        "Nom du projet",
                                        style: TextStyle(
                                            color: text,
                                            fontSize: 11.5,
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: FormTextField(
                                      seText: (String value) {
                                        widget.project.name = value;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: AddProjectType()
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                            Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: ProjectTypeBox(project: widget.project)),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Date de début",
                                                    style: TextStyle(
                                                        color: text,
                                                        fontSize: 11.5,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  DatePickerWidget(
                                                    height: 40,
                                                    setDate: (DateTime date) {
                                                      widget.project.startDate =
                                                          date;
                                                    },
                                                    initDate: DateTime.now(),
                                                  ),
                                                ]),
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Date de fin",
                                                    style: TextStyle(
                                                        color: text,
                                                        fontSize: 11.5,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  new DatePickerWidget(
                                                    height: 40,
                                                    setDate: (DateTime date) {
                                                      widget.project.endDate =
                                                          date;
                                                    },
                                                    initDate: DateTime.now()
                                                        .add(Duration(days: 30)),
                                                  ),
                                                ]),
                                          ),
                                        ]),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Container(
                                      child: Text(
                                        "Chef d'équipe",
                                        style: TextStyle(
                                            color: text,
                                            fontSize: 11.5,
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: UserPicker(
                                      onChange: (User value) {
                                        widget.project.teamLeader = value;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Container(
                                      child: Text(
                                        "Priorité",
                                        style: TextStyle(
                                            color: text,
                                            fontSize: 11.5,
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  PriorityBox(
                                    setPriority: (Priority priority) {
                                      widget.project.priority = priority;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Container(
                                      child: Text(
                                        "Pièces jointes",
                                        style: TextStyle(
                                            color: text,
                                            fontSize: 11.5,
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Attachments(
                                      documents: widget.project.documents,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Container(
                                      child: Text(
                                        "Description",
                                        style: TextStyle(
                                            color: text,
                                            fontSize: 11.5,
                                            fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Container(
                                        child: MultiLinesTextFieldWidget(
                                      onChange: (value) {},
                                      hintText:
                                          "Ajoutez plus d'informations a ce projet...",
                                    )),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ]),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 1),
                        child: Divider(
                          height: 1,
                          color: dividerColor,
                        ),
                      )
                    ]),
              )))),
    );
  }
}

class FormHeader extends StatelessWidget {
  const FormHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(children: [
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: active,
              ),
              child: Icon(
                Icons.layers_rounded,
                size: 20,
                color: white,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Créer un projet",
              style: TextStyle(
                  color: text, fontSize: 13, fontWeight: FontWeight.w500),
              textAlign: TextAlign.start,
            ),
            SizedBox(
              width: 6,
            ),
            CustomIconButton(
                icon: Icons.info_outline,
                message: 'Créer un projet',
                onTap: () {})
          ]),
    );
  }
}

class ProjectTypeBox extends StatefulWidget {
  final Project project;

  const ProjectTypeBox({Key? key, required this.project}) : super(key: key);

  @override
  _ProjectTypeBoxState createState() => _ProjectTypeBoxState();
}

class _ProjectTypeBoxState extends State<ProjectTypeBox>
    with AutomaticKeepAliveClientMixin<ProjectTypeBox> {
  late final bloc;
  ProjectType? selectedType = projectTypesList.first;

  @override
  void initState() {
    bloc = BlocProvider.of<ProjectTypeBloc>(context);
    super.initState();
    bloc.init();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<List<ProjectType>>(
          stream: bloc.projectTypeStream,
          builder: (context, snapshot) {
            List<ProjectType>? results = snapshot.data;
            return CustomListPopupMenuButton<ProjectType>(
                containerHeight: 40,
                offset: Offset(0, 42),
                child: (snapshot.hasData)
                    ? Text(
                        snapshot.data!.isNotEmpty ? selectedType!.name : "",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      )
                    : Center(
                  child: SpinKitThreeBounce(
                    color: active,
                    size: 15,
                    duration: Duration(milliseconds: 1200),
                  ),
                ),
                enabled: true,
                onSelected: (value) {
                  setState(() {
                    selectedType = value;
                  });
                  widget.project.type = value;
                },
                itemBuilder: (context) {
                  return (snapshot.hasData)
                      ? results!
                          .map((e) => CustomListPopupMenuItem(
                                value: e,
                                height: 50,
                                child: SizedBox(
                                    width: 460,
                                    child: Padding(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Row(
                                          children: [
                                            Text(
                                              e.name,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                              ),
                                            ),
                                            Expanded(child: Container()),
                                            CustomIconButton(
                                                icon: Icons.close_rounded,
                                                message: "Supprimer",
                                                size: 15,
                                                color: lightRed,
                                                onTap: () {
                                                  bloc.remove(e);
                                                  if (selectedType == e) {
                                                    setState(() {
                                                      selectedType =
                                                          results.first;
                                                    });
                                                  }
                                                  Navigator.pop(context);
                                                }),
                                            SizedBox(
                                              width: 15,
                                            )
                                          ],
                                        ))),
                              ))
                          .toList()
                      : [];
                });
          }
    );
  }
}
