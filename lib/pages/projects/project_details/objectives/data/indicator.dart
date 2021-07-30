import 'package:gestion_projets/pages/people/Data/user.dart';

import 'measure.dart';

enum Frequency {
  monthly, //mensuel
  quarterly, //trimestriel
  semiAnnually, //semestriel
  annually //annuel
}

class Indicator {
  final int id;
  final String name;
  final String type;
  final String calculationMethod;
  final double minValue;
  final double maxValue;
  final double criticalThreshold;
  final bool autoMeasure;
  final String unit;
  final Frequency frequency;
  final User user;
  final List<Measure> measures;

  Indicator(
    this.id,
    this.name,
    this.user,
    this.measures,
    this.type,
    this.calculationMethod,
    this.minValue,
    this.maxValue,
    this.criticalThreshold,
    this.autoMeasure,
    this.unit,
    this.frequency,
  );
}
