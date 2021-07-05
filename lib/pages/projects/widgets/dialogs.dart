import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gestion_projets/constants/style.dart';

showDialogBox(BuildContext context, Function() onTap) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        actionsPadding: EdgeInsets.all(10),
        /* title: Text(
          "Supprimer",
          style: TextStyle(
              color: text.withOpacity(0.8),
              fontSize: 12.5,
              letterSpacing: 0,
              fontWeight: FontWeight.w500),
        ),*/
        content:Container(child :Column( mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset("icons/remove.svg" ,color: lightRed, width: 50, height: 50,),
              SizedBox(
                height: 20,
              ),
              Flexible( child: Text(
                "Voulez-vous vraiment supprimer ce projet ?",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: text,
                    fontSize: 14.5,
                    letterSpacing: 0,
                    fontWeight: FontWeight.w600),
              )),
              SizedBox(
                height: 10,
              ),
        Flexible( child: Text(
                "Ce projet sera définitivement supprimé et vous n'y aurez plus accès, le processus ne peut pas être annulé.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: text.withOpacity(0.8),
                    fontSize: 13,
                    letterSpacing: 0,
                    fontWeight: FontWeight.w500),
              )),
            ],


        )),
        actions: [
          OutlinedButton(
            style:
      OutlinedButton.styleFrom(
        fixedSize: Size(double.infinity, 34),
        onSurface: Colors.transparent,
        backgroundColor: Colors.transparent,
        primary: Colors.transparent,
        side: BorderSide(color: text.withOpacity(0.4), width: 1),
      ),

            child: Text(
              "Annuler",
              textAlign: TextAlign.end,
              style: TextStyle(
                  color: text,
                  fontSize: 11.5,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w500),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            autofocus: true,
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all<Color>(lightRed),

                fixedSize:
                    MaterialStateProperty.all<Size>(Size(double.infinity, 33)),
                // backgroundColor: MaterialStateProperty.all<Color>(active),
                backgroundColor:
                    MaterialStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(MaterialState.hovered)) {
                    return lightRed.withOpacity(0.9);
                  } else {
                    return lightRed;
                  }
                }),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(horizontal: 20, vertical: 16)),
              ),
              child: Text(
                "Continuer",
                textAlign: TextAlign.end,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 11.5,
                    letterSpacing: 0,
                    fontWeight: FontWeight.w500),
              ),
              onPressed: () {
                onTap();
                Navigator.of(context).pop();
                final snackBar = SnackBar(
                    behavior: SnackBarBehavior.fixed,
                    duration: Duration(milliseconds: 2000),
                    backgroundColor: dark.withOpacity(0.9),
                    content: Container(child :Row(children: [
                      SvgPicture.asset("icons/remove.svg" ,color: Colors.white, width: 20, height: 20,),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Le projet Développement d'une nouvelle interface utilisateur a été supprimé avec succès." , style : TextStyle(
                          color: light,
                          fontSize: 13,
                          letterSpacing: 0,
                          fontWeight: FontWeight.w400),
                      )],))
                ); ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }),
        ],
      );
    },
  );
}
