import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:gestion_projets/pages/projects/project_details/documents/data/document.dart';

class APIUpload {
  uploadRequest(Document document, Uint8List bytes) async {
    Dio dio = new Dio();
    var formData = FormData.fromMap({
      'source': MultipartFile.fromBytes(bytes,
          filename: document.name /*,contentType: MediaType('image', 'png')*/),
      'type': 'file',
      'action': 'upload',
      'timestamp': '1627037375690',
      'auth_token': '16cd27f6cc77db8841c9a659c73bddded4366fb1',
    });
    var response = await dio.post(
      'https://fr.imgbb.com/json',
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );
    print(response);
  }
}
