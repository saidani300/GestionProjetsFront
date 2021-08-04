import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/file_upload_bloc.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/dialogs/forms/widgets/date_picker.dart';
import 'package:gestion_projets/dialogs/forms/widgets/priority_picker.dart';
import 'package:gestion_projets/dialogs/forms/widgets/text_field.dart';
import 'package:gestion_projets/pages/projects/Data/project.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data/phase.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/pages/projects/widgets/form_widgets/custom_multilines_text_field.dart';

import 'widgets/add_attachments.dart';

//TODO: "Create Another one" Checkbox

class CreatePhaseForm extends StatefulWidget {
  final Phase phase;

  const CreatePhaseForm({Key? key, required this.phase}) : super(key: key);

  @override
  _CreatePhaseFormState createState() => _CreatePhaseFormState();
}

class _CreatePhaseFormState extends State<CreatePhaseForm>
    with AutomaticKeepAliveClientMixin<CreatePhaseForm> {
  final ScrollController scrollController = new ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocProvider<UploadBloc>(
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
                                          "Nom du Phase",
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
                                          widget.phase.name = value;
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
                                                        widget.phase.startDate =
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
                                                        widget.phase.endDate =
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
                                        widget.phase.priority = priority;
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
                                        documents: widget.phase.documents,
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
                                            "Ajoutez plus d'informations sur cette phase...",
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
                ));
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
            child: Icon(
              Icons.account_tree_rounded,
              size: 20,
              color: white,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "Créer une phase",
            style: TextStyle(
                color: text, fontSize: 13, fontWeight: FontWeight.w500),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            width: 6,
          ),
          CustomIconButton(
              icon: Icons.info_outline,
              message: 'Créer une phase',
              onTap: () {})
        ]));
  }
}
