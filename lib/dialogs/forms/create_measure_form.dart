import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/dialogs/forms/widgets/date_picker.dart';
import 'package:gestion_projets/dialogs/forms/widgets/text_field.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/data/indicator.dart';
import 'package:gestion_projets/pages/projects/project_details/objectives/data/measure.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/pages/projects/widgets/form_widgets/custom_multilines_text_field.dart';

//TODO: "Create Another one" Checkbox

class CreateMeasureForm extends StatefulWidget {
  final Measure measure;
  final Indicator indicator;

  const CreateMeasureForm({
    Key? key,
    required this.measure,
    required this.indicator,
  }) : super(key: key);

  @override
  _CreateMeasureFormState createState() => _CreateMeasureFormState();
}

class _CreateMeasureFormState extends State<CreateMeasureForm>
    with AutomaticKeepAliveClientMixin<CreateMeasureForm> {
  final ScrollController scrollController = new ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus!.unfocus();
        },
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
                Scrollbar(
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
                                "Mesure",
                                style: TextStyle(
                                    color: text,
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.start,
                              ),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: FormTextField(
                            seText: (String value) {
                              widget.measure.value = double.tryParse(value)!;
                            },
                            hintText:
                                'Une valeur entre ${widget.indicator.minValue} et ${widget.indicator.maxValue}',
                            suffixText: widget.indicator.unit,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(mainAxisSize: MainAxisSize.max, children: [
                            Expanded(
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Date de début",
                                      style: TextStyle(
                                          color: text,
                                          fontSize: 11.5,
                                          fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.start,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    DatePickerWidget(
                                      height: 40,
                                      setDate: (DateTime date) {
                                        widget.measure.startDate = date;
                                      },
                                      initDate: widget.measure.startDate,
                                    ),
                                  ]),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Date de fin",
                                      style: TextStyle(
                                          color: text,
                                          fontSize: 11.5,
                                          fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.start,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    new DatePickerWidget(
                                        height: 40,
                                        setDate: (DateTime date) {
                                          widget.measure.endDate = date;
                                        },
                                        initDate: widget.measure.endDate),
                                  ]),
                            ),
                          ]),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            child: Text(
                              "Commentaire",
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
                              widget.measure.comment = value;
                            },
                            hintText:
                                "Ajouter un commentaire à cette mesure...",
                          )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ]),
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
            "Ajouter une mesure",
            style: TextStyle(
                color: text, fontSize: 13, fontWeight: FontWeight.w500),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            width: 6,
          ),
          CustomIconButton(
              icon: Icons.info_outline,
              message: 'Ajouter une mesure',
              onTap: () {})
        ]));
  }
}
