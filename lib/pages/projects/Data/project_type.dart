class ProjectType {
  final int id;
  final String name;

  ProjectType(this.id, this.name);

  ProjectType.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}

final projectTypesList = [
  ProjectType(1, 'Développement'),
  ProjectType(2, 'Design'),
  ProjectType(3, 'Marketing financier'),
  ProjectType(4, 'Securité digitale'),
];
