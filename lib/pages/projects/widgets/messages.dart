import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';

class NoResultFound extends StatelessWidget {
  const NoResultFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center( child:
        Padding(padding: EdgeInsets.all(30), child :Column( mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.search_off_rounded , size: 35, color: text.withOpacity(0.5),),
          SizedBox(height: 10,),
          Text(
            "Pas de résultat",
            style: TextStyle(
                color: text,
                fontSize: 17,
                letterSpacing: 0,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 10,),
          Expanded(child: Text(
            "Aucune correspondance trouvée pour votre recherche, vérifiez ou essayer des termes de recherche différents.",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: text.withOpacity(0.8),
                fontSize: 12.5,
                letterSpacing: 0,
                fontWeight: FontWeight.w500),
          ),)
        ],
      )
      ,));
  }
}

class NoProjects extends StatelessWidget {
  const NoProjects({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center( child:
    Padding(padding: EdgeInsets.all(30), child :Column( mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: Container()),
        Icon(Icons.layers_clear_rounded , size: 35, color: text.withOpacity(0.5),),
        SizedBox(height: 10,),
        Text(
          "Aucun projet trouvé",
          style: TextStyle(
              color: text,
              fontSize: 17,
              letterSpacing: 0,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 10,),
        Flexible(child: Text(
          "Il n'y a aucun projet à afficher pour vous, actuellement vous n'en avez pas mais vous pouvez en créer un nouveau.",
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


class NoCompletedProjects extends StatelessWidget {
  const NoCompletedProjects({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center( child:
    Padding(padding: EdgeInsets.all(30), child :Column( mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: Container()),
        Icon(Icons.layers_clear_rounded , size: 35, color: text.withOpacity(0.5),),
        SizedBox(height: 10,),
        Text(
          "Aucun projet terminé trouvé",
          style: TextStyle(
              color: text,
              fontSize: 17,
              letterSpacing: 0,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 10,),
        Expanded(child: Text(
          "Il n'y a aucun projet terminé à afficher pour vous, pas encore de projet marqué comme terminé.",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: text.withOpacity(0.8),
              fontSize: 12.5,
              letterSpacing: 0,
              fontWeight: FontWeight.w500),
        ),),
        Expanded(child: Container())
      ],
    )
      ,));
  }
}