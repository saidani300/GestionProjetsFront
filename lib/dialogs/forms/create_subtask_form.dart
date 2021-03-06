import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/file_upload_bloc.dart';
import 'package:gestion_projets/BLoC/user_bloc.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/dialogs/forms/widgets/date_picker.dart';
import 'package:gestion_projets/dialogs/forms/widgets/priority_picker.dart';
import 'package:gestion_projets/dialogs/forms/widgets/text_field.dart';
import 'package:gestion_projets/dialogs/forms/widgets/user_picker.dart';
import 'package:gestion_projets/pages/people/Data/user.dart';
import 'package:gestion_projets/pages/projects/Data/project.dart';
import 'package:gestion_projets/pages/projects/project_details/tasks/data/task_model.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/pages/projects/widgets/form_widgets/custom_multilines_text_field.dart';

import 'widgets/add_attachments.dart';

//TODO: "Create Another one" Checkbox

class CreateSubTaskForm extends StatefulWidget {
  final bool isSubTask;
  final TaskModel task;

  const CreateSubTaskForm({Key? key, required this.task , required this.isSubTask}) : super(key: key);

  @override
  _CreateSubTaskFormState createState() => _CreateSubTaskFormState();
}

class _CreateSubTaskFormState extends State<CreateSubTaskForm>
    with AutomaticKeepAliveClientMixin<CreateSubTaskForm> {
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
        child: BlocProvider<UploadBloc>(
            bloc: UploadBloc(),
            child: Container(
              width: 500,
              constraints: BoxConstraints(maxHeight: 522),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FormHeader(isSubTask: widget.isSubTask,),
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
                                      "Nom du t??che",
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
                                      widget.task.name = value;
                                    },
                                  ),
                                ),
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
                                                  "Date de d??but",
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
                                                    widget.task.startDate =
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
                                                    widget.task.endDate =
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
                                      "Affecter ??",
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
                                      widget.task.user = value;
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
                                      "Priorit??",
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
                                    widget.task.priority = priority;
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
                                      "Pi??ces jointes",
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
                                    documents: widget.task.documents,
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
                                        "Ajoutez plus d'informations sur cette t??che...",
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
            ))));
  }
}

class FormHeader extends StatelessWidget {
  final bool isSubTask;
  const FormHeader({Key? key , required this.isSubTask}) : super(key: key);

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
              "icons/Project_menu_icons/task_icon_filled.svg",
              color: white,
              width: 16,
              height: 16,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            isSubTask? "Cr??er une sous-t??che" :"Cr??er une t??che",
            style: TextStyle(
                color: text, fontSize: 13, fontWeight: FontWeight.w500),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            width: 6,
          ),
          CustomIconButton(
              icon: Icons.info_outline,
              message: isSubTask? "Cr??er une sous-t??che" : 'Cr??er une t??che',
              onTap: () {})
        ]));
  }
}
