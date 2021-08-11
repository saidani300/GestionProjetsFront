class CheckBoxItem {
  final String title;
  bool value;

  CheckBoxItem({required this.title, this.value = false});
}

final checkAll = CheckBoxItem(title: 'Tous');

final typesList = [
  CheckBoxItem(title: 'Développement', value: true),
  CheckBoxItem(title: 'Design'),
  CheckBoxItem(title: 'Marketing financier'),
  CheckBoxItem(title: 'Securité digitale'),
];

class CheckBoxItemLeader {
  final String name;
  final String profileImage;
  bool value;

  CheckBoxItemLeader({
    required this.name,
    this.value = false,
    this.profileImage = "1",
  });
}

final checkAllLeader = CheckBoxItemLeader(name: 'Tous');

final leaderList = [
  CheckBoxItemLeader(name: 'Saidani Wael', profileImage: "3"),
  CheckBoxItemLeader(name: 'Saidani Wael', profileImage: "3"),
  CheckBoxItemLeader(name: 'Saidani Wael', profileImage: "2"),
  CheckBoxItemLeader(name: 'Saidani Wael', profileImage: "2"),
  CheckBoxItemLeader(name: 'Saidani Wael', profileImage: "3"),
  CheckBoxItemLeader(name: 'Saidani Wael', profileImage: "3"),
  CheckBoxItemLeader(name: 'Saidani Wael', profileImage: "2"),
  CheckBoxItemLeader(name: 'Saidani Wael', profileImage: "2"),
];
