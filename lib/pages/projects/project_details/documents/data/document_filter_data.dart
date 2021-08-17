import 'package:gestion_projets/pages/people/Data/user.dart';


class DocumentFilter {
  bool allUsers;
  bool date;
  List<User> users;
  DateTime startDate;
  DateTime endDate;
  String searchQuery;
  DocumentFilter( this.allUsers, this.date, this.users, this.startDate, this.endDate, this.searchQuery);

}

DocumentFilter documentFilter = DocumentFilter(true, false, List.from(users),  DateTime(DateTime.now().year-1 , DateTime.now().month , DateTime.now().day),
    DateTime(DateTime.now().year+1 , DateTime.now().month  , DateTime.now().day) , "" );

enum DocumentOrderByProperties
{
  name,
  size,
  creationDate,
  user,
}

String documentOrderByAsText(DocumentOrderByProperties documentOrderByProperties)
{
  switch(documentOrderByProperties)
  {
    case DocumentOrderByProperties.name :
      return 'Nom';
    case DocumentOrderByProperties.size :
      return "Taille";
    case DocumentOrderByProperties.creationDate :
      return 'Date de création';
    case DocumentOrderByProperties.user :
      return "Ajouter par";
  }
}

class DocumentListOrder
{
  bool isAscending;
  DocumentOrderByProperties orderBy;

  DocumentListOrder(this.isAscending, this.orderBy);
}

DocumentListOrder documentListOrder = DocumentListOrder(true, DocumentOrderByProperties.name);