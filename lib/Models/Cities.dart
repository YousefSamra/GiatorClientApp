
class Cities{
  var id;
  var locale;
  var city_id;
  var name;

  Cities({this.id, this.locale, this.city_id, this.name});

  factory Cities.fromJson(Map<String, dynamic> json) {
    return Cities(
        id: json['id'],
        locale: json['locale'],
        city_id: json['city_id'],
        name: json['name']);
  }
}