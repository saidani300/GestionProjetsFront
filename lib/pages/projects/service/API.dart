import 'dart:async';
import 'dart:convert' show json, utf8;

import 'package:gestion_projets/pages/projects/Data/project.dart';
import 'package:gestion_projets/pages/projects/project_details/meetings/data/meeting.dart';
import 'package:http/http.dart' as http;

class APIClient {
  Future<List<Project>> fetchProjects() async {
    final results = await request(
        'https://mocki.io/v1/a98d9067-f4c8-4e5c-9ded-bef62158a310');

    final projects = results['projects']
        .map<Project>((json) => Project.fromJson(json))
        .toList();
    return projects;
/*{"projects":[{"id":544,"name":"Développement d'une nouvelle interface utilisateur","type":"Développement","startDate":"2021-07-21T10:33:58.368","endDate":"2021-08-28T10:33:58.368","teamLeader":{"id":23,"name":"Saidani Wael","avatar":"3"},"status":0},{"id":59898,"name":"Développement d'une nouvelle interface utilisateur","type":"Développement","startDate":"2021-06-13T10:33:58.368","endDate":"2021-07-22T10:33:58.368","teamLeader":{"id":23,"name":"Saidani Wael","avatar":"3"},"status":1},{"id":5,"name":"Développement d'une nouvelle interface utilisateur","type":"Développement","startDate":"2021-06-01T10:33:58.368","endDate":"2021-06-13T10:33:58.368","teamLeader":{"id":23,"name":"Saidani Wael","avatar":"3"},"status":0},{"id":447,"name":"Développement d'une nouvelle interface utilisateur","type":"Développement","startDate":"2021-07-21T10:33:58.368","endDate":"2021-08-28T10:33:58.368","teamLeader":{"id":23,"name":"Saidani Wael","avatar":"3"},"status":0},{"id":87789,"name":"Développement d'une nouvelle interface utilisateur","type":"Développement","startDate":"2021-07-21T10:33:58.368","endDate":"2021-12-18T10:33:58.368","teamLeader":{"id":23,"name":"Saidani Wael","avatar":"3"},"status":1},{"id":55558888,"name":"Projet Qalitas","type":"Développement","startDate":"2021-07-21T10:33:58.368","endDate":"2021-12-18T10:33:58.368","teamLeader":{"id":23,"name":"Saidani Wael","avatar":"3"},"status":1}]}*/
  }

  Future<List<Meeting>> fetchMeetings() async {
    final results = await request(
        'https://mocki.io/v1/ff1158cd-6d22-42ab-94d5-8c021197a663');

    final meetings = results['meetings']
        .map<Meeting>((json) => Meeting.fromJson(json))
        .toList();
    return meetings;
    /*
    {"meetings":[{"id":1,"name":"Retard potentiel pour une tâche","date":"2021-08-03T13:12:07.783","comment":"","status":0,"participants":[{"id":1,"name":"Saidani Wael","avatar":"3"},{"id":3,"name":"Saidani Wael","avatar":"5"}],"relatedItems":[{"id":121,"name":"Retard potentiel pour une tâche","type":4},{"id":487,"name":"Développement d'une nouvelle interface utilisateur","type":2}],"documents":[]},{"id":455,"name":"Retard potentiel pour une tâche","date":"2021-08-03T13:12:07.783","comment":"","status":0,"participants":[{"id":1,"name":"Saidani Wael","avatar":"3"},{"id":3,"name":"Saidani Wael","avatar":"5"}],"relatedItems":[{"id":121,"name":"Retard potentiel pour une tâche","type":4},{"id":487,"name":"Développement d'une nouvelle interface utilisateur","type":3},{"id":47444,"name":"Développement d'une nouvelle interface utilisateur","type":5}],"documents":[]}]}
    */
  }

  Future<Map> request(String uriAsString) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'accept-language': "fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7",
    };
    final uri = Uri.parse(uriAsString);
    final results = await http.get(uri, headers: requestHeaders);
    final jsonObject = json.decode(utf8.decode(results.bodyBytes));
    print(jsonObject);
    return jsonObject;
  }
}
