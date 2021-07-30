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

List<User> users = [
  User(1,"Saidani Wael" , "https://i.imgur.com/01lxY0W.jpeg"),
  User(1,"Wael Saidani" , "2"),
  User(1,"Saidani Wael" , "4"),
  User(1,"Saidani Wael" , "https://i.imgur.com/kieKRFZ.jpeg"),
  User(1,"Saidani Wael" , "5"),
  User(1,"Saidani Wael" , "6"),
  User(1,"Saidani Wael" , "8"),
  User(1,"Saidani Wael" , "3"),
];