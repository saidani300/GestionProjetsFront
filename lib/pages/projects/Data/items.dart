import 'package:flutter/material.dart';
import 'package:gestion_projets/constants/style.dart';

const AllName = "Tous";
const CompletedName = "Terminé";
const InProgressName = "En cours";

class showByStatusItem {
  final String name;

  showByStatusItem(this.name);
}


List<showByStatusItem> ShowByStatusItems = [
  showByStatusItem(AllName),
  showByStatusItem(CompletedName),
  showByStatusItem(InProgressName),
];

class PriorityItem {
  final String name;
  final IconData icon;
  final Color color;
  PriorityItem(this.name, this.icon, this.color);
}


List<PriorityItem> priorityItems = [
  PriorityItem("Élevée" , Icons.flag_rounded , lightRed ),
  PriorityItem("Normale",Icons.flag_rounded, active),
  PriorityItem("Basse", Icons.flag_outlined , text.withOpacity(0.65)),
];