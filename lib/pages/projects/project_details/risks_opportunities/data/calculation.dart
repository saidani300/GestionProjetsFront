import 'evaluation.dart';

class Calculation {
  final int id;
  final String name;
  final double score;
  final DateTime creationDate;
  final DateTime startDate;
  final DateTime endDate;
  final List<Criterion> criteria;

  Calculation(this.id, this.score, this.creationDate, this.startDate,
      this.endDate, this.name, this.criteria);
}
