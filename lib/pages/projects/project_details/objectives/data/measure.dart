import 'package:gestion_projets/pages/projects/project_details/overview/data/document.dart';

class Measure {
  final int id;
  final double value;
  final DateTime creationDate;
  final DateTime startDate;
  final DateTime endDate;
  final List<Document> documents;

  Measure(
    this.id,
    this.value,
    this.creationDate,
    this.startDate,
    this.endDate,
    this.documents,
  );
}

Measure measure = new Measure(5487, 50.5, DateTime.now(), DateTime.now(),
    DateTime.now().add(Duration(days: 90)), []);
