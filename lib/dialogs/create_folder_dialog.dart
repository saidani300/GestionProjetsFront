import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gestion_projets/BLoC/bloc_provider.dart';
import 'package:gestion_projets/BLoC/document_bloc.dart';
import 'package:gestion_projets/pages/projects/project_details/documents/data/folder.dart';
import 'package:gestion_projets/widgets/toast.dart';

import 'forms/create_folder_form.dart';
import 'forms/widgets/buttons.dart';

createFolderDialogBox(BuildContext context, ScrollController controller) {
  Folder folder = new Folder(Random().nextInt(9999999), "", []);
  final bloc = BlocProvider.of<DocumentBloc>(context);
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: EdgeInsets.all(0),
        actionsPadding: EdgeInsets.all(10),
        content: CreateFolderForm(
          folder: folder,
        ),
        actions: [
          DialogOutlinedButton(
            onTap: () {
              Navigator.of(context).pop();
            },
            text: 'Annuler',
          ),
          SizedBox(
            width: 5,
          ),
          DialogButton(
              text: 'Créer',
              onTap: () async {
                Navigator.of(context).pop();
                bloc.addFolder(folder);
                if (controller.hasClients)
                  controller.animateTo(
                    controller.position.maxScrollExtent,
                    curve: Curves.fastOutSlowIn,
                    duration: const Duration(milliseconds: 300),
                  );
                showToast(ToastType.success, folder.name,
                    event: ToastEvent.create);
              }),
        ],
      );
    },
  );
}
