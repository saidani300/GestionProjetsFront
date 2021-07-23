import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';

import 'body/documents.dart';

class ProjectDocuments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      child: DocumentsBody(),
    );
  }
}
