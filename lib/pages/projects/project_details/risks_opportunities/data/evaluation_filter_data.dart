class EvaluationFilter {
  String searchQuery;
  EvaluationFilter(this.searchQuery);
}

EvaluationFilter evaluationFilter = EvaluationFilter("");

enum EvaluationOrderByProperties
{
  name,
  calculationsNumber,
  creationDate,
  user,
}

String evaluationOrderByAsText(EvaluationOrderByProperties evaluationOrderByProperties)
{
  switch(evaluationOrderByProperties)
  {
    case EvaluationOrderByProperties.name :
      return 'Nom';
    case EvaluationOrderByProperties.calculationsNumber :
      return "Nombre de calculs";
    case EvaluationOrderByProperties.creationDate :
      return "Date de création";
    case EvaluationOrderByProperties.user :
      return 'Responsable';
  }
}

class EvaluationListOrder
{
  bool isAscending;
  EvaluationOrderByProperties orderBy;

  EvaluationListOrder(this.isAscending, this.orderBy);
}

EvaluationListOrder evaluationListOrder = EvaluationListOrder(true, EvaluationOrderByProperties.creationDate);