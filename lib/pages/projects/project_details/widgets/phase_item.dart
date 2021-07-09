import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/project_details/widgets/open_close_animated_arrow.dart';
import 'package:gestion_projets/pages/projects/widgets/custom_icon_button.dart';

class PhaseItem extends StatefulWidget {
  const PhaseItem({Key? key}) : super(key: key);

  @override
  _PhaseItemState createState() => _PhaseItemState();
}

class _PhaseItemState extends State<PhaseItem>{

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column( mainAxisSize : MainAxisSize.min ,children: [
        Container(height: 60,),
        Container( child :Row(children: [
          SizedBox(width: 20),
          Expanded(child: Container(
            child: Row(
              children: [
                OpenCloseArrowButton(onTap: (){} , color: Color(0xFF08ADFF),),
                SizedBox(width: 5,),
               Expanded(child: Container(
                  child: Column(children: [ Row(
                    children: [

                      Expanded(child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                       Container(
                       decoration: BoxDecoration(
                       borderRadius: BorderRadius.only(
                       topLeft: Radius.circular(3),
                          topRight: Radius.circular(3),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0)),
                        color: Color(0xFF08ADFF),),
                      child: Padding(padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20) , child : Text(
                        "CONCEPTION",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            letterSpacing: 0,
                            fontWeight: FontWeight.w500),
                      //  textAlign: TextAlign.center,
                      ))
                       ),
                            Expanded(child: Container())
                          ],
                        ),

                       flex: 4,),

                      /*SizedBox(width: 15,),
                      Expanded(child: Container(child: Text(
                        "Date d'échéance",
                        style: textStyle_Text_12_600,
                        textAlign: TextAlign.start,
                      ),), flex: 1),
                      SizedBox(width: 15,),
                      Expanded(child: Container(child: Text(
                        "Responsable",
                        style: textStyle_Text_12_600,
                        textAlign: TextAlign.start,
                      )) , flex: 1),
                      SizedBox(width: 15,),
                      Expanded(child: Container(child: Text(
                        "Priorité",
                        style: textStyle_Text_12_600,
                        textAlign: TextAlign.start,
                      )) , flex: 1),
                      SizedBox(width: 15,),
                      Expanded(child: Container(child: Text(
                        "État",
                        style: textStyle_Text_12_600,
                        textAlign: TextAlign.start,
                      )) , flex: 1),*/
                      SizedBox(width: 15,),
                      CustomIconButton(icon: Icons.add_circle_rounded, message: "", enableToolTip: false,  onTap: (){}, size: 23,)
                    ],
                  ),
              DottedLine(
                direction: Axis.horizontal,
                lineLength: double.infinity,
                lineThickness: 1.0,
                dashLength: 2,
                dashColor: text.withOpacity(0.3),
                dashRadius: 0.0,
                dashGapLength: 2,
                dashGapColor: Colors.transparent,
                dashGapRadius: 0.0,
              )
              ])
                )

               ) ],
            ),

          )),
          SizedBox(width: 20),
        ],)
        ),

      ],),
    );
  }
}

