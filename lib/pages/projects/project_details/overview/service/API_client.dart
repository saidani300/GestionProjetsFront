import 'dart:async';
import 'dart:convert' show json;

import 'package:gestion_projets/pages/projects/project_details/overview/data/phase.dart';
import 'package:http/http.dart' as http;

class APIClient {
  Future<List<Phase>> fetchPhases() async {
    final results = await request();

    final phases = results['phases']
        .map<Phase>((json) => Phase.fromJson(json))
        .toList(growable: false);
    print(phases);
    return phases;
  }

  Future<Map> request() async {
    final uri =
        Uri.parse('https://mocki.io/v1/e198314b-c2e5-4111-a877-4e876c6fd84d');
    final results = await http.get(uri);
    final jsonObject = json.decode(results.body);
    print(jsonObject);
    return jsonObject;
  }
}
