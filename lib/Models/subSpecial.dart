import 'package:flutter/cupertino.dart';

class SubSpecialist {
  int speciality_id;
  String speciality_name;
  int sub_speciality_id;
  String sub_speciality_name;

  SubSpecialist(
      {this.speciality_id,
      this.speciality_name,
      this.sub_speciality_id,
      this.sub_speciality_name});

  factory SubSpecialist.fromJson(Map<String, dynamic> json) {
    return SubSpecialist(
        speciality_id: json["speciality_id"],
        speciality_name: json["speciality_name"],
        sub_speciality_id: json["sub_speciality_id"],
        sub_speciality_name: json["sub_speciality_name"]);
  }
}
