class FeesRange {
  var id;
  String description;

  FeesRange({this.id, this.description});
  factory FeesRange.fromJson(Map<String, dynamic> json) {
    return FeesRange(id: json['id'], description: json['description']);
  }
}
