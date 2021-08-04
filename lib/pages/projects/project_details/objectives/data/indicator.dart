import 'package:gestion_projets/pages/people/Data/user.dart';

import 'measure.dart';

enum Frequency {
  monthly, //mensuel
  quarterly, //trimestriel
  semiAnnually, //semestriel
  annually //annuel
}

String indicatorFrequencyAsText(Frequency frequency) {
  switch (frequency) {
    case Frequency.monthly:
      return 'Mensuel';
    case Frequency.quarterly:
      return 'Trimestriel';
    case Frequency.semiAnnually:
      return 'Semestriel';
    case Frequency.annually:
      return 'Annuel';
  }
}


enum IndicatorType
{
  type1,
  type2,
  type3,
}

String indicatorTypeAsText(IndicatorType type)
{
  switch(type)
  {
    case IndicatorType.type1 :
      return 'Type 1';
    case IndicatorType.type2 :
      return 'Type 2';
    case IndicatorType.type3 :
      return 'Type 3';
  }
}
enum Nature
{
  manual,
  automatic,
}

String natureAsText(Nature nature)
{
  switch(nature)
  {
    case Nature.manual:
      return 'Manuelle';
    case Nature.automatic:
      return 'Automatique';
  }
}
class Indicator {
  int id;
  String name;
  IndicatorType type;
  String calculationMethod;
  double minValue;
  double maxValue;
  double criticalThreshold;
  Nature nature;
  String unit;
  Frequency frequency;
  User user;
  List<Measure> measures;

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
    this.nature,
    this.unit,
    this.frequency,
  );
}
