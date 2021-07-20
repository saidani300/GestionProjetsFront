import 'package:gestion_projets/pages/projects/project_details/overview/data/user.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/data/calculation.dart';

class Evaluation {
  final int id;
  final String name;
  final DateTime creationDate;
  final double minValue;
  final double maxValue;
  final User user;
  final Formula formula;
  final List<Calculation> calculations;

  Evaluation(this.id, this.creationDate, this.name, this.minValue,
      this.maxValue, this.user, this.calculations, this.formula);
}

class Formula {
  final int id;
  final String name;
  final String formula;
  final List<Criterion> criteria;

  Formula(this.id, this.name, this.formula, this.criteria);
}

class Criterion {
  final int id;
  final String name;
  final String abbreviation;
  final double value;

  Criterion(this.id, this.name, this.value, this.abbreviation);
}
