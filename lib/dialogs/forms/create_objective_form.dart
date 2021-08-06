import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/file_upload_bloc.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/dialogs/forms/widgets/date_picker.dart';
import 'package:gestion_projets/dialogs/forms/widgets/priority_picker.dart';
import 'package:gestion_projets/dialogs/forms/widgets/text_field.dart';
import 'package:gestion_projets/pages/projects/Data/project.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/data/objective.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/pages/projects/widgets/form_widgets/custom_multilines_text_field.dart';
import 'package:gestion_projets/pages/projects/widgets/form_widgets/custom_select_list.dart';

import 'widgets/add_attachments.dart';

//TODO: "Create Another one" Checkbox

class CreateObjectiveForm extends StatefulWidget {
  final Objective objective;

  const CreateObjectiveForm({Key? key, required this.objective}) : super(key: key);

  @override
  _CreateObjectiveFormState createState() => _CreateObjectiveFormState();
}

class _CreateObjectiveFormState extends State<CreateObjectiveForm>
    with AutomaticKeepAliveClientMixin<CreateObjectiveForm> {
  final ScrollController scrollController = new ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return GestureDetector(
        onTap: (){FocusManager.instance.primaryFocus!.unfocus();},
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
                                  "Nom d'objectif",
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
                                  widget.objective.name = value;
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
                                  "Type d'objectif",
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
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: ObjectiveTypeBox(objective: widget.objective),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20),
                              child: Container(
                                child: Text(
                                  "Date limite",
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
                              child: DatePickerWidget(
                                              height: 40,
                                              setDate: (DateTime date) {
                                                widget.objective.endDate =
                                                    date;
                                              },
                                              initDate: DateTime.now().add(Duration(days: 30)),
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
                                widget.objective.priority = priority;
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
                                documents: widget.objective.documents,
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
                                    onChange: (value) { },
                                    hintText:
                                    "Ajoutez plus d'informations sur cet objectif...",
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
        )));
  }
}

class FormHeader extends StatelessWidget {
  const FormHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(20),
        child: Row(children: [
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: active,
            ),
            child: SvgPicture.asset(
              "icons/Project_menu_icons/trophy_icon_filled.svg",
              color: white,
              width: 16,
              height: 16,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "Créer un objectif",
            style: TextStyle(
                color: text, fontSize: 13, fontWeight: FontWeight.w500),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            width: 6,
          ),
          CustomIconButton(
              icon: Icons.info_outline,
              message: 'Créer un objectif',
              onTap: () {})
        ]));
  }
}


class ObjectiveTypeBox extends StatefulWidget {
  final Objective objective;

  const ObjectiveTypeBox({Key? key, required this.objective}) : super(key: key);

  @override
  _ObjectiveTypeBoxState createState() => _ObjectiveTypeBoxState();
}

class _ObjectiveTypeBoxState extends State<ObjectiveTypeBox>
    with AutomaticKeepAliveClientMixin<ObjectiveTypeBox> {
  ObjectiveType selectedType = ObjectiveType.type1;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomListPopupMenuButton<ObjectiveType>(
        containerHeight: 40,
        offset: Offset(0, 42),
        child: Text(
          objectiveTypeAsText(selectedType),
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
        enabled: true,
        onSelected: (value) {
          setState(() {
            selectedType = value;
          });
          widget.objective.type = value;
        },
        itemBuilder: (context) {
          return ObjectiveType.values
              .map((e) => CustomListPopupMenuItem(
            value: e,
            height: 50,
            child: SizedBox(
                width: 460,
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    objectiveTypeAsText(e),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                )),
          ))
              .toList();
        });
  }
}