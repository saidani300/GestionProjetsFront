import 'package:dio/dio.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/bloc_provider.dart';
import 'package:gestion_projets/pages/projects/project_details/BLoC/document_bloc.dart';
import 'package:gestion_projets/pages/projects/project_details/documents/data/document.dart';
import 'package:gestion_projets/pages/projects/project_details/documents/widgets/drop_zone.dart';
import 'package:http_parser/http_parser.dart';
class APIUpload {
  uploadRequest(Document document , Function update) async {
    Dio dio = new Dio();
    var formData = FormData.fromMap({
      'source': MultipartFile.fromBytes(bytes , filename: "file.png" /*,contentType: MediaType('image', 'png')*/),
      'type' : 'file',
      'action': 'upload',
      'timestamp': '1627037375690',
      'auth_token': '16cd27f6cc77db8841c9a659c73bddded4366fb1',
    });
    var response = await dio.post(
      'https://fr.imgbb.com/json', data: formData,  options: Options(contentType: 'multipart/form-data'),
      onSendProgress: (int sent, int total) {
       print('$sent $total');
       document.url = (sent/total).toString();
       update();
      },);
    print(response.data);
  }
}