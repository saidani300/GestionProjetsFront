import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/criterion_bloc.dart';
import 'package:gestion_projets/BLoC/user_bloc.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/dialogs/forms/widgets/add_criterion.dart';
import 'package:gestion_projets/dialogs/forms/widgets/text_field.dart';
import 'package:gestion_projets/dialogs/forms/widgets/user_picker.dart';
import 'package:gestion_projets/pages/people/Data/user.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/data/evaluation.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/pages/projects/widgets/form_widgets/custom_multilines_text_field.dart';

//TODO: "Create Another one" Checkbox

class CreateEvaluationForm extends StatefulWidget {
  final Evaluation evaluation;

  const CreateEvaluationForm({
    Key? key,
    required this.evaluation,
  }) : super(key: key);

  @override
  _CreateEvaluationFormState createState() => _CreateEvaluationFormState();
}

class _CreateEvaluationFormState extends State<CreateEvaluationForm>
    with AutomaticKeepAliveClientMixin<CreateEvaluationForm> {
  List<Criterion> criteria = [];
  final ScrollController scrollController = new ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return GestureDetector(
        onTap: (){FocusManager.instance.primaryFocus!.unfocus();},
    child: BlocProvider<CriterionBloc>(
        bloc: CriterionBloc(),
    child: BlocProvider<UserBloc>(
        bloc: UserBloc(),
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
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          child: Text(
                            "Titre",
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
                          child: FormTextField(
                            seText: (String value) {
                              widget.evaluation.name = value;
                            },
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                            child: MultiLinesTextFieldWidget(
                          onChange: (value) {
                            widget.evaluation.description = value;
                          },
                          hintText: "Ajoutez plus d'informations...",
                        )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          child: Text(
                            "Responsable",
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
                          child: UserPicker(
                            onChange: (User value) {
                              widget.evaluation.user = value;
                            },
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                      "Valeur minimale",
                                      style: TextStyle(
                                          color: text,
                                          fontSize: 11.5,
                                          fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  FormTextField(
                                    seText: (String value) {
                                      widget.evaluation.maxValue =
                                          double.tryParse(value)!;
                                    },
                                    initText: "0",
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                      "Valeur maximale",
                                      style: TextStyle(
                                          color: text,
                                          fontSize: 11.5,
                                          fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  FormTextField(
                                    seText: (String value) {
                                      widget.evaluation.maxValue =
                                          double.tryParse(value)!;
                                    },
                                    initText: "0",
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          child: Row(
                            children: [
                              Text(
                                "Formule",
                                style: TextStyle(
                                    color: active,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              CustomIconButton(
                                  icon: Icons.info_outline,
                                  message: "Formule",
                                  onTap: () {})
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: FormTextField(
                          seText: (String value) {
                            widget.evaluation.formula.formula = value;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: FormTextField(
                          seText: (String value) {
                            widget.evaluation.formula.name = value;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          child: Row(
                            children: [
                              Text(
                                "Critères",
                                style: TextStyle(
                                    color: text,
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              CustomIconButton(
                                  icon: Icons.info_outline,
                                  message: "Critères",
                                  onTap: () {})
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Criteria(criteria: widget.evaluation.formula.criteria,),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ]),
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
              "icons/Project_menu_icons/event_icon_filled.svg",
              color: white,
              width: 18,
              height: 18,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "Créer une évaluation",
            style: TextStyle(
                color: text, fontSize: 13, fontWeight: FontWeight.w500),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            width: 6,
          ),
          CustomIconButton(
              icon: Icons.info_outline,
              message: 'Créer une évaluation',
              onTap: () {})
        ]));
  }
}

class AddCriterionButton extends StatefulWidget {
  final String text;
  final Function() onTap;
  final Color color;

  const AddCriterionButton(
      {Key? key, required this.text, required this.onTap, required this.color})
      : super(key: key);

  @override
  _AddCriterionButtonState createState() => _AddCriterionButtonState();
}

class _AddCriterionButtonState extends State<AddCriterionButton> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onTap: widget.onTap,
        onHover: (value) {
          value
              ? setState(() {
                  isHover = true;
                })
              : setState(() {
                  isHover = false;
                });
        },
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(3)),
            color: isHover
                ? widget.color.withAlpha(100)
                : widget.color.withAlpha(150),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                size: 20,
                color: text,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                widget.text,
                style: TextStyle(
                    color: text,
                    fontSize: 12,
                    letterSpacing: 0,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ));
  }
}
