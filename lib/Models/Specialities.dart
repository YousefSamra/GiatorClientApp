
class Specialaties{
  var id;
  var locale;
  var speciality_id;
  var name;

  Specialaties({this.id, this.locale, this.speciality_id, this.name});

  factory Specialaties.fromJson(Map<String, dynamic> json) {
    return Specialaties(
        id: json['id'],
        locale: json['locale'],
        speciality_id: json['speciality_id'],
        name: json['name']);
  }
}