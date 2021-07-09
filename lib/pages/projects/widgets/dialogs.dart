import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/pages/projects/forms/create_project_form.dart';
import 'package:get/get.dart';
import 'custom_icon_button.dart';
import 'form_widgets/custom_form_text_field.dart';

var createOther = false.obs;
showDialogBox(BuildContext context, Function() onTap) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        actionsPadding: EdgeInsets.all(10),
        content: Container(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              "icons/remove.svg",
              color: lightRed,
              width: 50,
              height: 50,
            ),
            SizedBox(
              height: 20,
            ),
            Flexible(
                child: Text(
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
            Flexible(
                child: Text(
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
            style: OutlinedButton.styleFrom(
              elevation: 0,
              fixedSize: Size(double.infinity, 34),
              backgroundColor: Colors.transparent,
              side: BorderSide(color: text.withOpacity(0.4), width: 1),
              splashFactory: NoSplash.splashFactory,
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
              // autofocus: true,
              style: ButtonStyle(
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
                    duration: Duration(milliseconds: 4000),
                    backgroundColor: dark.withOpacity(0.9),
                    content: Container(
                        child: Row(
                      children: [
                        SvgPicture.asset(
                          "icons/remove.svg",
                          color: lightRed,
                          width: 25,
                          height: 25,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Le projet Développement d'une nouvelle interface utilisateur a été supprimé avec succès.",
                          style: TextStyle(
                              color: light,
                              fontSize: 13,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    )));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }),
        ],
      );
    },
  );
}

showCreateProjectDialogBox(BuildContext context, Function() onTap) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: EdgeInsets.all(0),
        actionsPadding: EdgeInsets.all(20),
        content: CreateProjectForm(),
        actions: [
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              elevation: 0,
              fixedSize: Size(double.infinity, 34),
              backgroundColor: Colors.transparent,
              side: BorderSide(color: text.withOpacity(0.4), width: 1),
              splashFactory: NoSplash.splashFactory,
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
          SizedBox(
            width: 5,
          ),
          TextButton(
              autofocus: true,
              style: ButtonStyle(
                fixedSize:
                    MaterialStateProperty.all<Size>(Size(double.infinity, 33)),
                // backgroundColor: MaterialStateProperty.all<Color>(active),
                backgroundColor:
                    MaterialStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(MaterialState.hovered)) {
                    return active.withOpacity(0.9);
                  } else {
                    return active;
                  }
                }),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(horizontal: 20, vertical: 16)),
              ),
              child: Text(
                "Créer",
                textAlign: TextAlign.end,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 11.5,
                    letterSpacing: 0,
                    fontWeight: FontWeight.w500),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                onTap();
                final snackBar = SnackBar(
                    behavior: SnackBarBehavior.fixed,
                    duration: Duration(milliseconds: 4000),
                    backgroundColor: dark.withOpacity(0.9),
                    content: Container(
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "icons/check-circle.svg",
                              color: Colors.lightGreen,
                              width: 25,
                              height: 25,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              "Le projet Développement d'une nouvelle interface utilisateur a été créé avec succès.",
                              style: TextStyle(
                                  color: light,
                                  fontSize: 13,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        )));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }),
        ],
      );
    },
  );
}

showExportDialogBox(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: EdgeInsets.all(0),
        actionsPadding: EdgeInsets.all(20),
        content: SaveAsFileBody(),
        actions: [
          TextButton(
              autofocus: true,
              style: ButtonStyle(
                fixedSize:
                    MaterialStateProperty.all<Size>(Size(double.infinity, 33)),
                // backgroundColor: MaterialStateProperty.all<Color>(active),
                backgroundColor:
                    MaterialStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(MaterialState.hovered)) {
                    return active.withOpacity(0.9);
                  } else {
                    return active;
                  }
                }),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(horizontal: 20, vertical: 16)),
              ),
              child: Text(
                "Exporter",
                textAlign: TextAlign.end,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 11.5,
                    letterSpacing: 0,
                    fontWeight: FontWeight.w500),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ],
      );
    },
  );
}

class SaveAsFileBody extends StatelessWidget {
  const SaveAsFileBody({Key? key}) : super(key: key);

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
                  Icons.save_alt_rounded,
                  size: 20,
                  color: active,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Exporter",
                  style: TextStyle(
                      color: text, fontSize: 14, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  width: 6,
                ),
                CustomIconButton(
                    icon: Icons.info_outline,
                    message: 'Exporter sous forme de fichier',
                    onTap: () {})
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
                  FileChoice(

                    fileIcon: "icons/csv-file.svg",
                    fileName: "Fichier CSV",
                    isSelected: true,
                  ),
                  SizedBox(width: 30),
                  FileChoice(
                    fileIcon: "icons/xml-file.svg",
                    fileName: "Fichier XML",
                  ),
                  SizedBox(width: 30),
                ]),
                SizedBox(height: 20,),
                Padding(
                  padding: EdgeInsets.only(left: 23),
                  child: Row(children: [Checkbox(activeColor : active , value: true, onChanged: (value){}), Text(
                    "Exporter le fichier avec filtre",
                    style: TextStyle(
                        color: text,
                        fontSize: 12,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w500),
                  ),],)

                ),
                SizedBox(
                  height: 30,
                ),
                Divider(
                  height: 1,
                  color: dark.withOpacity(0.15),
                )
              ])
        ]));
  }
}

class FileChoice extends StatelessWidget {
  final String fileIcon;
  final String fileName;
  final bool isSelected;
  const FileChoice({Key? key, required this.fileIcon, required this.fileName , this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 130,
        width: 130,
        decoration: BoxDecoration(
          border: Border.all(color: lightGrey.withOpacity(0.3), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 0.5,
              blurRadius: 0.5,
              // offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(3),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 15,),
            Row(children: [Expanded(child: Container()),
    Container(
    height: 15,
    width: 15,
    decoration: BoxDecoration(
    color: active,
    borderRadius: BorderRadius.circular(30)),
    child: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30)),
      padding: EdgeInsets.all(1),
      margin: EdgeInsets.all(1.5),
      child: Container(
          decoration: BoxDecoration(
              color: isSelected ? active : Colors.transparent,
              borderRadius: BorderRadius.circular(30))
      ))),
              SizedBox(width: 15,)
      ],),
            Expanded(child: Container()),
            SvgPicture.asset(
              fileIcon,
              width: 35,
              height: 35,
              color: active,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              fileName,
              style: TextStyle(
                  color: text, fontSize: 11.5, fontWeight: FontWeight.w600),
              textAlign: TextAlign.start,
            ),
            Expanded(child: Container()),
          ],
        ));
  }
}
