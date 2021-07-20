class Document {
  final int id;
  final String name;

  Document(
    this.id,
    this.name,
  );

  Document.fromJson(Map json)
      : id = json['id'],
        name = json['name'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
