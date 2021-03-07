class Genders {
  int id;
  String name;

  Genders({this.id, this.name});

  factory Genders.fromJson(Map<String, dynamic> json) {
    return Genders(id: json['id'], name: json['name']);
  }
}
