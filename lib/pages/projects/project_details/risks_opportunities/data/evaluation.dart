import 'package:gestion_projets/pages/people/Data/user.dart';
import 'package:gestion_projets/pages/projects/project_details/risks_opportunities/data/calculation.dart';

class Evaluation {
  int id;
  String name;
  String description;
  DateTime creationDate;
  double minValue;
  double maxValue;
  User user;
  Formula formula;
  List<Calculation> calculations;

  Evaluation(this.id, this.creationDate, this.name, this.description,
      this.minValue, this.maxValue, this.user, this.calculations, this.formula);
}

class Formula {
  int id;
  String name;
  String formula;
  List<Criterion> criteria;

  Formula(this.id, this.name, this.formula, this.criteria);
}

class Criterion {
  int id;
  String name;
  String abbreviation;
  double value;

  Criterion(this.id, this.name, this.value, this.abbreviation);
}
