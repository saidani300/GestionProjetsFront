import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/user_bloc.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/dialogs/forms/widgets/text_field.dart';
import 'package:gestion_projets/dialogs/forms/widgets/user_picker.dart';
import 'package:gestion_projets/pages/people/Data/user.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/data/indicator.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/pages/projects/widgets/form_widgets/custom_multilines_text_field.dart';
import 'package:gestion_projets/pages/projects/widgets/form_widgets/custom_select_list.dart';


//TODO: "Create Another one" Checkbox

class CreateIndicatorForm extends StatefulWidget {
  final Indicator indicator;
  const CreateIndicatorForm({Key? key, required this.indicator}) : super(key: key);

  @override
  _CreateIndicatorFormState createState() => _CreateIndicatorFormState();
}

class _CreateIndicatorFormState extends State<CreateIndicatorForm>
    with AutomaticKeepAliveClientMixin<CreateIndicatorForm> {
  final ScrollController scrollController = new ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocProvider<UserBloc>(
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
                                  "Nom de l'indicateur",
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
                                  widget.indicator.name = value;
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
                                  "Type de l'indicateur",
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
                              child: IndicatorTypeBox(indicator: widget.indicator,),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20),
                              child: Container(
                                child: Text(
                                  "Méthode de calcul",
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
                                  widget.indicator.calculationMethod = value;
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
                                  "Fréquence",
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
                              child: IndicatorFrequencyBox(indicator: widget.indicator,),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20),
                              child: Container(
                                child: Text(
                                  "Nature",
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
                              child: IndicatorNatureBox(indicator: widget.indicator,),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                child: Text(
                                  "Superviseur",
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
                                    widget.indicator.user = value;
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
                                            widget.indicator.maxValue =
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
                                            widget.indicator.maxValue =
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
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text(
                                            "Seuil critique",
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
                                            widget.indicator.criticalThreshold =
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
                                            "Unité de mesure",
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
                                            widget.indicator.unit = value;
                                          },
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
                                    "Ajoutez plus d'informations sur cet indicateur...",
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
            "Créer un indicateur",
            style: TextStyle(
                color: text, fontSize: 13, fontWeight: FontWeight.w500),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            width: 6,
          ),
          CustomIconButton(
              icon: Icons.info_outline,
              message: 'Créer un indicateur',
              onTap: () {})
        ]));
  }
}


class IndicatorTypeBox extends StatefulWidget {
  final Indicator indicator;

  const IndicatorTypeBox({Key? key, required this.indicator}) : super(key: key);

  @override
  _IndicatorTypeBoxState createState() => _IndicatorTypeBoxState();
}

class _IndicatorTypeBoxState extends State<IndicatorTypeBox>
    with AutomaticKeepAliveClientMixin<IndicatorTypeBox> {
  IndicatorType selectedType = IndicatorType.type1;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomListPopupMenuButton<IndicatorType>(
        containerHeight: 40,
        offset: Offset(0, 42),
        child: Text(
          indicatorTypeAsText(selectedType),
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
          widget.indicator.type = value;
        },
        itemBuilder: (context) {
          return IndicatorType.values
              .map((e) => CustomListPopupMenuItem(
            value: e,
            height: 50,
            child: SizedBox(
                width: 460,
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    indicatorTypeAsText(e),
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


class IndicatorFrequencyBox extends StatefulWidget {
  final Indicator indicator;

  const IndicatorFrequencyBox({Key? key, required this.indicator}) : super(key: key);

  @override
  _IndicatorFrequencyBoxState createState() => _IndicatorFrequencyBoxState();
}

class _IndicatorFrequencyBoxState extends State<IndicatorFrequencyBox>
    with AutomaticKeepAliveClientMixin<IndicatorFrequencyBox> {
  Frequency selectedFrequency = Frequency.monthly;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomListPopupMenuButton<Frequency>(
        containerHeight: 40,
        offset: Offset(0, 42),
        child: Text(
          indicatorFrequencyAsText(selectedFrequency),
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
        enabled: true,
        onSelected: (value) {
          setState(() {
            selectedFrequency = value;
          });
          widget.indicator.frequency = value;
        },
        itemBuilder: (context) {
          return Frequency.values
              .map((e) => CustomListPopupMenuItem(
            value: e,
            height: 50,
            child: SizedBox(
                width: 460,
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    indicatorFrequencyAsText(e),
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


class IndicatorNatureBox extends StatefulWidget {
  final Indicator indicator;

  const IndicatorNatureBox({Key? key, required this.indicator}) : super(key: key);

  @override
  _IndicatorNatureBoxState createState() => _IndicatorNatureBoxState();
}

class _IndicatorNatureBoxState extends State<IndicatorNatureBox>
    with AutomaticKeepAliveClientMixin<IndicatorNatureBox> {
  Nature selectedNature = Nature.manual;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomListPopupMenuButton<Nature>(
        containerHeight: 40,
        offset: Offset(0, 42),
        child: Text(
          natureAsText(selectedNature),
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
        enabled: true,
        onSelected: (value) {
          setState(() {
            selectedNature = value;
          });
          widget.indicator.nature = value;
        },
        itemBuilder: (context) {
          return Nature.values
              .map((e) => CustomListPopupMenuItem(
            value: e,
            height: 50,
            child: SizedBox(
                width: 460,
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    natureAsText(e),
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