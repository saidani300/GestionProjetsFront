import 'evaluation.dart';

class Calculation {
  int id;
  double score;
  DateTime creationDate;
  DateTime startDate;
  DateTime endDate;
  List<Criterion> criteria;

  Calculation(this.id, this.score, this.creationDate, this.startDate,
      this.endDate, this.criteria);
}
