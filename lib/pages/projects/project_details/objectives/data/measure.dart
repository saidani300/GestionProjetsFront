

class Measure {
  int id;
  double value;
  DateTime creationDate;
  DateTime startDate;
  DateTime endDate;
  String comment;

  Measure(
    this.id,
    this.value,
    this.creationDate,
    this.startDate,
    this.endDate,
    this.comment,
  );
}

Measure measure = new Measure(5487, 50.5, DateTime.now(), DateTime.now(),
    DateTime.now().add(Duration(days: 90)), "");
