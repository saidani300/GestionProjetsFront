class User {
  final int id;
  final String name;
  final String avatar;


  User.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        avatar = json['avatar'];
}
