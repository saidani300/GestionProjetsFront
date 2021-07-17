import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gestion_projets/constants/style.dart';

class NoPhases extends StatelessWidget {
  const NoPhases({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center( child:
    Padding(padding: EdgeInsets.all(30), child :Column( mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: Container()),
        /*Icon(Icons.layers_clear_rounded , size: 35, color: text.withOpacity(0.5),),*/
        SvgPicture.asset(
          "icons/no-phase.svg",
          color: text.withOpacity(0.5),
          width: 30,
          height: 30,

        ),
        SizedBox(height: 10,),
        Text(
          "Aucune phase ou action trouvée",
          style: TextStyle(
              color: text,
              fontSize: 17,
              letterSpacing: 0,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 10,),
        Flexible(child: Text(
          "Il n'y a aucune phase ou action à afficher pour vous, actuellement vous n'en avez pas mais vous pouvez en créer une nouvelle.",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: text.withOpacity(0.8),
              fontSize: 12.5,
              letterSpacing: 0,
              fontWeight: FontWeight.w500),
        ),),
        SizedBox(height: 20,),
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
          onPressed: (){},
          child: Text(
            'Créer',
            style: TextStyle(
                color: Colors.white,
                fontSize: 11.5,
                letterSpacing: 0,
                fontWeight: FontWeight.w400),
          ),

        ),
        Expanded(child: Container())
      ],
    )
      ,));
  }
}


class NoTasks extends StatelessWidget {
  const NoTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center( child:
    Padding(padding: EdgeInsets.all(30), child :Column( mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: Container()),
        /*Icon(Icons.layers_clear_rounded , size: 35, color: text.withOpacity(0.5),),*/
        SvgPicture.asset(
          "icons/no-tasks.svg",
          color: text.withOpacity(0.5),
          width: 50,
          height: 50,

        ),
        SizedBox(height: 10,),
        Text(
          "Aucune tâche trouvée",
          style: TextStyle(
              color: text,
              fontSize: 17,
              letterSpacing: 0,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 10,),
        Flexible(child: Text(
          "Il n'y a aucune tâche à afficher pour vous, actuellement vous n'en avez pas mais vous pouvez en créer une nouvelle.",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: text.withOpacity(0.8),
              fontSize: 12.5,
              letterSpacing: 0,
              fontWeight: FontWeight.w500),
        ),),
        SizedBox(height: 20,),
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
          onPressed: (){},
          child: Text(
            'Créer',
            style: TextStyle(
                color: Colors.white,
                fontSize: 11.5,
                letterSpacing: 0,
                fontWeight: FontWeight.w400),
          ),

        ),
        Expanded(child: Container())
      ],
    )
      ,));
  }
}


class NoObjectives extends StatelessWidget {
  const NoObjectives({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center( child:
    Padding(padding: EdgeInsets.all(30), child :Column( mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: Container()),
        /*Icon(Icons.layers_clear_rounded , size: 35, color: text.withOpacity(0.5),),*/
        SvgPicture.asset(
          "icons/no-objective.svg",
          color: text.withOpacity(0.5),
          width: 50,
          height: 50,

        ),
        SizedBox(height: 10,),
        Text(
          "Aucun objectif trouvé",
          style: TextStyle(
              color: text,
              fontSize: 17,
              letterSpacing: 0,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 10,),
        Flexible(child: Text(
          "Il n'y a aucun objectif à afficher pour vous, actuellement vous n'en avez pas mais vous pouvez en créer un nouveau.",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: text.withOpacity(0.8),
              fontSize: 12.5,
              letterSpacing: 0,
              fontWeight: FontWeight.w500),
        ),),
        SizedBox(height: 20,),
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
          onPressed: (){},
          child: Text(
            'Créer',
            style: TextStyle(
                color: Colors.white,
                fontSize: 11.5,
                letterSpacing: 0,
                fontWeight: FontWeight.w400),
          ),

        ),
        Expanded(child: Container())
      ],
    )
      ,));
  }
}