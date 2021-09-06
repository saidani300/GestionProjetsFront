class User {
  final int id;
  final String name;
  final String avatar;
  final String email;
  final String role;
  final DateTime addDate;
  User(this.id, this.name, this.avatar, this.email, this.role, this.addDate);

  User.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        avatar = json['avatar'],
        email = json['email'],
        role = json['role'],
        addDate = json['addDate'];
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'avatar': avatar,
    'email': email,
    'role': role,
    'addDate': addDate,
      };
}

List<User> users = [
  User(1, "Saidani Wael", "https://i.imgur.com/01lxY0W.jpeg", "saidaniwael@qalitas.com" , "Chef de projet" , DateTime.now().subtract(Duration(days: 125))),
  User(2, "Wael Saidani", "2", "waelsaidani@qalitas.com" , "Membre" , DateTime.now().subtract(Duration(days: 13))),
  User(3, "Saidani Wael", "4", "saidaniwael@qalitas.com" , "Membre" , DateTime.now().subtract(Duration(days: 50))),
  User(4, "Saidani Wael", "https://i.imgur.com/kieKRFZ.jpeg", "saidaniwael@qalitas.com" , "Chef de projet" , DateTime.now().subtract(Duration(days: 30))),
  User(5, "Saidani Wael", "5", "saidaniwael@qalitas.com" , "Membre" , DateTime.now().subtract(Duration(days: 200))),
  User(6, "Saidani Wael", "6", "saidaniwael@qalitas.com" , "Membre" , DateTime.now().subtract(Duration(days: 220))),
  User(7, "Saidani Wael", "8", "saidaniwael@qalitas.com" , "Membre" , DateTime.now().subtract(Duration(days: 875))),
  User(8, "Saidani Wael", "3", "saidaniwael@qalitas.com" , "Membre" , DateTime.now().subtract(Duration(days: 69))),
];
