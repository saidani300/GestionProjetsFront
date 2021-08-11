import 'package:gestion_projets/pages/people/Data/user.dart';

class Notification {
  final int id;
  final String text;
  final String itemName;
  final User user;
  final DateTime date;
  final bool isNew;

  Notification(
      this.id, this.text, this.itemName, this.user, this.date, this.isNew);
}

List<Notification> notifications = [
  Notification(
      1212,
      " a créé une nouvelle tâche ",
      "Développement d'une nouvelle interface utilisateur.",
      users.first,
      DateTime.now().subtract(Duration(minutes: 15)),
      false),
  Notification(
      987,
      " a créé une nouvelle tâche ",
      "Développement d'une nouvelle interface utilisateur.",
      users.elementAt(1),
      DateTime.now().subtract(Duration(hours: 1)),
      false),
  Notification(
      187,
      " a créé une nouvelle tâche ",
      "Développement d'une nouvelle interface utilisateur.",
      users.elementAt(3),
      DateTime.now().subtract(Duration(hours: 2)),
      false),
  Notification(
      25422,
      " a créé une nouvelle tâche ",
      "Développement d'une nouvelle interface utilisateur.",
      users.elementAt(4),
      DateTime.now().subtract(Duration(hours: 2)),
      false),
];
