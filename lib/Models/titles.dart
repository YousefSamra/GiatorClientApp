class Titles {
  int id;
  String name;
  Titles({this.id, this.name});

  factory Titles.fromJson(Map<String, dynamic> json) {
    return Titles(id: json['id'], name: json['name']);
  }
}
