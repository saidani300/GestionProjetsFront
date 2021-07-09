import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProjectDetailsMenuItem{

  String name;
  String icon;
  String page;
  bool isActive;

  ProjectDetailsMenuItem(this.name, this.icon, this.page, this.isActive);

}


List<ProjectDetailsMenuItem>  projectDetailsMenu = [
  ProjectDetailsMenuItem("Aperçu", /*Icons.account_tree_rounded*/ "icons/structure.svg", "/" , true),
  ProjectDetailsMenuItem("Tâches", /*Icons.task_alt*/ "icons/clipboard.svg", "/" , false),
  ProjectDetailsMenuItem("Objectifs", /*Icons.settings*/ "icons/goal.svg", "/" , false),
  ProjectDetailsMenuItem("Risques / Opportunités", /*Icons.compare_arrows_rounded*/ "icons/speedometer.svg", "/" , false),
  ProjectDetailsMenuItem("Réunions", /*Icons.group_work_outlined*/ "icons/calendar.svg", "/" , false),
  ProjectDetailsMenuItem("Documents", /*Icons.file_copy_outlined*/ "icons/file.svg", "/" , false),
];