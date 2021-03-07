
class Regions{
  var id;
  var locale;
  var region_id;
  var name;

  Regions({this.id, this.locale, this.region_id, this.name});

  factory Regions.fromJson(Map<String, dynamic> json) {
    return Regions(
        id: json['id'],
        locale: json['locale'],
        region_id: json['region_id'],
        name: json['name']);
  }
}