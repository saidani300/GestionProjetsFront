class User {
  final int id;
  final String name;
  final String avatar;

  User(this.id, this.name, this.avatar);

  User.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        avatar = json['avatar'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'avatar': avatar,
      };
}
