class Avaliability {
  String id;
  String name;
  Avaliability({this.id, this.name});

  factory Avaliability.fromJson(Map<String, dynamic> json) {
    return Avaliability(id: json['id'], name: json['name']);
  }
}
