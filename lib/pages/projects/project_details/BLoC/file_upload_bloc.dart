import 'dart:async';

import 'package:gestion_projets/pages/projects/project_details/documents/data/document.dart';
import 'package:gestion_projets/pages/projects/service/upload.dart';

import 'bloc.dart';

class UploadBloc implements Bloc {
  final _controller = StreamController<List<Document>>.broadcast();

  final _api = APIUpload();
  Stream<List<Document>> get uploadStream => _controller.stream;


  fetch(List<Document> documents) {
    _controller.sink.add(documents);
  }


  removeDocument(List<Document> documents,Document document) async {
    documents.remove(document);

    _controller.sink.add(documents);
  }

  addDocument(List<Document> documents, Document document) async {
    documents.insert(0, document);
    _controller.sink.add(documents);
  }


  documentUpload(List<Document> documents,Document document , var bytes) async
  {
    await addDocument(documents, document);
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