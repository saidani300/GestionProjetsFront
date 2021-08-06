import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/dialogs/forms/widgets/date_picker.dart';
import 'package:gestion_projets/dialogs/forms/widgets/text_field.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/data/calculation.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';

//TODO: "Create Another one" Checkbox

class CreateCalculationForm extends StatefulWidget {
  final Calculation calculation;

  const CreateCalculationForm({
    Key? key,
    required this.calculation,
  }) : super(key: key);

  @override
  _CreateCalculationFormState createState() => _CreateCalculationFormState();
}

class _CreateCalculationFormState extends State<CreateCalculationForm>
    with AutomaticKeepAliveClientMixin<CreateCalculationForm> {
  final ScrollController scrollController = new ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return GestureDetector(
        onTap: (){FocusManager.instance.primaryFocus!.unfocus();},
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
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: widget.calculation.criteria
                          .map((e) => Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Container(
                                      child: Text(
                                        e.name,
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
                                          e.value = double.tryParse(value) ?? 0;
                                        },
                                      )),
                                ],
                              ))
                          .toList(),
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
                                    widget.calculation.startDate = date;
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
                                      widget.calculation.endDate = date;
                                    },
                                    initDate: DateTime.now().add(Duration(days: 30))),
                              ]),
                        ),
                      ]),
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
            "Ajouter un calcul",
            style: TextStyle(
                color: text, fontSize: 13, fontWeight: FontWeight.w500),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            width: 6,
          ),
          CustomIconButton(
              icon: Icons.info_outline,
              message: 'Ajouter un calcul',
              onTap: () {})
        ]));
  }
}
