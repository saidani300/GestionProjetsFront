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