import 'dart:math';

import 'package:gestion_projets/pages/people/Data/user.dart';

class Document {
  final int id;
  final String name;
  String url;
  final String type;
  final User user;
  final DateTime creationDate;
  final int size;
  bool isUploaded;

  Document(this.id, this.name, this.url, this.type, this.user,
      this.creationDate, this.size,
      [this.isUploaded = true]);

  Document.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        url = json['url'],
        type = json['type'],
        user = User.fromJson(json['user']),
        creationDate = json['creationDate'],
        size = json['size'],
        isUploaded = json['isUploaded'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'url': url,
        'type': type,
        'user': user.toJson(),
        'creationDate': creationDate.toIso8601String(),
        'size': size,
        'isUploaded': isUploaded,
      };
}

String formatBytes(int bytes, int decimals) {
  if (bytes <= 0) return "0 B";
  const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  var i = (log(bytes) / log(1024)).floor();
  return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + ' ' + suffixes[i];
}
