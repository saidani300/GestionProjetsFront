import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/Data/check_box_item.dart';
import 'package:gestion_projets/pages/projects/body/projects_body.dart';
import 'package:get/get.dart';
import 'package:gestion_projets/helpers/custom_drop_down_menu.dart';



class Filter extends StatefulWidget {

  @override
  FilterState createState() => new FilterState();
}


class FilterState extends State<Filter> {
 /* final Function(String) onchange;

  FilterState(this.onchange);*/

  // const CheckBoxList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
        height: 60,
        child: Row(
            children: [
              SizedBox(
                width: 20,
              ), Theme(
                data: Theme.of(context).copyWith(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    hoverColor: active.withOpacity(0.03),
                    dividerTheme: DividerThemeData(
                      thickness: 0.5,
                      space: 0,
                    )),
                child: CustomPopupMenuButton(
                  enableFeedback: true,
                      padding: EdgeInsets.all(0),
                      elevation: 5,
                      offset: Offset(0, 50),
                      // splashRadius: 20,
                      // hoverColor: active.withOpacity(0.1),
                      // iconSize: 20,
                      child: Container(
                        height: 40,
                        width: 40,
                        child: Icon(
                          Icons.merge_type,
                          color: text,
                          size: 20,
                        ),
                      ),
//Items
                      itemBuilder: (context) => [
                        CustomPopupMenuItem( enabled : true , value : 0,child:
                        Container( height: 150 , width: 250,child: ListView(
                          children: [...typesList.map(buildCheckbox)
                              .toList()
                          ],))),
                      ]

                    ),
                  ),


            ]
        ));
  }

  Widget buildCheckbox(CheckBoxItem checkbox) =>
      CheckboxListTile(
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
          onChanged: (value) => setState(() => checkbox.value = value!));

}


