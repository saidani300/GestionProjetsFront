import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gestion_projets/constants/style.dart';
import 'package:gestion_projets/dialogs/forms/create_project_form.dart';
import 'package:gestion_projets/pages/people/Data/user.dart';
import 'package:gestion_projets/pages/projects/Data/project.dart';
import 'package:gestion_projets/pages/projects/Data/project_type.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/project_bloc.dart';
import 'package:gestion_projets/pages/projects/project_details/structure/data/phase.dart';
import 'package:gestion_projets/widgets/toast.dart';
import 'package:get/get.dart';

import '../pages/projects/widgets/custom_icon_button.dart';
import 'forms/widgets/buttons.dart';

var createOther = false.obs;

enum DeleteType {
  project,
  phase,
  action,
  task,
  subtask,
  objective,
  indicator,
  measure,
  risk,
  opportunity,
  evaluation,
  calculation,
  folder,
  file,
  meeting,
  notification,
}

class DeleteMessage {
  final String title;
  final String text;

  DeleteMessage(this.title, this.text);
}

DeleteMessage deleteTypeAsText(DeleteType type) {
  switch (type) {
    case DeleteType.project:
      return DeleteMessage("Voulez-vous vraiment supprimer ce projet ?",
          "Ce projet sera définitivement supprimé et vous n'y aurez plus accès, le processus ne peut pas être annulé.");
    case DeleteType.phase:
      return DeleteMessage("Voulez-vous vraiment supprimer cette phase ?",
          "Cette phase sera définitivement supprimé et vous n'y aurez plus accès, toutes les actions et tâches de cette phase seront également supprimées.");
    case DeleteType.action:
      return DeleteMessage("Voulez-vous vraiment supprimer cette action ?",
          "Cette action sera définitivement supprimé et vous n'y aurez plus accès, toutes les tâches de cette action seront également supprimées.");
    case DeleteType.task:
      return DeleteMessage("Voulez-vous vraiment supprimer cette tâche ?",
          "Cette tâche sera définitivement supprimé et vous n'y aurez plus accès, toutes les sous-tâches seront également supprimées.");
    case DeleteType.subtask:
      return DeleteMessage("Voulez-vous vraiment supprimer cette sous-tâche ?",
          "Cette sous-tâche sera définitivement supprimé et vous n'y aurez plus accès.");
    case DeleteType.objective:
      return DeleteMessage("Voulez-vous vraiment supprimer ce objectif ?",
          "Ce objectif sera définitivement supprimé et vous n'y aurez plus accès, tous les indicateurs relevant de cet objectif et leurs mesures seront également supprimés.");
    case DeleteType.indicator:
      return DeleteMessage("Voulez-vous vraiment supprimer ce indicateur ?",
          "Ce indicateur sera définitivement supprimé et vous n'y aurez plus accès, toutes les mesures seront également supprimées.");
    case DeleteType.measure:
      return DeleteMessage("Voulez-vous vraiment supprimer cette mesure ?",
          "Cette mesure sera définitivement supprimé et vous n'y aurez plus accès.");
    case DeleteType.opportunity:
      return DeleteMessage("Voulez-vous vraiment supprimer cette opportunité ?",
          "Cette opportunité sera définitivement supprimé et vous n'y aurez plus accès, toutes les évaluations seront également supprimées.");
    case DeleteType.risk:
      return DeleteMessage("Voulez-vous vraiment supprimer ce risque ?",
          "Ce risque sera définitivement supprimé et vous n'y aurez plus accès, toutes les évaluations seront également supprimées.");
    case DeleteType.evaluation:
      return DeleteMessage("Voulez-vous vraiment supprimer cette évaluation ?",
          "Cette évaluation sera définitivement supprimé et vous n'y aurez plus accès, tous les calculs seront également supprimés.");
    case DeleteType.calculation:
      return DeleteMessage("Voulez-vous vraiment supprimer ce calcul ?",
          "Ce calcul sera définitivement supprimé et vous n'y aurez plus accès.");
    case DeleteType.folder:
      return DeleteMessage("Voulez-vous vraiment supprimer ce dossier ?",
          "Ce dossier sera définitivement supprimé et vous n'y aurez plus accès, tous les fichiers de ce dossier seront également supprimés.");
    case DeleteType.file:
      return DeleteMessage("Voulez-vous vraiment supprimer ce fichier ?",
          "Ce fichier sera définitivement supprimé et vous n'y aurez plus accès.");
    case DeleteType.meeting:
      return DeleteMessage("Voulez-vous vraiment supprimer cette réunion ?",
          "Cette réunion sera définitivement supprimé et vous n'y aurez plus accès.");
    case DeleteType.notification:
      return DeleteMessage("Voulez-vous vraiment supprimer toutes les notifications ?",
          "Toutes les notifications seront définitivement supprimées et vous n'y aurez plus accès.");
  }
}

deleteDialogBox(
    BuildContext context, Function() onTap, DeleteType type, String name) {
  DeleteMessage message = deleteTypeAsText(type);
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        actionsPadding: EdgeInsets.all(10),
        content: Container(
            constraints: BoxConstraints(maxWidth: 600),
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
                  message.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: text,
                      fontSize: 14,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w600),
                )),
                SizedBox(
                  height: 10,
                ),
                Flexible(
                    child: Text(
                  message.text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: text.withOpacity(0.8),
                      height: 1.5,
                      fontSize: 13,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w500),
                )),
              ],
            )),
        actions: [
          DialogOutlinedButton(
            text: 'Annuler',
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          DialogButton(
            onTap: () {
              onTap();
              showToast(ToastType.success, name, event: ToastEvent.delete);
              Navigator.of(context).pop();
            },
            text: 'Continuer',
            color: lightRed,
          )
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
                    color: white,
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
            color: dividerColor,
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
                SizedBox(
                  height: 20,
                ),
                Padding(
                    padding: EdgeInsets.only(left: 23),
                    child: Row(
                      children: [
                        Checkbox(
                            activeColor: active,
                            value: true,
                            onChanged: (value) {}),
                        Text(
                          "Exporter le fichier avec filtre",
                          style: textStyle_Text_12_500,
                        ),
                      ],
                    )),
                SizedBox(
                  height: 30,
                ),
                Divider(
                  height: 1,
                  color: dividerColor,
                )
              ])
        ]));
  }
}

class FileChoice extends StatelessWidget {
  final String fileIcon;
  final String fileName;
  final bool isSelected;

  const FileChoice(
      {Key? key,
      required this.fileIcon,
      required this.fileName,
      this.isSelected = false})
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
          color: white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(child: Container()),
                Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                        color: active, borderRadius: BorderRadius.circular(30)),
                    child: Container(
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(30)),
                        padding: EdgeInsets.all(1),
                        margin: EdgeInsets.all(1.5),
                        child: Container(
                            decoration: BoxDecoration(
                                color: isSelected ? active : Colors.transparent,
                                borderRadius: BorderRadius.circular(30))))),
                SizedBox(
                  width: 15,
                )
              ],
            ),
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
