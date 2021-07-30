import 'dart:async';
import 'dart:html';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:gestion_projets/pages/projects/project_details/documents/data/document.dart' as doc;
import 'package:gestion_projets/pages/projects/project_details/documents/data/folder.dart';
import 'package:gestion_projets/pages/people/Data/user.dart';
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
        Duration(milliseconds: 300), () => _controller.sink.add(documents));
  }

  fetch() {
    _controller.sink.add(documents);
  }

  removeFolder(Folder folder) async {
    documents.remove(folder);

    _controller.sink.add(documents);
  }

  replaceAt(int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) async {
  final  movedItem =  documents.elementAt(oldListIndex).documents.removeAt(oldItemIndex);
    documents.elementAt(newListIndex).documents.add(movedItem);
    _controller.sink.add(documents);
  }

  
  addFolder(Folder folder) async {
    documents.add(folder);
    _controller.sink.add(documents);
  }

  removeDocument(Folder folder,doc.Document document) async {
    folder.documents.remove(document);

    _controller.sink.add(documents);
  }

  addDocument(Folder folder,doc.Document document) async {
    folder.documents.insert(0, document);
    _controller.sink.add(documents);
  }


  documentUpload(doc.Document document , var bytes) async
  {
    await addDocument(documents.where((element) => element.id == 1).first, document);
    _controller.sink.add(documents);
      if (!document.isUploaded){
      await  _api.uploadRequest(document, bytes).whenComplete(() => document.isUploaded = true).whenComplete(() => _controller.sink.add(documents));
      }
  }
  
  @override
  void dispose() {
    _controller.close();
  }
}

final documentBloc = DocumentBloc();
