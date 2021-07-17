import 'package:gestion_projets/pages/projects/project_details/overview/data_layer/document.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data_layer/user.dart';
import 'measure.dart';

enum Frequency{
  monthly,  //mensuel
  quarterly,  //trimestriel
  semiAnnually,  //semestriel
   annually   //annuel
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

  Indicator(this.id, this.name,
      this.user, this.measures, this.type, this.calculationMethod,
      this.minValue, this.maxValue, this.criticalThreshold, this.autoMeasure,
      this.unit, this.frequency,);

}

Indicator indicator = Indicator(302, "Nombre d'actions terminées", User(6,"Saidani Wael","7"), [
  Measure(5487, 55, DateTime.now(), DateTime.now(), DateTime.now().add(Duration(days: 90)), []),
  Measure(5548, 24, DateTime.now().subtract(Duration(days: 30)), DateTime.now().subtract(Duration(days: 30)), DateTime.now(), [Document(1, "document1")])
], "Avancement", "ATerminé/ATotal*100", 0, 100, 30, false, "%", Frequency.monthly);