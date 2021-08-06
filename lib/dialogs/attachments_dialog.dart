import 'package:flutter/material.dart';
import 'package:gestion_projets/pages/projects/project_details/documents/data/document.dart';


import 'forms/attachments_form.dart';

attachmentsDialogBox(BuildContext context,List<Document> documents) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: EdgeInsets.all(0),
        actionsPadding: EdgeInsets.all(0),
        content: AttachmentsForm(documents: documents,),
      );
    },
  );
}