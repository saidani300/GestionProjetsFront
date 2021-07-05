import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/Data/check_box_item.dart';
import 'package:gestion_projets/pages/projects/body/projects_body.dart';
import 'package:gestion_projets/helpers/custom_drop_down_menu.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_checkbox.dart';
import 'package:gestion_projets/widgets/custom_outlined_button.dart';
import 'package:intl/intl.dart';

import 'date_picker.dart';

class Filter extends StatefulWidget {
  final Function() apply;

  const Filter({Key? key,required this.apply}) : super(key: key);
  @override
  State<Filter> createState() => new FilterState();
}

class FilterState extends State<Filter> {
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Expanded(
          child: Padding(
              padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
              child: Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 30,
                  runSpacing: 30,
                  direction: Axis.horizontal,
                  children: [
                    Theme(
                      data: Theme.of(context).copyWith(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        hoverColor: active.withOpacity(0.03),
                        dividerTheme: DividerThemeData(
                          color: text.withOpacity((0.5)),
                          thickness: 0.5,
                          space: 0,
                        ),
                      ),
                      child: CustomPopupMenuButton(
                          padding: EdgeInsets.all(0),
                          elevation: 5,
                          offset: Offset(0, 50),
                          // splashRadius: 20,
                          // hoverColor: active.withOpacity(0.1),
                          // iconSize: 20,
                          child: Container(
                              width: 180,
                              height: 34,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: active, width: 1.4),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                      child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 3, 0, 3),
                                          child: Text(
                                            "Type de projet",
                                            style: TextStyle(
                                                color: text,
                                                fontSize: 12.5,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w500),
                                          ))),
                                  Container(
                                      width: 34,
                                      child: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: text.withOpacity(0.7),
                                        size: 18,
                                      )),
                                ],
                              )),
//Items
                          itemBuilder: (context) => [
                                CustomPopupMenuItem(
                                    enabled: false,
                                    value: 0,
                                    child: Container(
                                        height: 192,
                                        width: 252,
                                        child: ListView(
                                          children: [
                                            CustomCheckAllBox(
                                              allItems: checkAll,
                                            ),
                                            Divider(
                                              height: 1,
                                            ),
                                            ...typesList
                                                .map((item) => CustomCheckBox(
                                                      item: item,
                                                    ))
                                                .toList()
                                          ],
                                        ))),
                              ]),
                    ),
                    Theme(
                      data: Theme.of(context).copyWith(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        hoverColor: active.withOpacity(0.03),
                        dividerTheme: DividerThemeData(
                          color: text.withOpacity((0.5)),
                          thickness: 0.5,
                          space: 0,
                        ),
                      ),
                      child: CustomPopupMenuButton(
                          padding: EdgeInsets.all(0),
                          elevation: 5,
                          offset: Offset(0, 50),
                          // splashRadius: 20,
                          // hoverColor: active.withOpacity(0.1),
                          // iconSize: 20,
                          child: Container(
                              width: 180,
                              height: 34,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: active, width: 1.4),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                      child: Padding(
                                          padding:
                                          EdgeInsets.fromLTRB(10, 3, 0, 3),
                                          child: Text(
                                            "Chef d'équipe",
                                            style: TextStyle(
                                                color: text,
                                                fontSize: 12.5,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w500),
                                          ))),
                                  Container(
                                      width: 34,
                                      child: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: text.withOpacity(0.7),
                                        size: 18,
                                      )),
                                ],
                              )),
//Items
                          itemBuilder: (context) => [
                            CustomPopupMenuItem(
                                enabled: false,
                                value: 0,
                                child: Container(
                                    height: 192,
                                    width: 252,
                                    child: ListView(
                                      children: [
                                        CustomCheckAllBoxLeader(
                                          allItems: checkAllLeader,
                                        ),
                                        Divider(
                                          height: 1,
                                        ),
                                        ...LeaderList
                                            .map((item) => CustomCheckBoxLeader(
                                          item: item,
                                        ))
                                            .toList()
                                      ],
                                    ))),
                          ]),
                    ),
                    Container(
                        width: 320,
                        child: Row(children: [
                          Container(
                              width: 100,
                              child: Text(
                                "Date de début: ",
                                style: TextStyle(
                                    color: text,
                                    fontSize: 12,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w500),
                              )),
                          SizedBox(
                            width: 20,
                          ),
                          new CustomOutlinedButton(
                            buttonText: getText(startDate),
                            icon: Icons.date_range_rounded,
                            onTap: () {
                              pickStartDate(context);
                            },
                          ),
                        ])),
                    Container(
                        width: 320,
                        child: Row(children: [
                          Container(
                              width: 100,
                              child: Text(
                                "Date de fin: ",
                                style: TextStyle(
                                    color: text,
                                    fontSize: 12,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w500),
                              )),
                          SizedBox(
                            width: 20,
                          ),
                          new CustomOutlinedButton(
                            buttonText: getText(endDate),
                            icon: Icons.date_range_rounded,
                            onTap: () {
                              pickEndDate(context);
                            },
                          ),
                        ])),
                    /*Container( child: Row( children : [*/
                    TextButton(
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all<Size>(
                            Size(double.infinity, 34)),
                        // backgroundColor: MaterialStateProperty.all<Color>(active),
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color?>((states) {
                          if (states.contains(MaterialState.hovered)) {
                            return buttonHover;
                          } else {
                            return active;
                          }
                        }),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(horizontal: 20, vertical: 16)),
                      ),
                      onPressed: widget.apply,
                      child: Text(
                      'Appliquer',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 11.5,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w400),
                      ),
                    ),

                  ])))
    ]);
  }

  Widget buildCheckbox(CheckBoxItem checkbox) => CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: active,
      value: checkbox.value,
      title: Text(
        checkbox.title,
        style: TextStyle(
            color: text,
            fontFamily: 'Montserrat',
            fontSize: 12,
            letterSpacing: 0,
            fontWeight: FontWeight.w500),
      ),
      onChanged: (value) => {
            setState(() {
              checkbox.value = value!;
            })
          });

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
