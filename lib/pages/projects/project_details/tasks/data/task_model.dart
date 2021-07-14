import 'package:gestion_projets/pages/projects/project_details/overview/data_layer/document.dart';
import 'package:gestion_projets/pages/projects/project_details/overview/data_layer/phase.dart' as Model;
import 'package:gestion_projets/pages/projects/project_details/overview/data_layer/user.dart';

class TaskModel {
  final int id;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  Model.Status status;
  final User user;
  final List<Document> documents;
  final Model.Priority priority;
  final List<TaskModel> subTasks;

  TaskModel(this.id, this.name, this.startDate, this.endDate, this.status, this.user, this.documents, this.priority, this.subTasks);

}



List<TaskModel> Tasks =
    [
      TaskModel(212, "Développement d'une nouvelle interface utilisateur", DateTime.now(), DateTime.now().add(Duration(days: 30)), Model.Status.completed, User(1,"Saidani Wael" , "https://i.imgur.com/01lxY0W.jpeg"), [], Model.Priority.Normal, [
        TaskModel(987, "Développement d'une nouvelle interface utilisateur", DateTime.now(), DateTime.now().add(Duration(days: 30)), Model.Status.completed, User(1,"Saidani Wael" , "3"), [], Model.Priority.Normal, []),
        TaskModel(265, "Développement d'une nouvelle interface utilisateur", DateTime.now(), DateTime.now().add(Duration(days: 20)), Model.Status.inProgress, User(1,"Saidani Wael" , "6"), [], Model.Priority.Normal, []),
      ]),
      TaskModel(45, "Développement d'une nouvelle interface utilisateur", DateTime.now(), DateTime.now().add(Duration(days: 68)), Model.Status.completed, User(1,"Saidani Wael" , "6"), [], Model.Priority.Normal, [
        TaskModel(785, "Développement d'une nouvelle interface utilisateur", DateTime.now(), DateTime.now().add(Duration(days: 17)), Model.Status.completed, User(1,"Saidani Wael" , "https://i.imgur.com/kieKRFZ.jpeg"), [], Model.Priority.Normal, []),
      ]),
      TaskModel(957, "Développement d'une nouvelle interface utilisateur", DateTime.now(), DateTime.now().add(Duration(days: 1)), Model.Status.completed, User(1,"Saidani Wael" , "3"), [], Model.Priority.Normal, [
        TaskModel(444, "Développement d'une nouvelle interface utilisateur", DateTime.now(), DateTime.now().add(Duration(days: 120)), Model.Status.completed, User(1,"Saidani Wael" , "https://i.imgur.com/01lxY0W.jpeg"), [], Model.Priority.Normal, []),
      ])
    ];