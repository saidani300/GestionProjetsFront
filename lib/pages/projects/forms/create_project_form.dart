import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/Data/check_box_item.dart';
import 'package:gestion_projets/pages/projects/Data/items.dart';
import 'package:gestion_projets/pages/projects/filter/date_picker.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';
import 'package:gestion_projets/pages/projects/widgets/form_widgets/custom_form_text_field.dart';
import 'package:gestion_projets/pages/projects/widgets/form_widgets/custom_multilines_text_field.dart';
import 'package:gestion_projets/pages/projects/widgets/form_widgets/custom_select_list.dart';
import 'package:gestion_projets/pages/projects/widgets/project_item.dart';
import 'package:gestion_projets/widgets/custom_outlined_button.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

//TODO : Make all fields and select lists reusable and globale.
//TODO : Save Data in object.
//TODO: Make Avatar with name letters reusable
//TODO: "Create Another one" Checkbox

bool _firstChild = true;
DateTime startDate = DateTime.now();
DateTime endDate = DateTime.now();
String selectedType = "Développement";
CheckBoxItemLeader selectedLeader = LeaderList[0];
PriorityItem priorityLevel = priorityItems[1];
String projectName = "";
class CreateProjectForm extends StatefulWidget {
  @override
  _CreateProjectFormState createState() => _CreateProjectFormState();
}

class _CreateProjectFormState extends State<CreateProjectForm> {

  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Padding(
              padding: EdgeInsets.all(30),
              child: Row(children: [
                Icon(
                  Icons.layers_rounded,
                  size: 20,
                  color: active,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Créer un projet",
                  style: TextStyle(
                      color: text, fontSize: 14, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  width: 6,
                ),
                CustomIconButton(icon: Icons.info_outline, message: 'Créer un projet', onTap: (){})
              ])),
          Divider(
            height: 1,
            color: dark.withOpacity(0.15),
          ),
          Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Row(mainAxisSize: MainAxisSize.min, children: [
                  SizedBox(width: 30),
                  Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 30),
                        Text(
                          "Nom du projet",
                          style: TextStyle(
                              color: text,
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                                  width: 300,
                                  height: 40,
                                  child: TextFormField(
                                    initialValue: projectName,
                                    cursorWidth: 1.5,
                                   // controller: controller,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: text.withOpacity(0.4), width: 1.4),),
                                      focusedBorder: const OutlineInputBorder(borderSide: const BorderSide(color: active, width: 1.4),)

                                    ),
                                    style: TextStyle(color: text, fontSize: 13, fontWeight: FontWeight.w500),
                                    maxLines: 1,
                                      onChanged: (value){
                                      setState(() {
                                        projectName = value;
                                      });
                                      },

                                )),
                      ]),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: 300,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Type de projet",
                                    style: TextStyle(
                                        color: text,
                                        fontSize: 11.5,
                                        fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.start,
                                  ),
                                  Expanded(child: Container()),
                                  CustomIconButton(
                                    icon: Icons.add_circle_rounded,
                                    size: 17,
                                    message: "Ajouter",
                                    onTap: () {},
                                  )
                                ])),
                        SizedBox(
                          height: 10,
                        ),
                        CustomListPopupMenuButton<CheckBoxItem>(
                            containerHeight: 40,
                            containerWidth: 300,
                            offset: Offset(0, 42),
                            child: Text(
                              selectedType,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                            enabled: true,
                            onSelected: (value) {
                              setState(() {
                                selectedType = value.title;
                              });
                            },
                            itemBuilder: (context) {
                              return typesList.map((CheckBoxItem choice) {
                                return CustomListPopupMenuItem(
                                  value: choice,
                                  height: 50,
                                  child: SizedBox(
                                      width: 300,
                                      child: Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(
                                            choice.title,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Montserrat',
                                              fontSize: 12,
                                            ),
                                          ))),
                                );
                              }).toList();
                            })
                      ]),
                  SizedBox(width: 30),
                ]),
                SizedBox(
                  height: 30,
                ),
                Row(mainAxisSize: MainAxisSize.min, children: [
                  SizedBox(width: 30),
                  Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 30),
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
                        new DatePickerWidget(
                          width: 300,
                          height: 40,
                          dateAsText: getText(startDate),
                          onTap: () => pickStartDate(context),
                        ),
                      ]),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
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
                          width: 300,
                          height: 40,
                          dateAsText: getText(endDate),
                          onTap: () => pickEndDate(context),
                        ),
                      ]),
                  SizedBox(width: 30),
                ]),
                SizedBox(
                  height: 30,
                ),
                Row(mainAxisSize: MainAxisSize.min, children: [
                  SizedBox(width: 30),
                  Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 30),
                        Text(
                          "Chef d'équipe",
                          style: TextStyle(
                              color: text,
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomListPopupMenuButton<CheckBoxItemLeader>(
                            containerHeight: 40,
                            containerWidth: 300,
                            offset: Offset(0, 42),
                            child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: CircleAvatar(
                                      child: Text(
                                          profileInitials(selectedLeader.name),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 7,
                                              letterSpacing: 1)),
                                      foregroundColor: Colors.white,
                                      backgroundColor: colors[int.tryParse(
                                              selectedLeader.profileImage) ??
                                          0],
                                    ),
                                    height: 25,
                                    width: 25,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    selectedLeader.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  )
                                ]),
                            enabled: true,
                            onSelected: (value) {
                              setState(() {
                                selectedLeader = value;
                              });
                            },
                            itemBuilder: (context) {
                              return LeaderList.map(
                                  (CheckBoxItemLeader choice) {
                                return CustomListPopupMenuItem(
                                  value: choice,
                                  height: 50,
                                  child: SizedBox(
                                      width: 300,
                                      child: Row(
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Container(
                                                child: CircleAvatar(
                                                  child: Text(
                                                      profileInitials(
                                                          choice.name),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 9,
                                                          letterSpacing: 1)),
                                                  foregroundColor: Colors.white,
                                                  backgroundColor: colors[
                                                      int.tryParse(choice
                                                              .profileImage) ??
                                                          0],
                                                ),
                                                height: 25,
                                                width: 25,
                                              )),
                                          Text(
                                            choice.name,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Montserrat',
                                              fontSize: 12,
                                            ),
                                          )
                                        ],
                                      )),
                                );
                              }).toList();
                            })
                      ]),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Priorité",
                          style: TextStyle(
                              color: text,
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomListPopupMenuButton<PriorityItem>(
                            containerHeight: 40,
                            containerWidth: 300,
                            offset: Offset(0, 42),
                            child: Row(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    priorityLevel.icon,
                                    size: 20,
                                    color: priorityLevel.color,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    priorityLevel.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  )
                                ]),
                            enabled: true,
                            onSelected: (value) {
                              setState(() {
                                priorityLevel = value;
                              });
                            },
                            itemBuilder: (context) {
                              return priorityItems.map((PriorityItem choice) {
                                return CustomListPopupMenuItem(
                                  value: choice,
                                  height: 50,
                                  child: SizedBox(
                                      width: 300,
                                      child: Row(
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Icon(
                                                choice.icon,
                                                size: 20,
                                                color: choice.color,
                                              )),
                                          Text(
                                            choice.name,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                            ),
                                          )
                                        ],
                                      )),
                                );
                              }).toList();
                            })
                      ]),
                  SizedBox(width: 30),
                ]),
                SizedBox(
                  height: 20,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: TextButton.icon(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.transparent),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(horizontal: 0, vertical: 0)),
                      ),
                      onPressed: () {
                        setState(() {
                          _firstChild = !_firstChild;
                        });
                      },
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: active,
                        size: 18,
                      ),
                      label: Text(
                        'Ajouter plus de détails  ',
                        style: TextStyle(
                            color: active,
                            fontSize: 11,
                            fontWeight: FontWeight.w400),
                      ),
                    )),
                AnimatedCrossFade(
                  firstCurve: Curves.easeIn,
                  secondCurve: Curves.easeOut,
                  firstChild: Container(),
                  secondChild: Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Description",
                                  style: TextStyle(
                                      color: text,
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    height: 120,
                                    child: ConstrainedBox(
                                        constraints: BoxConstraints(
                                            minWidth: 150, maxWidth: 620),
                                        child: MultiLinesTextFieldWidget(
                                          text: '',
                                        )))
                              ]))
                    ],
                  ),
                  crossFadeState: _firstChild
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: Duration(milliseconds: 200),
                ),
              ]),
          SizedBox(
            height: 30,
          ),
          Divider(
            height: 1,
            color: dark.withOpacity(0.15),
          )
        ]));
  }

  String getText(DateTime date) => DateFormat.yMMMMd('fr_FR').format(date);

  Future pickStartDate(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (newDate == null) return;
    setState(() => startDate = newDate);
  }

  Future pickEndDate(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: endDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );
    if (newDate == null) return;
    setState(() => endDate = newDate);
  }
}
