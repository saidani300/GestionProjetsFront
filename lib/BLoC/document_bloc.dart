import 'dart:async';

import 'package:gestion_projets/pages/projects/project_details/documents/data/document.dart'
    as doc;
import 'package:gestion_projets/pages/projects/project_details/documents/data/document.dart';
import 'package:gestion_projets/pages/projects/project_details/documents/data/document_filter_data.dart';
import 'package:gestion_projets/pages/projects/project_details/documents/data/folder.dart';
import 'package:gestion_projets/pages/projects/service/upload.dart';

import 'bloc.dart';

class DocumentBloc implements Bloc {
  final _controller = StreamController<List<Folder>>.broadcast();

  final _uploadController = StreamController<List<Folder>>.broadcast();

  final _api = APIUpload();

  Stream<List<Folder>> get documentStream => _controller.stream;

  Stream<List<Folder>> get uploadStream => _uploadController.stream;

  Future init() async {
    await Future.delayed(
        Duration(milliseconds: 300), () => _controller.sink.add(filter(documents)));
  }

  fetch() {
    _controller.sink.add(filter(documents));
  }

  removeFolder(Folder folder) async {
    documents.remove(folder);

    _controller.sink.add(filter(documents));
  }

  replaceAt(int oldItemIndex, int oldListIndex, int newItemIndex,
      int newListIndex) async {
    final movedItem =
        documents.elementAt(oldListIndex).documents.removeAt(oldItemIndex);
    documents.elementAt(newListIndex).documents.add(movedItem);
    _controller.sink.add(filter(documents));
  }

  addFolder(Folder folder) async {
    documents.add(folder);
    _controller.sink.add(filter(documents));
  }

  removeDocument(Folder folder, doc.Document document) async {
    folder.documents.remove(document);

    _controller.sink.add(filter(documents));
  }

  addDocument(Folder folder, doc.Document document) async {
    folder.documents.insert(0, document);
    _controller.sink.add(filter(documents));
  }

  documentUpload(doc.Document document, var bytes) async {
    await addDocument(
        documents.where((element) => element.id == 1).first, document);
    _controller.sink.add(filter(documents));
    if (!document.isUploaded) {
      await _api
          .uploadRequest(document, bytes)
          .whenComplete(() => document.isUploaded = true)
          .whenComplete(() => _controller.sink.add(filter(documents)));
    }
  }
//TODO : Fix Filter
  List<Folder> filter(List<Folder> initList) {
    List<Folder> result = List.from(initList);
    result.forEach((element) {
      element.documents =  search(element.documents).toList();
      element.documents = propertiesFilter(element.documents).toList();
      orderBy(element.documents);
    });
    print(documents.first.documents.length);
    return result;
  }

  List<Document> search(List<Document> list)
  {
    list = list
        .where((element) => element.name
        .toLowerCase()
        .contains(documentFilter.searchQuery.toLowerCase()))
        .toList();
    return list;
  }

  List<Document> propertiesFilter(List<Document> list)
  {
    if(documentFilter.allUsers== false)
      list = list.where((element) => documentFilter.users.contains(element.user)).toList();
    if(documentFilter.date)
      list = list.where((element) => element.creationDate.isAfter(documentFilter.startDate) && element.creationDate.isBefore(documentFilter.endDate)).toList();
    return list;
  }

  orderBy(List<Document> list)
  {
    switch(documentListOrder.orderBy)
    {
      case DocumentOrderByProperties.name:
        (documentListOrder.isAscending) ? list.sort((a, b) => a.name.compareTo(b.name)) :
        list.sort((a, b) => b.name.compareTo(a.name));
        break;
      case DocumentOrderByProperties.creationDate:
        (documentListOrder.isAscending) ? list.sort((a, b) => a.creationDate.compareTo(b.creationDate)) :
        list.sort((a, b) => b.creationDate.compareTo(a.creationDate));
        break;
      case DocumentOrderByProperties.user:
        (documentListOrder.isAscending) ? list.sort((a, b) => a.user.name.compareTo(b.user.name)) :
        list.sort((a, b) => b.user.name.compareTo(a.user.name));
        break;
      case DocumentOrderByProperties.size:
        (documentListOrder.isAscending) ? list.sort((a, b) => a.size.compareTo(b.size)) :
        list.sort((a, b) => b.size.compareTo(a.size));
        break;
    }
  }
  
  @override
  void dispose() {
    _controller.close();
  }
}
