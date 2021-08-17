enum IndicatorOrderByProperties
{
  measure,
  difference,
  startDate,
  endDate,
}

String indicatorOrderByAsText(IndicatorOrderByProperties indicatorOrderByProperties)
{
  switch(indicatorOrderByProperties)
  {
    case IndicatorOrderByProperties.measure :
      return 'Mesure';
    case IndicatorOrderByProperties.difference :
      return 'Écart';
    case IndicatorOrderByProperties.startDate :
      return 'Date de début';
    case IndicatorOrderByProperties.endDate :
      return "Date de fin";
  }
}

class IndicatorListOrder
{
  bool isAscending;
  IndicatorOrderByProperties orderBy;

  IndicatorListOrder(this.isAscending, this.orderBy);
}

IndicatorListOrder indicatorListOrder = IndicatorListOrder(true, IndicatorOrderByProperties.startDate);